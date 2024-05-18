import 'package:kovalingo/datas/analyses_data/read_word_list.dart';
import 'dart:convert';


class WordReader {
  AnalysesReader wordReader = AnalysesReader();

  addItemToAnalyses(String trWord, String enWord, String trSentence, String enSentence,int level,DateTime lastDate, String prodName, int prodQuantity) async {
    await addItemToWordListJson(trWord,enWord,trSentence,enSentence, level, lastDate,prodName,prodQuantity);
  }

  Future<void> addItemToWordListJson(String trWord, String enWord, String trSentence, String enSentence,int level,DateTime lastDate, String prodName, int prodQuantity) async {
    try {
      Map<String, dynamic>? rawData = await wordReader.getRawData();

      DateTime date = DateTime.now();
      String dateNow = "${date.day}.${date.month}.${date.year}";

      if (rawData != null) {

        await wordReader.writeJsonData(jsonEncode(rawData));
      }
    } catch (e) {
      print('Ürün analizi eklenirken hata oluştu: $e');
    }
  }
}
