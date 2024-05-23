import 'package:flutter/material.dart';
import 'package:kovalingo/classes/word_packages_class.dart';
import 'package:kovalingo/constants/colors.dart';
import 'package:kovalingo/words/write_word.dart';

import '../../widgets/words_package_button.dart';

class WordPackagePage extends StatelessWidget {
  final WriteWord writeWord = WriteWord();
  final WordPackages wordPackages = WordPackages();

  WordPackagePage({super.key});

  List<Widget> _buildWordButtons() {
    return [
      WordPackageButton(
        text: 'Giriş seviyesi basit kelimeler',
        onTap: () {
          writeWord.addItemPack(wordPackages.a1Word);
        },
      ),
      WordPackageButton(
        text: 'Yazılımla ilgili terimler',
        onTap: () {
          writeWord.addItemPack(wordPackages.softwareTerms);
        },
      ),
      WordPackageButton(
        text: "İleri seviye kelimeler",
        onTap: () {
          writeWord.addItemPack(wordPackages.c2Words);
        },
      ),
      WordPackageButton(
        text: 'Orta seviye kelimeler',
        onTap: () {
          writeWord.addItemPack(wordPackages.b1Words);
        },
      ),
      WordPackageButton(
        text: 'Tatilde kullanılabilecek cümleler',
        onTap: () {
          writeWord.addItemPack(wordPackages.holidayPhrases);
        },
      ),
      WordPackageButton(
        text: 'Prepositions kelimeleri',
        onTap: () {
          writeWord.addItemPack(wordPackages.prepositions);
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundBlue,
      appBar: AppBar(
        title: const Text('Word Package Page'),
        backgroundColor: CustomColors.appBarBlue,
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(16.0),
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 16.0,
        crossAxisCount: 4,
        children: _buildWordButtons(),
      ),
    );
  }
}
