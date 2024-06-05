import 'package:flutter/material.dart';

class CourseBody extends StatefulWidget {
  const CourseBody({super.key, required this.title, required this.content});

  final String title;
  final String content;

  @override
  State<CourseBody> createState() => _CourseBodyState();
}

class _CourseBodyState extends State<CourseBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(
            width: 200.0, // 원하는 너비 설정
            height: 200.0, // 원하는 높이 설정
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                widget.content,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Text(
            widget.title,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
