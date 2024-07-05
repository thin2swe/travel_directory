import 'package:flutter/material.dart';

import 'package:travel_directory/Navbar.dart';

import 'package:travel_directory/reviews_screen.dart';
import 'package:travel_directory/screens/Destinations.dart';

import 'package:travel_directory/screens/Tour_Packages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smile Tour',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Destinations'),
    Tab(text: 'Tour Packages'),
    Tab(text: 'Reviews'),
  ];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: myTabs.length,
        vsync: this); // Length must match the number of tabs
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navbar(),
      appBar: AppBar(
        title: Text('Smile Tour'),
        backgroundColor: Color.fromARGB(255, 25, 173, 199),
        bottom: TabBar(
          controller: _tabController,
          tabs: myTabs,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: myTabs.map((Tab tab) {
          if (tab.text == 'Destinations') {
            return Destinations();
          } else if (tab.text == 'Tour Packages') {
            return TourPackages();
          } else {
            return ReviewPage();
          }
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            _tabController.animateTo((_tabController.index + 1) % 2),
        child: Icon(Icons.swap_horiz),
      ),
    );
  }
}
