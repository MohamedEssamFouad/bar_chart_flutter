import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'ChartsData.dart';
import 'Model/BarData.dart';
import 'Presention/Home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimatedChartScreen(
        data: [
          BarData(label: 'A', value: 10),
          BarData(label: 'B', value: 20),
          BarData(label: 'C', value: 40),
        ],
      ),
    );
  }
}


