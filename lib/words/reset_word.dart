import 'package:kovalingo/words/read_word_list.dart';

class ResetWord {
  ReadWord readWord = ReadWord();

  Future<void> resetAllWords() async {
    try {
      await readWord.writeJsonData(
          '{"words": [{"trWord": "test0", "enWord": "test0", "trSentence": "test0.", "enSentence": "I am eating an apple.", "level": 0, "lastDate": "20.5.2024", "imagePath": "/assets/images/apple.jpg"},{"trWord": "Sure Okey", "enWord": "test1Calis", "trSentence": "Ben bir elma yiyorum.", "enSentence": "I am eating an apple.", "level": 1, "lastDate": "20.5.2024", "imagePath": "/assets/images/apple.jpg"},{"trWord": "sureYanlis", "enWord": "test1Yanlis", "trSentence": "Ben bir elma yiyorum.", "enSentence": "I am eating an apple.", "level": 1, "lastDate": "22.5.2024", "imagePath": "/assets/images/apple.jpg"},{"trWord": "sureOkey", "enWord": "level2Okey", "trSentence": "Ben bir elma yiyorum.", "enSentence": "I am eating an apple.", "level": 2, "lastDate": "10.5.2024", "imagePath": "/assets/images/apple.jpg"},{"trWord": "sureYanlis", "enWord": "level2Yanlis", "trSentence": "Ben bir elma yiyorum.", "enSentence": "I am eating an apple.", "level": 2, "lastDate": "27.5.2024", "imagePath": "/assets/images/apple.jpg"}]}');

      print("Tüm kelime verileri sıfırlandı");
    } catch (e) {
      print("Kelime verilerini sıfırlarken bir hata oluştu: $e");
    }
  }
}



/*class ResetWord {
  ReadWord readWord = ReadWord();

  Future<void> resetAllWords() async {
    try {
      await readWord.writeJsonData('{"words": {}}');
      print("Tüm kelime verileri sıfırlandı");
    } catch (e) {
      print("Kelime verilerini sıfırlarken bir hata oluştu: $e");
    }
  }
}
*/