import 'package:flutter/material.dart';
import 'package:kovalingo/constants/styles.dart';
import 'package:kovalingo/pages/words_page.dart';
import 'package:kovalingo/words/quizBrain.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/colors.dart';
import '../widgets/custom_navigator.dart';
import 'dart:io'; // Dosya işlemleri için dart:io import edildi.

class StartTestPage extends StatefulWidget {
  const StartTestPage({super.key});

  @override
  State<StartTestPage> createState() => _StartTestPageState();
}

class _StartTestPageState extends State<StartTestPage> {
  int questionCount = 10;
  late Future<List<dynamic>?> wordListFuture;

  @override
  void initState() {
    super.initState();
    _loadQuestionCount();
    wordListFuture = QuizBrain().getQuizWords(questionCount);
  }

  Future<void> _loadQuestionCount() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      questionCount = prefs.getInt("questionCount") ?? 10;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundBlue,
      appBar: AppBar(
        title: const Text("Flashcards"),
        backgroundColor: CustomColors.appBarBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<dynamic>?>(
          future: wordListFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Hata: ${snapshot.error}'));
            } else if (snapshot.data == null || snapshot.data!.isEmpty) {
              return _buildNoWordsFound(context);
            } else {
              return FlashcardWidget(wordList: snapshot.data!);
            }
          },
        ),
      ),
    );
  }

  Widget _buildNoWordsFound(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Bugünlük Kelime bulunamadı.",
              style: CustomStyles.blackAndBoldTextStyleXXl),
          const SizedBox(height: 64),
          ElevatedButton(
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(const Size(200, 75)),
            ),
            onPressed: () =>
                Navigator.push(context, CustomNavigator(const WordsPage())),
            child: Text(
              "Manuel kelime eklemek veya hazır kelime paketi seçmek için tıklayın.",
              style: CustomStyles.blackTextStyleS,
            ),
          ),
        ],
      ),
    );
  }
}

class FlashcardWidget extends StatefulWidget {
  final List<dynamic> wordList;

  const FlashcardWidget({super.key, required this.wordList});

  @override
  FlashcardWidgetState createState() => FlashcardWidgetState();
}

class FlashcardWidgetState extends State<FlashcardWidget> {
  int currentIndex = 0;
  bool isRevealed = false;
  final QuizBrain quizBrain = QuizBrain();
  late List<dynamic> remainingWords;

  @override
  void initState() {
    super.initState();
    remainingWords = List.from(widget.wordList);
  }

  @override
  Widget build(BuildContext context) {
    if (remainingWords.isEmpty) {
      return _buildCompletionMessage();
    }

    final currentWord = remainingWords[currentIndex];
    final deviceSize = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildFlashcard(currentWord, deviceSize),
        const SizedBox(height: 20),
        isRevealed ? _buildResponseButtons(currentWord) : _buildRevealButton(),
      ],
    );
  }

  Widget _buildFlashcard(Map<String, dynamic> currentWord, Size deviceSize) {
    return SingleChildScrollView(
      child: Container(
        width: deviceSize.width,
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Center(
          child: isRevealed
              ? _buildRevealedContent(currentWord)
              : Text(
            currentWord['enWord'],
            style: const TextStyle(
              fontSize: 64,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRevealedContent(Map<String, dynamic> currentWord) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Kelime: ${currentWord['enWord']}",
          style: const TextStyle(
              fontSize: 48, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          "Anlamı: ${currentWord['trWord']}",
          style: const TextStyle(
              fontSize: 48, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        if (currentWord['enSentence'].isNotEmpty) ...[
          const SizedBox(height: 10),
          Text(
            "İnglizce örnek cümle: ${currentWord['enSentence']}",
            style: const TextStyle(
                fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
        if (currentWord['trSentence'].isNotEmpty) ...[
          const SizedBox(height: 10),
          Text(
            "Cümlenin Türkçe Karşılığı: ${currentWord['trSentence']}",
            style: const TextStyle(
                fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
        const SizedBox(height: 10),
        _loadImage(currentWord['imagePath']),
      ],
    );
  }

  Widget _loadImage(String imagePath) {
    if (imagePath.isEmpty) {
      return const Text(
        'Resim Yüklenemedi',
        style: TextStyle(
            color: Colors.red, fontSize: 24, fontWeight: FontWeight.bold),
      );
    }

    return Image.file(
      File(imagePath),
      fit: BoxFit.contain, // Resmin boyutunu sınırlamak için eklendi.
      height: 200, // Yüksekliği sınırlamak için eklendi.
      width: double.infinity, // Genişliği sınırlamak için eklendi.
      errorBuilder: (context, error, stackTrace) {
        return const Text(
          'Resim Yüklenemedi',
          style: TextStyle(
              color: Colors.red, fontSize: 24, fontWeight: FontWeight.bold),
        );
      },
    );
  }

  Widget _buildResponseButtons(Map<String, dynamic> currentWord) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildResponseButton('Correct', Colors.green, currentWord['enWord']),
        const SizedBox(width: 20),
        _buildResponseButton('Incorrect', Colors.red, currentWord['enWord']),
      ],
    );
  }

  Widget _buildResponseButton(String label, Color color, String enWord) {
    return ElevatedButton(
      onPressed: () async {
        if (label == 'Correct') {
          await quizBrain.correctAnswer(enWord);
        } else {
          await quizBrain.falseAnswer(enWord);
        }

        setState(() {
          isRevealed = false;
          remainingWords.removeAt(currentIndex);
          if (remainingWords.isNotEmpty) {
            currentIndex = currentIndex % remainingWords.length;
          }
        });
      },
      style: ElevatedButton.styleFrom(backgroundColor: color),
      child: Text(label,
          style: const TextStyle(color: Colors.white, fontSize: 24)),
    );
  }

  Widget _buildRevealButton() {
    return ElevatedButton(
      onPressed: () => setState(() => isRevealed = true),
      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
      child: const Text('Reveal',
          style: TextStyle(color: Colors.white, fontSize: 24)),
    );
  }

  Widget _buildCompletionMessage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Tüm kelimeleri tamamladınız. Yarın tekrar kontrol edebilirsiniz.",
            style: CustomStyles.blackAndBoldTextStyleXXl,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 64),
          ElevatedButton(
            onPressed: () =>
                Navigator.push(context, CustomNavigator(const WordsPage())),
            child: Text(
              "Kelime sayfasına geri dön",
              style: CustomStyles.blackTextStyleS,
            ),
          ),
        ],
      ),
    );
  }
}
