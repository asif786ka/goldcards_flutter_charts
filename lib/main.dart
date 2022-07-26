import 'package:flutter/material.dart';

import 'bar_chart/bar_chart_page.dart';
import 'bar_chart/bar_chart_page2.dart';
import 'line_chart/line_chart_page.dart';
import 'pie_chart/pie_chart_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GoldCards Demo',
      showPerformanceOverlay: false,
      theme: ThemeData(
        primaryColor: const Color(0xff262545),
        primaryColorDark: const Color(0xff201f39),
        brightness: Brightness.dark,
      ),
      home: const MyHomePage(title: 'GoldCards Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentPage = 0;

  final _controller = PageController(initialPage: 0);
  final _pages = const [
    LineChartPage(),
    BarChartPage(),
    BarChartPage2(),
    PieChartPage()
  ];


  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _currentPage = _controller.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: _controller,
          children: _pages,
          onPageChanged: (page) {
            setState(() {
              _currentPage = page;
            });
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: 'Gold Line'),
          BottomNavigationBarItem(icon: Icon(Icons.money), label: 'Gold Bar'),
          BottomNavigationBarItem(
              icon: Icon(Icons.money_off_outlined), label: 'Gold Transactions'),
          BottomNavigationBarItem(
              icon: Icon(Icons.food_bank), label: 'Gold Pie')
        ],
        onTap: _onTappedBar,
        selectedItemColor: Colors.orange,
        currentIndex: _currentPage,

      ),
    );
  }

  void _onTappedBar(int value) {
    setState(() {
      _currentPage = value;
    });
    _controller.jumpToPage(value);
  }

}
