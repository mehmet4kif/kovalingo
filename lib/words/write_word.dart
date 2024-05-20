import 'package:kovalingo/words/read_word_list.dart';
import 'dart:convert';

import '../classes/wordData.dart';

class WriteWord {
  ReadWord wordReader = ReadWord();

  addItemToWordList(WordData wordData) async {
    await addItemToWordListJson(wordData);
  }

  Future<void> addItemToWordListJson(WordData wordData) async {
    try {
      List<dynamic>? wordList = await wordReader.getWordList();

      // Get the current date
      DateTime now = DateTime.now();
      String formattedDate = "${now.day}.${now.month}.${now.year}";

      // Create the new word entry
      Map<String, dynamic> newWordEntry = {
        'trWord': wordData.turkishWord,
        'enWord': wordData.englishWord,
        'trSentence': wordData.turkishSentence,
        'enSentence': wordData.englishSentence,
        'level': 0,
        'lastDate': formattedDate,
        'imagePath': wordData.imagePath,
      };

      // If wordList is null, initialize it as an empty list
      wordList ??= [];

      // Add the new entry to the list
      wordList.add(newWordEntry);

      // Write the updated data back to the JSON file
      Map<String, dynamic> updatedData = {'words': wordList};
      await wordReader.writeJsonData(jsonEncode(updatedData));
    } catch (e) {
      print('Ürün analizi eklenirken hata oluştu: $e');
    }
  }
}
