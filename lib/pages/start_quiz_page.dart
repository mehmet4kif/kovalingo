import 'package:flutter/material.dart';
import 'package:kovalingo/constants/styles.dart';
import 'package:kovalingo/pages/words_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/colors.dart';
import '../widgets/custom_navigator.dart';
import '../words/read_word_list.dart';

class StartTestPage extends StatefulWidget {
  const StartTestPage({Key? key}) : super(key: key);

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
    wordListFuture = ReadWord().getWordList();

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
          Text("Kelime bulunamadı.", style: CustomStyles.blackAndBoldTextStyleXXl),
          const SizedBox(height: 64),
          ElevatedButton(
            onPressed: () => Navigator.push(context, CustomNavigator(const WordsPage())),
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

  const FlashcardWidget({Key? key, required this.wordList}) : super(key: key);

  @override
  _FlashcardWidgetState createState() => _FlashcardWidgetState();
}

class _FlashcardWidgetState extends State<FlashcardWidget> {
  int currentIndex = 0;
  bool isRevealed = false;

  @override
  Widget build(BuildContext context) {
    final currentWord = widget.wordList[currentIndex];
    final deviceSize = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildFlashcard(currentWord, deviceSize),
        const SizedBox(height: 20),
        isRevealed ? _buildResponseButtons() : _buildRevealButton(),
      ],
    );
  }

  Widget _buildFlashcard(Map<String, dynamic> currentWord, Size deviceSize) {
    return Container(
      width: deviceSize.width,
      height: deviceSize.height / 1.50,
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
    );
  }

  Widget _buildRevealedContent(Map<String, dynamic> currentWord) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Kelime: ${currentWord['enWord']}",
          style: const TextStyle(fontSize: 48, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          "Anlamı: ${currentWord['trWord']}",
          style: const TextStyle(fontSize: 48, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          "İnglizce örnek cümle: ${currentWord['enSentence']}",
          style: const TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          "Cümlenin Türkçe Karşılığı: ${currentWord['trSentence']}",
          style: const TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        _loadImage(currentWord['imagePath']),
      ],
    );
  }

  Widget _loadImage(String imagePath) {
    return Image.asset(
      imagePath,
      errorBuilder: (context, error, stackTrace) {
        return const Text(
          'Resim Yüklenemedi',
          style: TextStyle(color: Colors.red, fontSize: 24, fontWeight: FontWeight.bold),
        );
      },
    );
  }

  Widget _buildResponseButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildResponseButton('Correct', Colors.green),
        const SizedBox(width: 20),
        _buildResponseButton('Incorrect', Colors.red),
      ],
    );
  }

  Widget _buildResponseButton(String label, Color color) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          isRevealed = false;
          currentIndex = (currentIndex + 1) % widget.wordList.length;
        });
      },
      style: ElevatedButton.styleFrom(backgroundColor: color),
      child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 24)),
    );
  }

  Widget _buildRevealButton() {
    return ElevatedButton(
      onPressed: () => setState(() => isRevealed = true),
      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
      child: const Text('Reveal', style: TextStyle(color: Colors.white, fontSize: 24)),
    );
  }
}
