import 'package:flutter/material.dart';

import '../Themes/app_colors.dart';
import '../pages/Menu.dart';
import '../pages/Qaza.dart';
import '../pages/home_page.dart';
import '../pages/qibla.dart';

class Bottomnavigation extends StatefulWidget {
  const Bottomnavigation({super.key});

  @override
  State<Bottomnavigation> createState() => _BottomnavigationState();
}

class _BottomnavigationState extends State<Bottomnavigation> {
  int _selectedIndex = 0;
  final List<Widget> pages = [
     MyHomePage(),
     QiblaPage(),
     QazaUmriPage(),
     MenuPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return  BottomNavigationBar(
            backgroundColor: Colors.white,
          elevation: 8,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.darkgreen,
          unselectedItemColor: Colors.black,
          currentIndex: _selectedIndex,
      onTap: (index) {
    setState(() => _selectedIndex = index);
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => pages[index]),
    );
    },

    items: [
            BottomNavigationBarItem(
              icon: Image.asset("assets/icons/home.png", height: 20),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Image.asset("assets/icons/landmark.png", height: 20),
              label: 'Qibla',

            ),
            BottomNavigationBarItem(
              icon: Image.asset("assets/icons/islamic.png", height: 20),
              label: 'Qaza Umri',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.menu, color: Colors.black),
              label: 'Menu',
            ),
          ],


    );
  }
}
