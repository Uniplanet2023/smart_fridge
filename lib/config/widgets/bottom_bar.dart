import 'package:flutter/material.dart';
import 'package:smart_fridge/features/items/presentation/pages/fridge_items_page.dart';
import 'package:smart_fridge/features/profile/presentation/pages/profile_page.dart';
import 'package:smart_fridge/features/recipes/presentation/pages/recipes_page.dart';
import 'package:smart_fridge/features/add/presentation/pages/add.dart';

import '../../features/home/presentation/pages/home_page.dart';

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
      HomePage(),
      RecipesPage(),
      AddPage(),
      FridgeItemsPage(),
      ProfilePage(),
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
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.restaurant_sharp,
                ),
                label: "Recipes"),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add_box_outlined,
              ),
              label: "Add",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
              ),
              label: "Items",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline_sharp,
              ),
              label: "Profile",
            ),
          ]),
    );
  }
}
