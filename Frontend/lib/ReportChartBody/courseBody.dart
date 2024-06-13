import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseBody extends StatefulWidget {
  const CourseBody(
      {super.key,
      required this.title,
      required this.content,
      required this.url});

  final String title;
  final String content;
  final String url;

  @override
  State<CourseBody> createState() => _CourseBodyState();
}

class _CourseBodyState extends State<CourseBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: InkWell(
          onTap: () async {
            final url = Uri.parse('https://www.inflearn.com${widget.url}');
            await launchUrl(url);
          },
          child: Column(
            children: [
              SizedBox(
                width: 200.0, // 원하는 너비 설정
                height: 200.0, // 원하는 높이 설정
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: widget.content == 'NONE'
                      ? Image.asset(
                          'assets/inflearn_logo.png',
                          fit: BoxFit.contain,
                        )
                      : Image.network(
                          widget.content,
                          fit: BoxFit.contain,
                        ),
                ),
              ),
              Text(
                widget.title,
                style:
                    const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ));
  }
}
