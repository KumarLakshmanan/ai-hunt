import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../api_services/apiservices.dart';
import 'ai_news.dart';
import 'ai_tools.dart';

class Home_page extends StatefulWidget {
  const Home_page({super.key});

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  int index = 0;
  List page = [const AiToolsPage(), const AiNewsPage()];
  bool title = true;
  List tools = [];

  @override
  void initState() {
    // TODO: implement initState
    Apiservice().ainewsData();
    print("hbjmb");
    Apiservice().toolsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title == true ? "App Tools" : "App News",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: page[index],
      bottomNavigationBar: AnimatedBottomNavigationBar(
        height: 100,
        gapLocation: GapLocation.center,
        gapWidth: 1,
        rightCornerRadius: 20,
        iconSize: 30,
        leftCornerRadius: 20,
        backgroundColor: Color.fromARGB(167, 18, 1, 90),
        activeColor: Colors.white60,
        activeIndex: index,
        icons: [
          Icons.speaker,
          Icons.home,
        ],
        onTap: (nt) {
          setState(() {
            index = nt;
            print(index);
            if (nt == 0) {
              title = true;
            } else if (nt == 1) {
              title = false;
            }
          });
        },
      ),
    );
  }
}
