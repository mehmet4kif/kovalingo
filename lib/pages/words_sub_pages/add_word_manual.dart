import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../constants/colors.dart';

class AddWordManual extends StatefulWidget {
  const AddWordManual({Key? key}) : super(key: key);

  @override
  State<AddWordManual> createState() => _AddWordManualState();
}

class _AddWordManualState extends State<AddWordManual> {
  File? _image;
  final List<TextEditingController> _controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('Resim seçme işlemi iptal edildi.');
      }
    });
  }

  void _onSubmitPressed(BuildContext context) {
    // Seçilen resim, İngilizce kelime, Türkçe kelime, İngilizce cümle ve Türkçe cümle bilgilerini al
    File? selectedImage = _image;
    String englishWord = _controllers[0].text;
    String turkishWord = _controllers[1].text;
    String englishSentence = _controllers[2].text;
    String turkishSentence = _controllers[3].text;

    // Eğer herhangi bir alan boşsa kullanıcıya uyarı ver
    if (selectedImage == null ||
        englishWord.isEmpty ||
        turkishWord.isEmpty ||
        englishSentence.isEmpty ||
        turkishSentence.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Uyarı'),
            content: Text('Lütfen tüm bilgileri girin ve bir resim seçin.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Tamam'),
              ),
            ],
          );
        },
      );
    } else {
      // Tüm bilgiler doluysa, seçilen resmi ve diğer bilgileri kullanarak flashcard'ı oluştur
      // Örneğin, bu bilgileri bir veritabanına kaydedebilir veya başka bir işlem yapabilirsiniz.
      // Burada sadece bilgileri yazdıralım:
      print('Seçilen Resim: $selectedImage');
      print('İngilizce Kelime: $englishWord');
      print('Türkçe Kelime: $turkishWord');
      print('İngilizce Cümle: $englishSentence');
      print('Türkçe Cümle: $turkishSentence');

      // İşlem tamamlandıktan sonra, kullanıcıya bilginin kaydedildiğine dair bir bildirim gösterebilirsiniz.
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Bilgi'),
            content: Text('Bilgileriniz başarıyla kaydedildi.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Tamam'),
              ),
            ],
          );
        },
      );
    }
  }



  @override
  Widget build(BuildContext context) {
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
              controller: _controllers[0],
            ),
            CustomTextField(
              labelText: 'Türkçe Kelime',
              controller: _controllers[1],
            ),
            CustomTextField(
              labelText: 'İngilizce Cümle',
              controller: _controllers[2],
            ),
            CustomTextField(
              labelText: 'Türkçe Cümle',
              controller: _controllers[3],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Resim Seç',
                  style: TextStyle(color: Colors.black),
                ),
                ElevatedButton(
                  onPressed: _pickImage,
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
                    _onSubmitPressed(context);
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
