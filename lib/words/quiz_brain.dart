import 'package:shared_preferences/shared_preferences.dart';
import 'package:kovalingo/words/read_word_list.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

class QuizBrain {
  ReadWord readWord = ReadWord();

  Future<List<dynamic>> getQuizWords(int questionCount) async {
    List<dynamic>? rawList = await readWord.getWordList();

    if (rawList != null) {
      List<dynamic> selectedWords = [];
      DateTime now = DateTime.now();

      DateFormat dateFormat = DateFormat('d.M.yyyy');

      for (var word in rawList) {
        int level = word['level'];
        DateTime lastDate;

        try {
          lastDate = dateFormat.parse(word['lastDate']);
        } catch (e) {
          continue;
        }

        Duration difference = now.difference(lastDate);

        Duration minimumDuration =
            Duration.zero;
        switch (level) {
          case 1:
            minimumDuration = const Duration(days: 1);
            break;
          case 2:
            minimumDuration = const Duration(days: 7);
            break;
          case 3:
            minimumDuration = const Duration(days: 30);
            break;
          case 4:
            minimumDuration = const Duration(days: 90);
            break;
          case 5:
            minimumDuration = const Duration(days: 180);
            break;
          case 6:
            minimumDuration = const Duration(days: 365);
            break;
        }

        if (level == 0 || difference.compareTo(minimumDuration) >= 0) {
          selectedWords.add(word);
        }
      }

      if (selectedWords.length > questionCount) {
        selectedWords.shuffle();
        selectedWords = selectedWords.take(questionCount).toList();
      }

      return selectedWords;
    } else {
      return [];
    }
  }

  Future<void> falseAnswer(String selectedWord) async {
    try {
      List<dynamic>? rawData = await readWord.getWordList();
      DateTime now = DateTime.now();

      if (rawData != null) {

        for (var word in rawData) {
          if (word["enWord"] == selectedWord) {
            if (word["level"] != 0) {
              word["level"] = 0;
              word["lastDate"] = "${now.day}.${now.month}.${now.year}";
            } else {
              word["lastDate"] = "${now.day}.${now.month}.${now.year}";
            }
          }
        }

        Map<String, dynamic> updatedData = {'words': rawData};
        await readWord.writeJsonData(jsonEncode(updatedData));
        await updateAnalyses("falseAnswers");
      } else {}
    } catch (e) {null;}
  }

  Future<void> correctAnswer(String selectedWord) async {
    try {
      List<dynamic>? rawData = await readWord.getWordList();
      DateTime now = DateTime.now();

      if (rawData != null) {

        List<dynamic> wordsToRemove = [];

        for (var word in rawData) {
          if (word["enWord"] == selectedWord) {

            if (word["level"] < 6) {
              word["level"] += 1;
              word["lastDate"] = "${now.day}.${now.month}.${now.year}";
            } else {
              wordsToRemove.add(word);
              await updateAnalyses("completedWords");
            }
          }
        }

        rawData.removeWhere((word) => wordsToRemove.contains(word));
        Map<String, dynamic> updatedData = {'words': rawData};
        await readWord.writeJsonData(jsonEncode(updatedData));
        await updateAnalyses("correctAnswers");
      } else {
      }
    } catch (e) {
      null;
    }
  }

  Future<void> updateAnalyses(String analysesType) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int oldValue = prefs.getInt(analysesType) ?? 0;
    prefs.setInt(analysesType, (oldValue + 1));
  }
}
