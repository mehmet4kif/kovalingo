import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'dart:io';

class AnalysesReader {
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
      print('Veri okuma hatası: $e');
      return null; // Hata durumunda null döndürün
    }
  }

  Future<void> writeJsonData(String jsonData) async {
    final file = await returnFile();

    try {
      await file?.writeAsString(jsonData);
      print("Başarılı");
    } catch (e) {
      print('JSON data write error: $e');
    }
  }

  Future<Map<String, dynamic>?> getRawData() async {
    try {
      File file = await _localFile;
      if (file != null && await file.exists()) {
        String content = await file.readAsString();
        if (content.isNotEmpty) {
          return jsonDecode(content);
        }
      }
    } catch (e) {
      print('Veri okuma hatası: $e');
    }
    return null;
  }
}
