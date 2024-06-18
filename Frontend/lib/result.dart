import 'dart:convert';
import 'package:bigdata_project/Model/model.dart';
import 'package:bigdata_project/ReportChartBody/courseBody.dart';
import 'package:bigdata_project/ReportChartBody/chartBody.dart';
import 'package:bigdata_project/ReportChartBody/pieChartBody.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Result extends StatefulWidget {
  const Result({super.key, required this.devType, required this.role});

  final String? devType;
  final String? role;

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  late Future<ApiResponse> futureResponse;
  List<int> editorpercentages = [];
  List<int> langpercentages = [];
  List<int> frameworkpercentages = [];

  @override
  void initState() {
    super.initState();
    futureResponse = fetchApiResponse();
  }

  Future<ApiResponse> fetchApiResponse() async {
    final response = await http.get(
      Uri.parse(
          'http://3.34.56.115:3000/devs/report?devType=${widget.devType}&role=${widget.role}'),
    );

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load API data');
    }
  }

  List<int> calculatePercentages(List<int> values) {
    int total = values.reduce((a, b) => a + b);
    return values.map((value) => ((value / total) * 100).toInt()).toList();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
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
      body: Center(
        child: FutureBuilder<ApiResponse>(
          future: futureResponse,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              final data = snapshot.data!;
              final List<int> salary =
                  data.result.salary.map((s) => s.salary).toList();
              final List<String> editorTitles =
                  data.result.editorRank.map((rank) => rank.name).toList();
              final List<int> editorValues =
                  data.result.editorRank.map((rank) => rank.count).toList();
              if (editorValues.isEmpty) {
                editorpercentages = [];
              } else {
                editorpercentages = calculatePercentages(editorValues);
              }
              final List<String> langTitles =
                  data.result.langRank.map((rank) => rank.name).toList();
              final List<int> langValues =
                  data.result.langRank.map((rank) => rank.count).toList();
              if (langValues.isEmpty) {
                langpercentages = [];
              } else {
                langpercentages = calculatePercentages(langValues);
              }
              final List<String> frameworkTitles =
                  data.result.frameworkRank.map((rank) => rank.name).toList();
              final List<int> frameworkValues =
                  data.result.frameworkRank.map((rank) => rank.count).toList();
              if (frameworkValues.isEmpty) {
                frameworkpercentages = [];
              } else {
                frameworkpercentages = calculatePercentages(frameworkValues);
              }
              final List<Widget> courseBodies =
                  data.result.recommendLectures.map((lecture) {
                return CourseBody(
                  title: lecture.title,
                  content: lecture.imageUrl,
                  url: lecture.linkUrl,
                );
              }).toList();
              String? jobCodeHours = data.result.jobCodeHours?.percent;
              String? learnTime = data.result.learnTime?.hours;
              List<String> productiveToJob =
                  data.result.productiveToJob.map((p) => p.product).toList();
              String? sleepHours = data.result.sleepHours?.hours;

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Text(
                        '평균 연봉',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: screenSize.height * 0.02),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: salary
                            .map((salary) => Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.transparent, // 비활성화된 배경색 설정
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.black, // 선 색상 설정
                                        width: 1, // 선 두께 설정
                                      ),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 16.0),
                                    child: SizedBox(
                                      width: screenSize.width * 0.9,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            SalaryConverter.formatSalary(
                                                salary),
                                            style: const TextStyle(
                                              color: Colors.black, // 텍스트 색상 설정
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                      const Divider(),
                      SizedBox(height: screenSize.height * 0.02),
                      Column(
                        children: [
                          if (editorpercentages.isNotEmpty) ...[
                            const Text(
                              '개발자가 사용하는 IDE, Editor',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            CustomBarChart(
                              titles: editorTitles,
                              values: editorpercentages,
                            ),
                            const Divider(),
                            SizedBox(height: screenSize.height * 0.02),
                          ] else ...[
                            const SizedBox.shrink(),
                          ],
                        ],
                      ),
                      Column(
                        children: [
                          if (langpercentages.isNotEmpty) ...[
                            const Text(
                              '언어 순위',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            CustomBarChart(
                              titles: langTitles,
                              values: langpercentages,
                            ),
                            const Divider(),
                            SizedBox(height: screenSize.height * 0.02),
                          ] else ...[
                            const SizedBox.shrink(),
                          ],
                        ],
                      ),
                      Column(
                        children: [
                          if (frameworkpercentages.isNotEmpty) ...[
                            const Text(
                              '프레임워크 순위',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            CustomBarChart(
                              titles: frameworkTitles,
                              values: frameworkpercentages,
                            ),
                            const Divider(),
                            SizedBox(height: screenSize.height * 0.02),
                          ] else ...[
                            const SizedBox.shrink(),
                          ],
                        ],
                      ),
                      if (jobCodeHours == null) ...[
                        const SizedBox.shrink()
                      ] else ...[
                        const Text(
                          '코딩에 사용하는 시간 비율',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: screenSize.height * 0.02),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent, // 비활성화된 배경색 설정
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.black, // 선 색상 설정
                              width: 1, // 선 두께 설정
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          child: SizedBox(
                            width: screenSize.width * 0.9,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  jobCodeHours,
                                  style: const TextStyle(
                                    color: Colors.black, // 텍스트 색상 설정
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Divider(),
                        SizedBox(height: screenSize.height * 0.02),
                      ],
                      if (learnTime == null) ...[
                        const SizedBox.shrink()
                      ] else ...[
                        const Text(
                          '공부하는 시간',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: screenSize.height * 0.02),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent, // 비활성화된 배경색 설정
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.black, // 선 색상 설정
                              width: 1, // 선 두께 설정
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          child: SizedBox(
                            width: screenSize.width * 0.9,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  learnTime,
                                  style: const TextStyle(
                                    color: Colors.black, // 텍스트 색상 설정
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Divider(),
                        SizedBox(height: screenSize.height * 0.02),
                      ],
                      if (productiveToJob.isEmpty) ...[
                        const SizedBox.shrink()
                      ] else ...[
                        const Text(
                          '효율을 늘리기 위해 사용하는 방법',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: screenSize.height * 0.02),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: productiveToJob
                              .map((product) => Padding(
                                    padding: const EdgeInsets.all(3),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color:
                                            Colors.transparent, // 비활성화된 배경색 설정
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Colors.black, // 선 색상 설정
                                          width: 1, // 선 두께 설정
                                        ),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 16.0),
                                      child: SizedBox(
                                        width: screenSize.width * 0.9,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              product,
                                              style: const TextStyle(
                                                color:
                                                    Colors.black, // 텍스트 색상 설정
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                        const Divider(),
                        SizedBox(height: screenSize.height * 0.02),
                      ],
                      if (sleepHours == null) ...[
                        const SizedBox.shrink()
                      ] else ...[
                        const Text(
                          '자는 시간',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: screenSize.height * 0.02),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent, // 비활성화된 배경색 설정
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.black, // 선 색상 설정
                              width: 1, // 선 두께 설정
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          child: SizedBox(
                            width: screenSize.width * 0.9,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  sleepHours,
                                  style: const TextStyle(
                                    color: Colors.black, // 텍스트 색상 설정
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Divider(),
                        SizedBox(height: screenSize.height * 0.02),
                      ],
                      const Text(
                        '추천 강의',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: screenSize.height * 0.02),
                      Container(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: courseBodies,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Text('No data');
            }
          },
        ),
      ),
    );
  }
}

class SalaryConverter {
  static String formatSalary(int salary) {
    final NumberFormat usdFormat =
        NumberFormat.currency(locale: 'en_US', symbol: '\$');
    return usdFormat.format(salary);
  }
}
