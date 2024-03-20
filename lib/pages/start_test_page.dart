import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kovalingo/constants/styles.dart';
import 'package:kovalingo/pages/words_page.dart';

import '../constants/colors.dart';
import '../widgets/custom_navigator.dart';

class StartTestPage extends StatelessWidget {
  const StartTestPage({super.key});

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Kelime bulunamadı.",
              style: CustomStyles.blackAndBoldTextStyleXXl,
            ),
            const SizedBox(height: 64,),
            ElevatedButton(
              onPressed: () {
                  Navigator.push(context, CustomNavigator(const WordsPage()));
              },
              child: Text(
                "Manuel kelime eklemek veya hazır kelime pakedi seçmek için tıklayın. ",
                style: CustomStyles.blackTextStyleS,
              ),
            )
          ],
        ),
      ),
    );
  }
}
//todo elevated butonlar için widget
