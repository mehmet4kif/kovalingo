import 'package:kovalingo/words/read_word_list.dart';

class ResetWord {
  ReadWord readWord = ReadWord();

  Future<void> resetAllWords() async {
    try {
      await readWord.writeJsonData('{"words": {}}');
    } catch (e) {
      print("Kelime verilerini sıfırlarken bir hata oluştu: $e");
    }
  }
}
