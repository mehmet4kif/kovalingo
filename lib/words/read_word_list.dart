import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'dart:io';

class ReadWord {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = join(await _localPath, 'words.json');
    return File(path);
  }

  Future<File?> returnFile() async {
    try {
      File file = await _localFile;
      return file;
    } catch (e) {
      return null;
    }
  }

  Future<void> writeJsonData(String jsonData) async {
    final file = await returnFile();

    try {
      await file?.writeAsString(jsonData);
    } catch (e) {
      null;
    }
  }

  Future<List<dynamic>?> getWordList() async {
    try {
      File file = await _localFile;
      if (await file.exists()) {
        String content = await file.readAsString();
        if (content.isNotEmpty) {
          Map<String, dynamic> rawData = jsonDecode(content);
          if (rawData.containsKey('words') && rawData['words'] is List) {
            return rawData['words'];
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Veri okuma hatası: $e');
      }
    }
    return null;
  }

  Future<int> getTotalWordCount() async {
    try {
      List<dynamic>? wordList = await getWordList();
      if (wordList != null) {
        return wordList.length;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Kelime sayısı alınırken hata oluştu: $e');
      }
    }
    return 0;
  }

}