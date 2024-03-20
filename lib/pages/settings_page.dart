import 'package:flutter/material.dart';
import 'package:kovalingo/constants/colors.dart';

import '../widgets/custom_menu_button.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundBlue,
      appBar: AppBar(title: const Text("Settings"),backgroundColor: CustomColors.appBarBlue,),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomMenuButton(title: 'Bütün verileri resetle', onPressed: () {  },),
            CustomMenuButton(title: 'Sorulacak kelime sayısını belirle', onPressed: () {  },),
            CustomMenuButton(title: 'Hesaptan Çıkış Yap', onPressed: () {  },),
          ],
        ),
      ),
    );
  }
}
