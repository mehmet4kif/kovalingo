import 'package:kovalingo/words/read_word_list.dart';
import 'package:intl/intl.dart';

class QuizBrain {
  ReadWord readWord = ReadWord();

  Future<List<dynamic>> getQuizWords() async {
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
        Duration minimumDuration = Duration.zero; // Seviyesi 0 olan kelimeler için direkt seçilebilir
        switch (level) {
          case 1:
            minimumDuration = Duration(days: 1);
            break;
          case 2:
            minimumDuration = Duration(days: 7);
            break;
          case 3:
            minimumDuration = Duration(days: 30);
            break;
          case 4:
            minimumDuration = Duration(days: 90);
            break;
          case 5:
            minimumDuration = Duration(days: 180);
            break;
          case 6:
            minimumDuration = Duration(days: 365);
            break;
        }

        // Eğer seviyeye göre yeterli süre geçmişse veya seviye 0 ise, kelimeyi seçin
        if (level == 0 || difference.compareTo(minimumDuration) >= 0) {
          selectedWords.add(word);
        }
      }

      return selectedWords;
    } else {
      return []; // rawList null ise boş bir liste döndür
    }
  }
}
