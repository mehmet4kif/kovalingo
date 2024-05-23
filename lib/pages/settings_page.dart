import 'package:kovalingo/words/reset_word.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kovalingo/constants/colors.dart';
import '../widgets/custom_menu_button.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundBlue,
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: CustomColors.appBarBlue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomMenuButton(
              title: 'Bütün verileri resetle',
              onPressed: () async {
                final result = await showDialog<bool>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Emin misiniz?'),
                      content: const Text(
                          'Bütün verileri resetlemek istediğinizden emin misiniz? Bu işlem geri alınamaz.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: const Text('İptal'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                          child: const Text('Evet'),
                        ),
                      ],
                    );
                  },
                );

                if (result == true) {
                  ResetWord resetWord = ResetWord();
                  final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
                  prefs.setInt("correctAnswers", 0);
                  prefs.setInt("falseAnswers", 0);
                  prefs.setInt("completedWords", 0);
                  await resetWord.resetAllWords();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Veriler başarıyla resetlendi.'),
                    ),
                  );
                }
              },
            ),
            CustomMenuButton(
              title: 'Sorulacak kelime sayısını belirle',
              onPressed: () {
                // Alert Dialog ile kelime sayısını belirleme işlemi
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    int? selectedCount;

                    return AlertDialog(
                      title: const Text('Sorulacak kelime sayısını belirle'),
                      content: TextField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText:
                          'Test Başına sorulacak kelime sayısını girin',
                        ),
                        onChanged: (value) {
                          selectedCount = int.tryParse(value);
                        },
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('İptal'),
                        ),
                        TextButton(
                          onPressed: () async {
                            if (selectedCount != null &&
                                selectedCount! > 0 &&
                                selectedCount! <= 50) {
                              final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                              await prefs.setInt(
                                  'questionCount', selectedCount!);
                              print(
                                  'Seçilen sayı: ${prefs.getInt("questionCount")}');
                              Navigator.of(context).pop();
                            } else {
                              // Hatalı giriş durumunda kullanıcıya uyarı verin
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Geçersiz giriş. Lütfen 0-50 arası bir sayı girin.')),
                              );
                            }
                          },
                          child: const Text('Onayla'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            CustomMenuButton(
              title: 'Hesaptan Çıkış Yap',
              onPressed: () {
                // Hesaptan çıkış yapma işlemi
              },
            ),
          ],
        ),
      ),
    );
  }
}
