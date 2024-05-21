import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'custom_nav_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
  static List<Widget> pages = const [
    Center(child: Text("HomeBody")),
    Center(child: Text("categoryBody")),
    Center(child: Text("FavoriteBody")),
    Center(child: Text("ProfileBody")),
  ];
}

// const Color kMainColor = Color(0xffFF592C);
class _HomeViewState extends State<HomeView> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeView.pages[currentIndex],
      bottomNavigationBar: CustomNavBar(
        selectedColorOpacity: 0.8,
        unSelectedColorOpacity: 0.3,
        currentIndex: currentIndex,
        onTap: (value) => setState(() => currentIndex = value),
        backgroundColor: const Color(0xffFF592C),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        itemPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        items: _buildNavBarItems(),
      ),
    );
  }

  List<NavBarButtonItem> _buildNavBarItems() {
    return [
      _buildNavBarItem(
        iconPath: "assets/icons/home_icon.svg",
        title: "Home",
      ),
      _buildNavBarItem(
        iconPath: "assets/icons/category_icon.svg",
        title: "Category",
      ),
      _buildNavBarItem(
        iconPath: "assets/icons/favourite_icon.svg",
        title: "Favourites",
      ),
      _buildNavBarItem(
        iconPath: "assets/icons/profile_icon.svg",
        title: "Profile",
      ),
    ];
  }

  NavBarButtonItem _buildNavBarItem({required String iconPath, required String title}) {
    return NavBarButtonItem(
      icon: SvgPicture.asset(
        iconPath,
        width: 25,
        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
      ),
      title: Text(
        title,
        style: const TextStyle(color: Color(0xffFF592C)),
      ),
    );
  }
}

