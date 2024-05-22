import 'dart:convert';

import 'package:kovalingo/words/read_word_list.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizBrain {
  ReadWord readWord = ReadWord();

  Future<List<dynamic>> getQuizWords(int questionCount) async {
    List<dynamic>? rawList = await readWord.getWordList();

    if (rawList != null) {
      List<dynamic> selectedWords = [];
      DateTime now = DateTime.now();

      // DateFormat with custom pattern
      DateFormat dateFormat = DateFormat('d.M.yyyy');

      for (var word in rawList) {
        int level = word['level'];
        DateTime lastDate;

        try {
          lastDate = dateFormat.parse(word['lastDate']);
        } catch (e) {
          print('Error parsing date: ${word['lastDate']}, error: $e');
          continue; // Skip this word if date parsing fails
        }

        // Seviyeye göre tarih farkını hesaplayın
        Duration difference = now.difference(lastDate);

        // Seviyeye göre gereken minimum süreyi belirleyin
        Duration minimumDuration =
            Duration.zero; // Seviyesi 0 olan kelimeler için direkt seçilebilir
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

        // Eğer seviyeye göre yeterli süre geçmişse veya seviye 0 ise, kelimeyi seçin
        if (level == 0 || difference.compareTo(minimumDuration) >= 0) {
          selectedWords.add(word);
        }
      }

      // İstenen soru sayısından fazla kelime varsa, rastgele seçim yapın
      if (selectedWords.length > questionCount) {
        selectedWords.shuffle();
        selectedWords = selectedWords.take(questionCount).toList();
      }

      return selectedWords;
    } else {
      return []; // rawList null ise boş bir liste döndür
    }
  }

  Future<void> falseAnswer(String selectedWord) async {
    try {
      // Get the raw data
      List<dynamic>? rawData = await readWord.getWordList();
      DateTime now = DateTime.now();

      if (rawData != null) {
        // Iterate over the raw data and update the word if found
        for (var word in rawData) {
          if (word["enWord"] == selectedWord) {
            print("içinde bulunuduğumuz kelime grubu $word \n*\n");
            // If the word level is not 0, reset it to 0 and update the date
            if (word["level"] != 0) {
              word["level"] = 0;
              word["lastDate"] = "${now.day}.${now.month}.${now.year}";
            } else {
              // If the level is already 0, just update the date
              word["lastDate"] = "${now.day}.${now.month}.${now.year}";
            }
          }
        }

        // Write the updated data back to the JSON file
        Map<String, dynamic> updatedData = {'words': rawData};
        await readWord.writeJsonData(jsonEncode(updatedData));
        await updateAnalyses("falseAnswers");
      } else {
        print("rawData is null");
      }
    } catch (e) {
      print("An error occurred: $e");
    }
    print("writeTable başarı ile tamamlandı");
  }

  Future<void> correctAnswer(String selectedWord) async {
    try {
      // Get the raw data
      List<dynamic>? rawData = await readWord.getWordList();
      DateTime now = DateTime.now();

      if (rawData != null) {
        // Iterate over the raw data and update the word if found
        List<dynamic> wordsToRemove = [];

        for (var word in rawData) {
          if (word["enWord"] == selectedWord) {
            print("içinde bulunuduğumuz kelime grubu $word \n*\n");

            if (word["level"] < 6) {
              word["level"] += 1;
              word["lastDate"] = "${now.day}.${now.month}.${now.year}";
            } else {
              wordsToRemove.add(word);
              await updateAnalyses("completedWords");
            }
          }
        }

        // Remove words that reached level 6
        rawData.removeWhere((word) => wordsToRemove.contains(word));

        // Write the updated data back to the JSON file
        Map<String, dynamic> updatedData = {'words': rawData};
        await readWord.writeJsonData(jsonEncode(updatedData));
        await updateAnalyses("correctAnswers");
      } else {
        print("rawData is null");
      }
    } catch (e) {
      print("An error occurred: $e");
    }
    print("writeTable başarı ile tamamlandı");

  }

  Future<void> updateAnalyses(String analysesType) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int oldValue = prefs.getInt(analysesType) ?? 0;
    prefs.setInt(analysesType, (oldValue + 1));
  }
}
