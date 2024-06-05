import 'package:bigdata_project/result.dart';
import 'package:flutter/material.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  _CatalogScreenState createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  RangeValues priceRange = const RangeValues(0, 30000);
  Set<String> filters = {};
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
              _buildCategoryRow(),
              const Divider(),
              const Text(
                '직책',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: screenSize.height * 0.02),
              _buildCareerCategoryRow(context),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.lightBlue[200],
                          minimumSize: Size(
                              screenSize.width * 0.9, screenSize.height * 0.07),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Result()),
                        );
                      },
                      child: const Text('검색',
                          style: TextStyle(fontSize: 15, color: Colors.white))))
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryRow() {
    List<String> categories = [
      '프론트앤드',
      '백앤드',
      'AI',
      '빅데이터',
      '블록체인',
      '머신러닝',
      '게임개발',
      '데이터분석'
    ];
    return Wrap(
      spacing: 8.0,
      children: categories.map((category) {
        return FilterChip(
          showCheckmark: false,
          selectedColor: Colors.lightGreen[200],
          label: Text(category),
          selected: filters.contains(category),
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                filters.add(category);
              } else {
                filters.remove(category);
              }
            });
          },
        );
      }).toList(),
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
            selected: filters.contains(category),
            onSelected: (bool selected) {
              setState(() {
                if (selected) {
                  filters.add(category);
                } else {
                  filters.remove(category);
                }
              });
            },
          ),
        );
      }).toList(),
    );
  }
}
