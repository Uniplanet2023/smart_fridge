import 'package:flutter/material.dart';
import 'package:smart_fridge/features/items/screens/fridge_items.dart';
import 'package:smart_fridge/features/profile/screens/profile_screen.dart';
import 'package:smart_fridge/features/recipes/screens/recipes_screen.dart';
import 'package:smart_fridge/features/scan-receipts/scan_receipts.dart';

import '../../features/home/screens/home_screen.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = const [
      HomeScreen(),
      RecipesScreen(),
      ScanReceiptsScreen(),
      FridgeItemsScreen(),
      ProfileScreen(),
    ];
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _page,
          elevation: 5,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          onTap: updatePage,
          items: const <BottomNavigationBarItem>[
            const BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                ),
                label: 'Home'),
            const BottomNavigationBarItem(
                icon: Icon(
                  Icons.restaurant_sharp,
                ),
                label: "Recipes"),
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.add_box_outlined,
              ),
              label: "Scan",
            ),
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
              ),
              label: "Items",
            ),
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline_sharp,
              ),
              label: "Profile",
            ),
          ]),
    );
  }
}
