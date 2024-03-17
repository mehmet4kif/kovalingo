import 'package:flutter/material.dart';
import 'package:kovalingo/constants/colors.dart';
import 'package:kovalingo/pages/words_page.dart';
import 'package:kovalingo/widgets/custom_navigator.dart';

import '../widgets/custom_menu_button.dart';
class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

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
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      CustomMenuButton(
                        title: 'Teste Başla',
                        onPressed: () {},
                      ),
                      CustomMenuButton(
                        title: 'Kelimlelerim',
                        onPressed: () {
                          Navigator.push(context, CustomNavigator(const WordsPage()));
                        },
                      ),
                      CustomMenuButton(
                        title: 'Analizlerim',
                        onPressed: () {},
                      ),
                      CustomMenuButton(
                        title: 'Ayarlar',
                        onPressed: () {},
                      ),
                      CustomMenuButton(
                        title: 'Nasıl Çalışır',
                        onPressed: () {},
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
