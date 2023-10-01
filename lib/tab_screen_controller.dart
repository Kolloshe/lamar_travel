// ignore_for_file: library_private_types_in_public_api

import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/Datahandler/app_data.dart';

import 'package:lamar_travel_packages/screen/main_screen1.dart';
import 'package:lamar_travel_packages/screen/newsearch/new_search.dart';

import 'package:lamar_travel_packages/setting/setting.dart';
import 'package:provider/provider.dart';

import 'config.dart';

// late PersistentTabController tabController;
// int pagenum = 0;
// bool hidenavebar = false;

class TabPage extends StatefulWidget {
  const TabPage({Key? key, this.restore}) : super(key: key);
  static String idScreen = 'TabPage';
  final int? restore;

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  List<Widget> page = [
    const MainScreen(),
    SearchStepper(
      section: -1,
      isFromNavBar: true,
      searchMode: '',
    ),
    Setting(false)
  ];

  late PageController _pageController;

  int _selectedIndex = 0;

  @override
  void initState() {
    _pageController = PageController();
    if (widget.restore != null) {
      //   _selectedIndex = widget . restore!;
    }
    // tabController = PersistentTabController(initialIndex: 0);

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              if (index == 1) {
                context.read<AppData>().searchMode = '';
              }
              setState(() => _selectedIndex = index);
            },
            children: page),
      ),
      bottomNavigationBar: SizedBox(
        height: MediaQuery.of(context).size.height * 0.08,
        child: CustomNavigationBar(
          iconSize: 25.0,
          selectedColor: primaryblue,
          strokeColor:const Color(0x300c18fb),
          unSelectedColor: Colors.grey[600],
          backgroundColor: Colors.white,
          items: [
            CustomNavigationBarItem(
              icon:const Icon(Icons.home),
            ),
            CustomNavigationBarItem(
              icon:const Icon(Icons.search),
            ),
            CustomNavigationBarItem(
              icon:const Icon(Icons.settings),
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
              _pageController.jumpToPage(index);
            });
          },
        ),
      ),
    );
  }
}
