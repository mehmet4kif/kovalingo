import 'package:kovalingo/words/write_word.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import '../../classes/wordData.dart';
import '../../constants/colors.dart';
import 'dart:io';

class AddWordManual extends StatefulWidget {
  const AddWordManual({super.key});

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
        print(_image);
      } else {
        print('Resim seçme işlemi iptal edildi.');
      }
    });
  }

  void _onSubmitPressed(BuildContext context) async {
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
            title: const Text('Uyarı'),
            content: const Text('Lütfen tüm bilgileri girin ve bir resim seçin.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Tamam'),
              ),
            ],
          );
        },
      );
    } else {
      // Verileri WordData nesnesine paketle
      WordData wordData = WordData(
        turkishWord: turkishWord,
        englishWord: englishWord,
        turkishSentence: turkishSentence,
        englishSentence: englishSentence,
        imagePath: selectedImage.path,
      );

      // WriteWord sınıfını kullanarak bilgileri JSON dosyasına kaydet
      WriteWord writeWord = WriteWord();
      await writeWord.addItemToWordList(
          wordData
      );

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Bilgi'),
            content: const Text('Bilgileriniz başarıyla kaydedildi.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Tamam'),
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
      body: SingleChildScrollView(
        child: Padding(
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
                    child: const Text('Seç'),
                  ),
                ],
              ),
              const SizedBox(height: 20), // Add some space before the buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // İptal butonuna basılınca yapılacak işlemler
                    },
                    child: const Text('İptal Et'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _onSubmitPressed(context);
                    },
                    child: const Text('Onayla'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;

  const CustomTextField({super.key,
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


