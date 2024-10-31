import 'package:bar_chart_flutter/main.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'Model/BarData.dart';

class ChartsWidget extends StatelessWidget {
  final List<BarData> data;
  final double animation;
  final ValueNotifier<int?> touchedIndex;

  ChartsWidget({
    Key? key,
    required this.data,
    required this.animation,
    required this.touchedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        SizedBox(
          height: 200,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: 50,
              barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    return BarTooltipItem(
                      '${data[group.x.toInt()].label}\n${rod.y.toStringAsFixed(1)}',
                      const TextStyle(color: Colors.blue),
                    );
                  },
                ),
              ),
              titlesData: FlTitlesData(
                bottomTitles: SideTitles(
                  showTitles: true,
                  getTitles: (value) {
                    final index = value.toInt();
                    return index >= 0 && index < data.length
                        ? data[index].label
                        : '';
                  },
                ),
              ),
              borderData: FlBorderData(show: false),
              barGroups: data.asMap().entries.map((entry) {
                final index = entry.key;
                final barData = entry.value;
                return BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      y: barData.value * animation,
                      colors: [Colors.red],
                      width: 20,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(height: 30),
        SizedBox(
          height: 200,
          child: LineChart(
            LineChartData(
              maxY: 50,
              lineBarsData: [
                LineChartBarData(
                  spots: data.asMap().entries.map((entry) {
                    final index = entry.key.toDouble();
                    final value = entry.value.value * animation;
                    return FlSpot(index, value);
                  }).toList(),
                  isCurved: true,
                  colors: [Colors.blue],
                  barWidth: 4,
                ),
              ],
              titlesData: FlTitlesData(
                bottomTitles: SideTitles(
                  showTitles: true,
                  getTitles: (value) {
                    final index = value.toInt();
                    return index >= 0 && index < data.length
                        ? data[index].label
                        : '';
                  },
                ),
              ),
              borderData: FlBorderData(show: false),
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: PieChart(
            PieChartData(
              sectionsSpace: 5,
              centerSpaceRadius: 50,
              pieTouchData: PieTouchData(
                touchCallback: (event, pieTouchResponse) {
                  if (event.isInterestedForInteractions && pieTouchResponse != null) {
                    touchedIndex.value = pieTouchResponse.touchedSection?.touchedSectionIndex;
                  } else {
                    touchedIndex.value = -1;
                  }
                },
              ),
              sections: data.asMap().entries.map((entry) {
                final index = entry.key;
                final value = entry.value.value;
                final isTouched = index == touchedIndex.value;
                final double radius = isTouched ? 60 : 50;
                final Color color = Colors.primaries[index % Colors.primaries.length];

                return PieChartSectionData(
                  color: color,
                  value: value,
                  title: '${value.toStringAsFixed(1)}%',
                  radius: radius,
                  titleStyle: TextStyle(
                    fontSize: isTouched ? 18 : 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
