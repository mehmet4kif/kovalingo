import 'package:flutter/material.dart';
import 'package:kovalingo/constants/colors.dart';
import 'package:kovalingo/pages/analyses_page.dart';
import 'package:kovalingo/pages/settings_page.dart';
import 'package:kovalingo/pages/start_test_page.dart';
import 'package:kovalingo/pages/words_page.dart';
import 'package:kovalingo/widgets/custom_navigator.dart';

import '../widgets/custom_menu_button.dart';
import 'how_it_works_page.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: CustomColors.backgroundBlue,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Container(
                        child: Image.asset(
                          "assets/images/menuLogo2.png",
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 8,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomMenuButton(
                        title: 'Teste Başla',
                        onPressed: () {
                          Navigator.push(context, CustomNavigator(const StartTestPage()));
                        },
                      ),
                      CustomMenuButton(
                        title: 'Kelimlelerim',
                        onPressed: () {
                          Navigator.push(context, CustomNavigator(const WordsPage()));
                        },
                      ),
                      CustomMenuButton(
                        title: 'Analizlerim',
                        onPressed: () {
                          Navigator.push(context, CustomNavigator(const AnalysesPage()));
                        },
                      ),
                      CustomMenuButton(
                        title: 'Ayarlar',
                        onPressed: () {
                          Navigator.push(context, CustomNavigator(const SettingsPage()));
                        },
                      ),
                      CustomMenuButton(
                        title: 'Nasıl Çalışır',
                        onPressed: () {
                          Navigator.push(context, CustomNavigator(const HowItWorksPage()));
                        },
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
