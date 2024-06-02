import 'package:kovalingo/constants/styles.dart';
import 'package:kovalingo/words/write_word.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import '../../classes/word_data_class.dart';
import '../../constants/colors.dart';
import 'dart:io';

class AddWordManual extends StatefulWidget {
  const AddWordManual({super.key});

  @override
  State<AddWordManual> createState() => _AddWordManualState();
}

class _AddWordManualState extends State<AddWordManual> {
  File? _image;
  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  void _onSubmitPressed(BuildContext context) async {
    String turkishWord = _controllers[0].text;
    String englishWord = _controllers[1].text;
    String turkishSentence = _controllers[2].text;
    String englishSentence = _controllers[3].text;
    String imagePath = _image?.path ?? "";

    if (turkishWord.isEmpty || englishWord.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Uyarı'),
            content: const Text(
                'Lütfen İngilizce kelimenizi ve Türkçe karşılığını girin.'),
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
    } else if ((turkishSentence.isNotEmpty && englishSentence.isEmpty) ||
        (turkishSentence.isEmpty && englishSentence.isNotEmpty)) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Uyarı'),
            content:
                const Text('Lütfen girdiğiniz cümlenin karşılığını da ekleyin'),
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
      WordData wordData = WordData(
        turkishWord: turkishWord,
        englishWord: englishWord,
        turkishSentence: turkishSentence,
        englishSentence: englishSentence,
        imagePath: imagePath,
      );

      WriteWord writeWord = WriteWord();
      await writeWord.addItemToWordList(wordData);

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
      ).then((_) {
        for (var controller in _controllers) {
          controller.clear();
        }
        setState(() {
          _image = null;
        });
      });
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
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      labelText: 'İngilizce Kelime',
                      controller: _controllers[0],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomTextField(
                      labelText: 'Türkçe Kelime',
                      controller: _controllers[1],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      labelText: 'İngilizce Cümle',
                      controller: _controllers[2],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomTextField(
                      labelText: 'Türkçe Cümle',
                      controller: _controllers[3],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Resim Seç',
                    style: CustomStyles.blackAndBoldTextStyleM,
                  ),
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: const Text('Seç'),
                  ),
                ],
              ),
              if (_image != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Image.file(
                    _image!,
                    width: 100,
                    height: 100,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return const Text('Resim yüklenemedi');
                    },
                  ),
                ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
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

  const CustomTextField({
    super.key,
    required this.labelText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
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
