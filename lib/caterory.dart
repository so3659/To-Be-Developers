import 'package:bigdata_project/result.dart';
import 'package:flutter/material.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  _CatalogScreenState createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  RangeValues priceRange = const RangeValues(0, 30000);
  String? selectedCategory;
  String? selectedJobCategory;

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
        title: const Text('검색'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                '원하는 직무',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: screenSize.height * 0.02),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  height: 1300, // 적절한 높이 설정
                  child: GridView.builder(
                    physics:
                        const NeverScrollableScrollPhysics(), // 부모 스크롤에 영향을 받도록 설정
                    itemCount: categories.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 7,
                      mainAxisSpacing: 7,
                    ),
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return SelectableCategoryItem(
                        category: category,
                        isSelected: selectedCategory == category['num'],
                        onSelected: (isSelected) {
                          setState(() {
                            selectedCategory =
                                isSelected ? category['num'] : null;
                          });
                        },
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: screenSize.height * 0.02),
              const Divider(),
              SizedBox(height: screenSize.height * 0.02),
              const Text(
                '직책',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: screenSize.height * 0.02),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  height: 150, // 적절한 높이 설정
                  child: GridView.builder(
                    physics:
                        const NeverScrollableScrollPhysics(), // 부모 스크롤에 영향을 받도록 설정
                    itemCount: jobCategories.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 7,
                      mainAxisSpacing: 7,
                    ),
                    itemBuilder: (context, index) {
                      final category = jobCategories[index];
                      return SelectableCategoryItem(
                        category: category,
                        isSelected: selectedJobCategory == category['param'],
                        onSelected: (isSelected) {
                          setState(() {
                            selectedJobCategory =
                                isSelected ? category['param'] : null;
                          });
                        },
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.lightBlue[200],
                    minimumSize:
                        Size(screenSize.width * 0.9, screenSize.height * 0.07),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    if (selectedCategory != null &&
                        selectedJobCategory != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Result(
                                devType: selectedCategory,
                                role: selectedJobCategory)),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('직무와 직책을 모두 선택해주세요'),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    '검색',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SelectableCategoryItem extends StatelessWidget {
  final Map<String, dynamic> category;
  final bool isSelected;
  final ValueChanged<bool> onSelected;

  const SelectableCategoryItem({
    required this.category,
    required this.isSelected,
    required this.onSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onSelected(!isSelected);
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.lightGreen[200] : category['color'],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              category['icon'],
              size: 30,
              color: Colors.white,
            ),
            const SizedBox(height: 10),
            Text(
              category['label'],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final List<Map<String, dynamic>> jobCategories = [
  {
    'color': Colors.indigo,
    'icon': Icons.child_care,
    'label': 'Junior',
    'param': 'junior'
  },
  {
    'color': Colors.indigo,
    'icon': Icons.person,
    'label': 'Mid-level',
    'param': 'mid-level'
  },
  {
    'color': Colors.indigo,
    'icon': Icons.escalator_warning,
    'label': 'Senior',
    'param': 'senior'
  },
];

final List<Map<String, dynamic>> categories = [
  {
    'color': Colors.green[400],
    'icon': Icons.storage,
    'label': '데이터베이스 관리자',
    'num': '1'
  },
  {
    'color': Colors.green[400],
    'icon': Icons.business,
    'label': '데이터 / 비즈니스 \n분석가',
    'num': '2'
  },
  {
    'color': Colors.green[400],
    'icon': Icons.science,
    'label': '데이터 과학자 / \n머신러닝 전문가',
    'num': '3'
  },
  {
    'color': Colors.green[400],
    'icon': Icons.support,
    'label': '개발자 옹호자',
    'num': '4'
  },
  {
    'color': Colors.green[400],
    'icon': Icons.developer_mode,
    'label': '백엔드 개발자',
    'num': '5'
  },
  {
    'color': Colors.green[400],
    'icon': Icons.web,
    'label': '프론트엔드 개발자',
    'num': '6'
  },
  {
    'color': Colors.green[400],
    'icon': Icons.fullscreen,
    'label': '풀스택 개발자',
    'num': '7'
  },
  {
    'color': Colors.green[400],
    'icon': Icons.sports_esports,
    'label': '게임/그래픽 개발자',
    'num': '8'
  },
  {
    'color': Colors.green[400],
    'icon': Icons.phone_android,
    'label': '모바일 개발자',
    'num': '9'
  },
  {
    'color': Colors.green[400],
    'icon': Icons.bug_report,
    'label': 'QA/테스트 개발자',
    'num': '10'
  },
  {
    'color': Colors.green[400],
    'icon': Icons.cloud,
    'label': 'DevOps 전문가',
    'num': '11'
  },
  {
    'color': Colors.green[400],
    'icon': Icons.data_usage,
    'label': '데이터 엔지니어',
    'num': '12'
  },
  {
    'color': Colors.green[400],
    'icon': Icons.manage_accounts,
    'label': '제품 관리자',
    'num': '13'
  },
  {
    'color': Colors.green[400],
    'icon': Icons.design_services,
    'label': 'UX/UI 디자이너',
    'num': '14'
  },
];
