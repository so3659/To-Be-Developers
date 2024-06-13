import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomBarChart extends StatelessWidget {
  final List<String> titles;
  final List<int> values;

  const CustomBarChart({super.key, required this.titles, required this.values});

  @override
  Widget build(BuildContext context) {
    final barGroups = generateBarGroups(values);
    final sortedBarGroups = barGroups
      ..sort((a, b) => b.barRods[0].toY.compareTo(a.barRods[0].toY));
    return AspectRatio(
        aspectRatio: 1.6,
        child: BarChart(
          BarChartData(
            barTouchData: barTouchData,
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 30,
                  getTitlesWidget: (value, meta) =>
                      getTitles(value, meta, titles),
                ),
              ),
              leftTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            borderData: borderData,
            barGroups: sortedBarGroups,
            gridData: const FlGridData(show: false),
            alignment: BarChartAlignment.spaceAround,
            maxY: 60,
          ),
        ));
  }

  List<BarChartGroupData> generateBarGroups(List<int> values) {
    return List<BarChartGroupData>.generate(values.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: values[index].toDouble(),
            gradient: _barsGradient,
          )
        ],
        showingTooltipIndicators: [0],
      );
    });
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) => Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 10,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              '${rod.toY.round().toString()}%',
              const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta, List<String> titles) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 7,
    );
    String text;
    int index = value.toInt();
    if (index >= 0 && index < titles.length) {
      text = titles[index];
    } else {
      text = '';
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  LinearGradient get _barsGradient => const LinearGradient(
        colors: [
          Colors.black,
          Colors.white,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );
}
