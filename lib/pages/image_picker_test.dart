import 'package:flutter/material.dart';
import 'package:kovalingo/words/reset_word.dart';
import 'package:kovalingo/words/write_word.dart';

import '../words/read_word_list.dart';

class PickImage extends StatefulWidget {
  const PickImage({super.key});

  @override
  State<PickImage> createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  ReadWord readWord = ReadWord();
  ResetWord resetWord = ResetWord();
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
              child: Text("resetle")),
          ElevatedButton(
              onPressed: () async {
                int wordCount = await readWord.getTotalWordCount();
                print(wordCount);
              },
              child: Text("adet")),
        ],
      )),
    );
  }
}
