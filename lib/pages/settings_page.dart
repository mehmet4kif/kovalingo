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
              onPressed: () {
                // Resetleme işlemini gerçekleştirecek kod buraya gelecek
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
                          child: Text('İptal'),
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
