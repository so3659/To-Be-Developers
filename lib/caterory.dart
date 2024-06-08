import 'package:flutter/material.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  _CatalogScreenState createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  RangeValues priceRange = const RangeValues(0, 30000);
  Set<String> selectedCategories = {};
  Set<String> selectedJobCategories = {};

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
                  height: 730, // 적절한 높이 설정
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
                        isSelected:
                            selectedCategories.contains(category['label']),
                        onSelected: (isSelected) {
                          setState(() {
                            if (isSelected) {
                              selectedCategories.add(category['label']);
                            } else {
                              selectedCategories.remove(category['label']);
                            }
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
                  height: 400, // 적절한 높이 설정
                  child: GridView.builder(
                    physics:
                        const NeverScrollableScrollPhysics(), // 부모 스크롤에 영향을 받도록 설정
                    itemCount: jobCategories.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 7,
                      mainAxisSpacing: 7,
                    ),
                    itemBuilder: (context, index) {
                      final category = jobCategories[index];
                      return SelectableCategoryItem(
                        category: category,
                        isSelected:
                            selectedJobCategories.contains(category['label']),
                        onSelected: (isSelected) {
                          setState(() {
                            if (isSelected) {
                              selectedJobCategories.add(category['label']);
                            } else {
                              selectedJobCategories.remove(category['label']);
                            }
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ResultScreen()),
                    );
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

  Widget _buildCareerCategoryRow(BuildContext context) {
    List<String> categories = [
      'Junior',
      'Intermediate',
      'Senior',
      'Lead',
    ];

    final screenSize = MediaQuery.of(context).size;

    Icon getIcon(String category) {
      switch (category) {
        case 'Junior':
          return const Icon(Icons.child_care);
        case 'Intermediate':
          return const Icon(Icons.person);
        case 'Senior':
          return const Icon(Icons.escalator_warning);
        case 'Lead':
          return const Icon(Icons.star);
        default:
          return const Icon(Icons.star);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: categories.map((category) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: FilterChip(
            showCheckmark: false,
            avatar: getIcon(category),
            selectedColor: Colors.lightGreen[200],
            label: SizedBox(
              width: screenSize.width * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(category),
                ],
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            selected: selectedCategories.contains(category),
            onSelected: (bool selected) {
              setState(() {
                if (selected) {
                  selectedCategories.add(category);
                } else {
                  selectedCategories.remove(category);
                }
              });
            },
          ),
        );
      }).toList(),
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
              size: 50,
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
  {'color': Colors.purple, 'icon': Icons.child_care, 'label': 'Junior'},
  {
    'color': Colors.deepOrangeAccent,
    'icon': Icons.person,
    'label': 'Intermediate'
  },
  {
    'color': Colors.cyanAccent[200],
    'icon': Icons.escalator_warning,
    'label': 'Senior'
  },
  {'color': Colors.indigo, 'icon': Icons.star, 'label': 'Lead'},
];

final List<Map<String, dynamic>> categories = [
  {'color': Colors.red, 'icon': Icons.computer, 'label': '프론트엔드'},
  {'color': Colors.green, 'icon': Icons.code, 'label': '백엔드'},
  {'color': Colors.amber, 'icon': Icons.memory, 'label': 'AI'},
  {'color': Colors.blueAccent, 'icon': Icons.bar_chart, 'label': '빅데이터'},
  {'color': Colors.deepPurple, 'icon': Icons.block, 'label': '블록체인'},
  {'color': Colors.lightGreen, 'icon': Icons.school, 'label': '머신러닝'},
  {'color': Colors.brown, 'icon': Icons.games, 'label': '게임개발'},
  {'color': Colors.grey, 'icon': Icons.analytics, 'label': '데이터분석'},
];

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('검색 결과'),
      ),
      body: const Center(
        child: Text('검색 결과 화면'),
      ),
    );
  }
}
