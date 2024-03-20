import 'package:flutter/material.dart';
import 'package:kovalingo/constants/colors.dart';

class AddWordManual extends StatelessWidget {
  AddWordManual({Key? key});

  void _onSubmitPressed(
      BuildContext context, List<TextEditingController> controllers) {
    for (var controller in controllers) {
      print(controller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<TextEditingController> controllers = [
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
    ];

    return Scaffold(
      backgroundColor: CustomColors.backgroundBlue,
      appBar: AppBar(
        title: const Text('Manual Kelime Ekleme'),
        backgroundColor: CustomColors.appBarBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CustomTextField(
              labelText: 'İngilizce Kelime',
              controller: controllers[0],
            ),
            CustomTextField(
              labelText: 'Türkçe Kelime',
              controller: controllers[1],
            ),
            CustomTextField(
              labelText: 'İngilizce Cümle',
              controller: controllers[2],
            ),
            CustomTextField(
              labelText: 'Türkçe Cümle',
              controller: controllers[3],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Resim Seç',
                  style: TextStyle(color: Colors.black),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Seç'),
                ),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // İptal butonuna basılınca yapılacak işlemler
                  },
                  child: Text('İptal Et'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _onSubmitPressed(context, controllers);
                  },
                  child: Text('Onayla'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;

  const CustomTextField({
    required this.labelText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          focusedBorder: const OutlineInputBorder(),
          enabledBorder: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
