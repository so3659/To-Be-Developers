import 'package:bigdata_project/ReportChartBody/indicator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartSample2 extends StatefulWidget {
  final List<String> sectionTitles;
  final List<String> sectionValues;

  const PieChartSample2({
    super.key,
    required this.sectionTitles,
    required this.sectionValues,
  });

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<PieChartSample2> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Row(
        children: <Widget>[
          const SizedBox(
            height: 18,
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: showingSections(),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(widget.sectionTitles.length, (index) {
              return Column(
                children: [
                  Indicator(
                    color: getColor(index),
                    text: widget.sectionTitles[index],
                    isSquare: true,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                ],
              );
            }),
          ),
          const SizedBox(
            width: 28,
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(widget.sectionTitles.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      return PieChartSectionData(
        color: getColor(i),
        value: double.parse(widget.sectionValues[i].replaceAll('%', '')),
        title: widget.sectionValues[i],
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          shadows: shadows,
        ),
      );
    });
  }

  Color getColor(int index) {
    switch (index) {
      case 0:
        return Colors.blue;
      case 1:
        return Colors.yellow;
      case 2:
        return Colors.purple;
      case 3:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
