import 'package:flutter/material.dart';
import 'package:kovalingo/constants/colors.dart';
import 'package:kovalingo/constants/styles.dart';
import 'package:kovalingo/words/read_word_list.dart';

class MyWords extends StatelessWidget {
  const MyWords({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundBlue,
      appBar: AppBar(
        title: const Text('Kelimelerim'),
        backgroundColor: CustomColors.appBarBlue,
      ),
      body: FutureBuilder<List<dynamic>?>(
        future: ReadWord().getWordList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Hata: ${snapshot.error}'),
            );
          } else {
            final wordList = snapshot.data;
            if (wordList == null || wordList.isEmpty) {
              return const Center(
                child: Text('Hiç kelimeniz yok.'),
              );
            } else {
              return ListView.builder(
                itemCount: (wordList.length / 2).ceil(),
                itemBuilder: (context, index) {
                  final rowIndex = index * 2;
                  final firstWordData = wordList[rowIndex];
                  final secondWordData = rowIndex + 1 < wordList.length ? wordList[rowIndex + 1] : null;

                  return Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _buildWordTile(firstWordData),
                        ),
                      ),
                      if (secondWordData != null)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: _buildWordTile(secondWordData),
                          ),
                        ),
                    ],
                  );
                },
              );

            }
          }
        },
      ),
    );
  }
}
Widget _buildWordTile(Map<String, dynamic> wordData) {
  final englishWord = wordData['enWord'];
  final turkishWord = wordData['trWord'];
  final level = wordData['level'];
  final turkishSentence = wordData['trSentence'];
  final englishSentence = wordData['enSentence'];
  final lastDate = wordData['lastDate'];

  return Container(
    decoration: BoxDecoration(
      color: Colors.grey,
      borderRadius: BorderRadius.circular(8.0),
    ),
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('İngilizce Kelime: $englishWord', style: const TextStyle(fontWeight: FontWeight.bold)),
        Text('Türkçe Karşılığı: $turkishWord', style: CustomStyles.blackAndBoldTextStyleM),
        Text('İngilizce Cümle: $englishSentence'),
        Text('Türkçe Cümle: $turkishSentence'),
        Text('En son cevaplanma tarihi: $lastDate'),
        Text('Seviye: $level'),
      ],
    ),
  );
}
