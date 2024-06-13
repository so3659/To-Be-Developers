import 'package:bigdata_project/caterory.dart';
import 'package:bigdata_project/WebView/inflearn.dart';
import 'package:bigdata_project/WebView/udemy.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Homepage(),
      theme: ThemeData(
        primaryColor: Colors.lightBlue[200],
      ),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late final WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
          return Future.value(false);
        } else {
          bool? exitApp = await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('앱 종료'),
              content: const Text('정말로 종료하시겠어요? 🥺'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('아니오'),
                ),
                TextButton(
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  child: const Text('예'),
                ),
              ],
            ),
          );
          return exitApp ?? false;
        }
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CatalogScreen()),
                  );
                },
                child: const Text(
                  '나에게 맞는 직무는?',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin:
                      EdgeInsets.fromLTRB(10, screenSize.height * 0.05, 10, 20),
                  child: SizedBox(
                    height: screenSize.height * 0.35, // 전체 화면 높이의 25%를 높이로 설정
                    width: screenSize.width * 0.7, // 전체 화면 너비의 40%를 너비로 설정
                    child: FloatingActionButton(
                      heroTag: 'inflearn',
                      backgroundColor: Colors.white,
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Inflearn()),
                        );
                      },
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image(
                            image: AssetImage('assets/inflearn_logo.png'),
                            height: 150,
                            width: 150,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.fromLTRB(10, screenSize.height * 0.05, 10, 20),
                  child: SizedBox(
                    height: screenSize.height * 0.35, // 전체 화면 높이의 25%를 높이로 설정
                    width: screenSize.width * 0.7, // 전체 화면 너비의 40%를 너비로 설정
                    child: FloatingActionButton(
                      heroTag: 'udemy',
                      backgroundColor: Colors.white,
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Udemy()),
                        );
                      },
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image(
                            image: AssetImage('assets/Udemy_logo.png'),
                            height: 150,
                            width: 150,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
