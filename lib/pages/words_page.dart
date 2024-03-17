import 'package:flutter/material.dart';
import 'package:kovalingo/constants/colors.dart';
import 'package:kovalingo/pages/words_sub_pages/word_packages_page.dart';
import 'package:kovalingo/widgets/custom_menu_button.dart';
import 'package:kovalingo/widgets/custom_navigator.dart';

class WordsPage extends StatelessWidget {
  const WordsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundBlue,
      appBar: AppBar(
        title: Text("Kelimelerim"),
        backgroundColor: CustomColors.appBarBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text("Kelime sayısı \$kelime"),
            const SizedBox(height: 16,),
            CustomMenuButton(title: "Manuel Kelime Ekleme", onPressed: () {}),
            CustomMenuButton(
                title: "Hazır Paketlerden Kelime Ekle", onPressed: () {
                  Navigator.push(context, CustomNavigator(WordPackagePage()));
            }),
            CustomMenuButton(title: "Kelimelerim", onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
