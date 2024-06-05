import 'package:bigdata_project/courseBody.dart';
import 'package:bigdata_project/chartBody.dart';
import 'package:bigdata_project/pieChartBody.dart';
import 'package:flutter/material.dart';

class Result extends StatefulWidget {
  const Result({super.key});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  final titles = ['Python', 'Flutter', 'Spring'];
  final values = [8, 14, 10];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('결과'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                '강의',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Container(
                child: const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CourseBody(
                          title: 'Infrean',
                          content:
                              'https://cdn.inflearn.com/public/courses/333482/cover/bb6e0c88-fbe0-49c9-aa1b-ebaa9918b7d7/333482.png?w=420'),
                      CourseBody(
                          title: 'Infrean',
                          content:
                              'https://cdn.inflearn.com/public/courses/333482/cover/bb6e0c88-fbe0-49c9-aa1b-ebaa9918b7d7/333482.png?w=420')
                    ],
                  ),
                ),
              ),
              const Divider(),
              const Text(
                '언어 및 프레임워크 순위',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              CustomBarChart(
                titles: titles,
                values: values,
              ),
              const Divider(),
              const Text(
                '개발자가 사용하는 IDE, Editor',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              const Text(
                '코드에 사용하는 시간',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              const Text(
                '개발자들이 배우고 싶은 언어',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              const Text(
                '취하는 휴식시간',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const PieChartSample2(
                sectionTitles: ['4시간', '8시간', '6시간'],
                sectionValues: ['30%', '15%', '15%'],
              ),
              const Divider(),
              const Text(
                '주 사용 언어는?',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              const Text(
                '계속해서 기술에 대한 공부가 필요한가?',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              const Text(
                '어떤 것이 생산적으로 코딩을 하는데 도움을 주는가',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
