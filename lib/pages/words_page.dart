import 'package:flutter/material.dart';
import 'package:kovalingo/constants/colors.dart';
import 'package:kovalingo/pages/words_sub_pages/add_word_manual.dart';
import 'package:kovalingo/pages/words_sub_pages/word_packages_page.dart';
import 'package:kovalingo/widgets/custom_menu_button.dart';
import 'package:kovalingo/widgets/custom_navigator.dart';

import 'image_picker_test.dart';
import 'my_words_page.dart';

class WordsPage extends StatelessWidget {
  const WordsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundBlue,
      appBar: AppBar(
        title: const Text("Kelimelerim"),
        backgroundColor: CustomColors.appBarBlue,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          CustomMenuButton(
              title: "Manuel Kelime Ekleme",
              onPressed: () {
                Navigator.push(context, CustomNavigator(AddWordManual()));
              }),
          CustomMenuButton(
              title: "Hazır Paketlerden Kelime Ekle",
              onPressed: () {
                Navigator.push(context, CustomNavigator(WordPackagePage()));
              }),
          CustomMenuButton(title: "Kelimelerimi Görüntüle", onPressed: () {
            Navigator.push(context, CustomNavigator(const MyWords()));
          }),
          CustomMenuButton(
              title: "Resim Seçme Test",
              onPressed: () {
                Navigator.push(context, CustomNavigator(const PickImage()));
              }),
        ],
      ),
    );
  }
}
