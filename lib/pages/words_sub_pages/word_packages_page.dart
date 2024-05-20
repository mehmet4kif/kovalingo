import 'package:flutter/material.dart';
import 'package:kovalingo/constants/colors.dart';

import '../../widgets/words_package_button.dart';

class WordPackagePage extends StatelessWidget {
  WordPackagePage({super.key});

  List<Widget> wordPackages = [
    WordPackageButton(
      text: 'Stanford En Çok Kullanılan 100 kelime',
      onTap: () {},
    ),
    WordPackageButton(
      text: 'Stanford En Çok Kullanılan 250 kelime',
      onTap: () {},
    ),
    WordPackageButton(
      text: 'Stanford En Çok Kullanılan 500 kelime',
      onTap: () {},
    ),
    WordPackageButton(
      text: 'Stanford En Çok Kullanılan 1000 kelime',
      onTap: () {},
    ),
    WordPackageButton(
      text: 'Tatil için 120 Turist Kelimesi',
      onTap: () {},
    ),
    WordPackageButton(
      text: 'A1 Seviyesi 200 kelime',
      onTap: () {},
    ),
    WordPackageButton(
      text: 'Yazılım ile ilgili 80 kelime',
      onTap: () {},
    ),
    WordPackageButton(
      text: 'Prepositions kelimeleri',
      onTap: () {},
    ),
  ];

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
        children: wordPackages,
      ),
    );
  }
}


