import 'package:flutter/material.dart';
import 'package:kovalingo/words/read_word_list.dart';

class MyWords extends StatelessWidget {
  const MyWords({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kelimelerim'),
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
                itemCount: wordList.length,
                itemBuilder: (context, index) {
                  final wordData = wordList[index];
                  final turkishWord = wordData['trWord'];
                  final englishWord = wordData['enWord'];
                  final turkishSentence = wordData['trSentence'];
                  final englishSentence = wordData['enSentence'];
                  final indexText = 'Kelime ${index + 1}';

                  return ListTile(
                    title: Text(
                      '$indexText: $turkishWord',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('İngilizce Kelime: $englishWord'),
                        Text('Türkçe Anlamı: $turkishSentence'),
                        Text('İngilizce Cümle: $englishSentence'),
                        Text('Türkçe Cümle: $turkishSentence'),
                      ],
                    ),
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
