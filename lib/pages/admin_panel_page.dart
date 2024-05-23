import 'package:kovalingo/classes/word_packages_class.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kovalingo/words/quizBrain.dart';
import 'package:kovalingo/words/reset_word.dart';
import 'package:kovalingo/words/write_word.dart';
import 'package:flutter/material.dart';

import '../words/read_word_list.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  ReadWord readWord = ReadWord();
  WriteWord writeWord = WriteWord();
  ResetWord resetWord = ResetWord();
  QuizBrain quizBrain = QuizBrain();
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
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    var datas = await readWord.getWordList();
                    print(datas);
                  },
                  child: const Text("Oku"),
                ),
                ElevatedButton(
                  onPressed: () {
                    resetWord.resetAllWords();
                  },
                  child: const Text("resetle"),
                ),
                ElevatedButton(
                  onPressed: () {
                    resetWord.loadTestData();
                  },
                  child: const Text("testVerisiYükle"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    int wordCount = await readWord.getTotalWordCount();
                    print(wordCount);
                  },
                  child: const Text("adet"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    writeWord.addItemPack(wordPackages.defaultItems);
                  },
                  child: const Text("paket"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final SharedPreferences prefs = await SharedPreferences.getInstance();
                    int? questionCount = prefs.getInt("questionCount");
                    print('Seçilen sayı: $questionCount');
                  },
                  child: const Text("oku"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setInt("questionCount", 5);
                  },
                  child: const Text("yaz 5 "),
                ),
              ],
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    QuizBrain quizBrain = QuizBrain();
                    List<dynamic> taren = await quizBrain.getQuizWords(5);
                    print(taren);
                  },
                  child: const Text("readWord GetWordList"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    quizBrain.falseAnswer("test1Calis");
                  },
                  child: const Text("falseAnswer"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
