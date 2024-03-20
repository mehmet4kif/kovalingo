import 'package:flutter/material.dart';
import '../constants/colors.dart';

//todo buraya widgetlar gelebilir paddingler için ve textler için style

class HowItWorksPage extends StatelessWidget {
  const HowItWorksPage({super.key});
  final Color textColor = Colors.black;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundBlue,
      appBar: AppBar(
        title: const Text("Analyses"),
        backgroundColor: CustomColors.appBarBlue,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  "Nasıl Çalışır?",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: textColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  "1. Kayıt ve Giriş:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),
              Text(
                "Öncelikle, kullanıcılar sisteme kayıt olur veya var olan hesaplarıyla giriş yaparlar. Kayıt olduktan sonra, kişisel profillerini oluşturabilir ve öğrenme tercihlerini belirleyebilirler.",
                style: TextStyle(color: textColor),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  "2. Kelime Ekleme:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),
              Text(
                "Kullanıcılar, kendi kelime hazinelerini oluşturmak için kelime ekleme modülünü kullanabilirler. Her kelimenin İngilizce karşılığı, Türkçe anlamı, cümle içinde kullanımı, görsel öğeler ve hatta sesli okunuşu gibi ek bilgiler eklenebilir. Bu şekilde, kelime öğrenme süreci daha etkili hale gelir.",
                style: TextStyle(color: textColor),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  "3. Sınav Modülü:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),
              Text(
                "Sistem, kullanıcıların öğrendikleri kelimeleri düzenli olarak tekrar etmelerini sağlamak için özel bir sınav modülü sunar. Bu modül, 6 Sefer Quiz Soruları algoritmasıyla çalışır. Bir kelimeyi tam olarak öğrenmek için kullanıcının altı kez üst üste doğru cevap vermesi gerekir. Aksi halde, kullanıcıya aynı kelime tekrar sorulur ve öğrenme süreci devam eder. Soruların zamanları şu şekildedir:",
                style: TextStyle(color: textColor),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Birinci Sınav: 1 gün sonra",
                      style: TextStyle(color: textColor),
                    ),
                    Text(
                      "İkinci Sınav: 1 hafta sonra",
                      style: TextStyle(color: textColor),
                    ),
                    Text(
                      "Üçüncü Sınav: 1 ay sonra",
                      style: TextStyle(color: textColor),
                    ),
                    Text(
                      "Dördüncü Sınav: 3 ay sonra",
                      style: TextStyle(color: textColor),
                    ),
                    Text(
                      "Beşinci Sınav: 6 ay sonra",
                      style: TextStyle(color: textColor),
                    ),
                    Text(
                      "Altıncı Sınav: 1 yıl sonra",
                      style: TextStyle(color: textColor),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  "4. Ayarlar ve Analiz Raporları:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),
              Text(
                "Kullanıcılar, kendi öğrenme tercihlerini kişiselleştirmek için ayarlar bölümünden faydalanabilirler. Ayrıca, çözümlenen kelimeler üzerinden analiz raporları alabilirler. Bu raporlar, kullanıcıların hangi konularda başarılı olduklarını ve hangi alanlarda daha fazla çalışmaları gerektiğini gösterir.",
                style: TextStyle(color: textColor),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  "Kelime Ezberleme Sistemi, düzenli tekrarlar ve kişiselleştirilmiş öğrenme deneyimi ile kullanıcıların İngilizce kelime bilgilerini güçlendirmelerine yardımcı olur. Öğrenme sürecini optimize etmek ve kelime hazinelerini genişletmek isteyen herkes bu sistemden faydalanabilir.",
                  style: TextStyle(
                    color: textColor,
                    fontStyle: FontStyle.italic,
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
