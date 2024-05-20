import 'package:flutter/material.dart';
import 'package:kovalingo/classes/word_packages_class.dart';
import 'package:kovalingo/words/reset_word.dart';
import 'package:kovalingo/words/write_word.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../words/read_word_list.dart';

class PickImage extends StatefulWidget {
  const PickImage({super.key});

  @override
  State<PickImage> createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  ReadWord readWord = ReadWord();
  WriteWord writeWord =  WriteWord();
  ResetWord resetWord = ResetWord();
  WordPackages wordPackages = WordPackages();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test'),
      ),
      body: Center(
          child: Column(
        children: [
          ElevatedButton(
              onPressed: () async {
                var datas = await readWord.getWordList();
                print(datas);
              },
              child: const Text("Oku")),
          ElevatedButton(
              onPressed: () {
                resetWord.resetAllWords();
              },
              child: const Text("resetle")),
          ElevatedButton(
              onPressed: () async {
                int wordCount = await readWord.getTotalWordCount();
                print(wordCount);
              },
              child: const Text("adet")),
          ElevatedButton(
              onPressed: () async {
                writeWord.addItemPack(wordPackages.defaultItems);
              },
              child: const Text("paket")),
          ElevatedButton(
              onPressed: () async {
                final SharedPreferences prefs =
                await SharedPreferences.getInstance();
                int? questionCount = prefs.getInt("questionCount");
                print(
                    'Seçilen sayı: $questionCount');
              },
              child: const Text("oku")),
          ElevatedButton(
              onPressed: () async {
                final SharedPreferences prefs =
                await SharedPreferences.getInstance();

                prefs.setInt("questionCount",5);
              },
              child: const Text("yaz 5 ")),
        ],
      )),
    );
  }
}
