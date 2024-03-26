import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kamus_kebidanan/pages/dasboad_screen.dart';
import 'package:kamus_kebidanan/pages/verif_screen.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int selectedIndex = 0;
  final screen = [
    const DashboardPage(),
    const VerifPage(),
  ];
  final GlobalKey _key = GlobalKey();
  GlobalKey getKey() => _key;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: getKey(),
        index: selectedIndex,
        items: const [
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.list_alt,
            size: 30,
            color: Colors.white,
          ),
        ],
        color: HexColor('#1BA542'),
        buttonBackgroundColor: HexColor('#1BA542'),
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOutBack,
        animationDuration: const Duration(milliseconds: 400),
        height: 70,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
      body: screen[selectedIndex],
    );
  }
}
