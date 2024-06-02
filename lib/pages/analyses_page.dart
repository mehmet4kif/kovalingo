import 'dart:ui';
import 'dart:typed_data';
import 'package:kovalingo/constants/styles.dart';
import 'package:printing/printing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/colors.dart';
import '../words/read_word_list.dart';

class AnalysesPage extends StatefulWidget {
  const AnalysesPage({super.key});

  @override
  State<AnalysesPage> createState() => _AnalysesPageState();
}

class _AnalysesPageState extends State<AnalysesPage> {
  int trueAnswers = 0;
  int falseAnswers = 0;
  int finishedWords = 0;
  int totalWords = 0;

  final GlobalKey _printKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int trueAnswers = prefs.getInt("correctAnswers") ?? 0;
    int falseAnswers = prefs.getInt("falseAnswers") ?? 0;
    int finishedWords = prefs.getInt("completedWords") ?? 0;
    int totalWords = await ReadWord().getTotalWordCount();

    setState(() {
      this.trueAnswers = trueAnswers;
      this.falseAnswers = falseAnswers;
      this.finishedWords = finishedWords;
      this.totalWords = totalWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundBlue,
      appBar: AppBar(
        title: const Text("Analyses"),
        backgroundColor: CustomColors.appBarBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RepaintBoundary(
          key: _printKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Doğru cevaplanan Soru Sayısı: $trueAnswers',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(
                'Yanlış cevaplanan Soru Sayısı: $falseAnswers',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(
                'Toplam Kelime Sayısı: $totalWords',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(
                'Tamamlanmış Kelime Sayısı: $finishedWords',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Row(
                  children: [
                    Expanded(child: _buildBarChart()),
                    Expanded(child: _buildPieChart()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => printAnalysisPage(context),
        tooltip: 'Sayfayı Yazdır',
        child: const Icon(Icons.print),
      ),
    );
  }

  Widget _buildBarChart() {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        barGroups: [
          BarChartGroupData(
            x: 0,
            barRods: [
              BarChartRodData(
                width: 20,
                y: trueAnswers.toDouble(),
                colors: [CustomColors.greenThemeColor],
              ),
            ],
          ),
          BarChartGroupData(
            x: 1,
            barRods: [
              BarChartRodData(
                width: 20,
                y: falseAnswers.toDouble(),
                colors: [CustomColors.redThemeColor],
              ),
            ],
          ),
        ],
        titlesData: FlTitlesData(
          topTitles: SideTitles(showTitles: false),
          rightTitles: SideTitles(showTitles: false),
          leftTitles: SideTitles(showTitles: true),
          bottomTitles: SideTitles(
            showTitles: true,
            getTitles: (double value) {
              switch (value.toInt()) {
                case 0:
                  return 'True';
                case 1:
                  return 'False';
                default:
                  return '';
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPieChart() {
    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(
            value: finishedWords.toDouble(),
            color: CustomColors.orangeThemeColor,
            title: 'Tamamlanan Kelimeler\n${finishedWords.toDouble()}',
            titleStyle: CustomStyles.blackAndBoldTextStyleM,
            radius: 100,
          ),
          PieChartSectionData(
            value: (totalWords - finishedWords).toDouble(),
            color: CustomColors.blueThemeColor,
            title:
                'Kalan Kelimeler\n${(totalWords - finishedWords).toDouble()}',
            titleStyle: CustomStyles.blackAndBoldTextStyleM,
            radius: 100,
          ),
        ],
      ),
    );
  }

  void printAnalysisPage(BuildContext context) {
    Printing.layoutPdf(
      onLayout: (_) async {
        final pdfData = _printKey.currentContext!.findRenderObject()
            as RenderRepaintBoundary;
        final image = await pdfData.toImage(pixelRatio: 2.0);
        final byteData = await image.toByteData(format: ImageByteFormat.png);
        return byteData!.buffer.asUint8List();
      },
      name: 'analyses_page.pdf',
    );
  }
}
