import 'package:flutter/foundation.dart';
import 'package:kovalingo/words/read_word_list.dart';
import '../classes/word_data_class.dart';
import 'dart:convert';

class WriteWord {
  ReadWord readWord = ReadWord();

  addItemToWordList(WordData wordData) async {
    await addItemToWordListJson(wordData);
  }

  Future<void> addItemToWordListJson(WordData wordData) async {
    try {
      List<dynamic>? wordList = await readWord.getWordList();


      DateTime now = DateTime.now();
      String formattedDate = "${now.day}.${now.month}.${now.year}";

      Map<String, dynamic> newWordEntry = {
        'trWord': wordData.turkishWord,
        'enWord': wordData.englishWord,
        'trSentence': wordData.turkishSentence,
        'enSentence': wordData.englishSentence,
        'level': 0,
        'lastDate': formattedDate,
        'imagePath': wordData.imagePath,
      };

      wordList ??= [];

      wordList.add(newWordEntry);

      Map<String, dynamic> updatedData = {'words': wordList};
      await readWord.writeJsonData(jsonEncode(updatedData));
    } catch (e) {
      if (kDebugMode) {
        print('Ürün analizi eklenirken hata oluştu: $e');
      }
    }
  }

  Future<void> addItemPack(List<WordData> wordList) async {
    try {
      for (WordData wordData in wordList) {
        await addItemToWordListJson(wordData);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Kelime paketi eklenirken hata oluştu: $e');
      }
    }
  }


}
