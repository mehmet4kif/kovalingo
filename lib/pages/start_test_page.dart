import 'package:flutter/material.dart';
import 'package:kovalingo/constants/styles.dart';
import 'package:kovalingo/pages/words_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/colors.dart';
import '../widgets/custom_navigator.dart';
import '../words/read_word_list.dart';

class StartTestPage extends StatefulWidget {
  const StartTestPage({Key? key});

  @override
  State<StartTestPage> createState() => _StartTestPageState();
}

class _StartTestPageState extends State<StartTestPage> {
  int questionCount = 10; // Varsayılan soru sayısı

  @override
  void initState() {
    super.initState();
    loadQuestionCount();
  }

  Future<void> loadQuestionCount() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      questionCount = prefs.getInt("questionCount") ??
          10; // Kaydedilmiş soru sayısını al, yoksa varsayılan değeri kullan
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundBlue,
      appBar: AppBar(
        title: const Text("Analyses"),
        backgroundColor: CustomColors.appBarBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<dynamic>?>(
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
              // Kelime listesi boşsa "Kelime bulunamadı" yazısını göster
              if (wordList == null || wordList.isEmpty) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Kelime bulunamadı.",
                      style: CustomStyles.blackAndBoldTextStyleXXl,
                    ),
                    const SizedBox(
                      height: 64,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context, CustomNavigator(const WordsPage()));
                      },
                      child: Text(
                        "Manuel kelime eklemek veya hazır kelime paketi seçmek için tıklayın.",
                        style: CustomStyles.blackTextStyleS,
                      ),
                    )
                  ],
                );
              } else {
                // Kelime listesi doluysa burada istediğiniz ekranı oluşturabilirsiniz.
                // Örneğin:
                return Text('Kelime listesi dolu. Soru sayısı: $questionCount');
              }
            }
          },
        ),
      ),
    );
  }
}
