import 'package:flutter/material.dart';
import 'package:insta_clone/screens/account_page.dart';
import 'package:insta_clone/screens/home_page.dart';
import 'package:insta_clone/screens/reels_page.dart';
import 'package:insta_clone/screens/search_page.dart';
import 'package:insta_clone/screens/shop_page.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _currentPage = 0;

  final List<Widget> pages = [
    const HomePage(),
    const SearchPage(),
    const ReelsPage(),
    const ShopPage(),
    const AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentPage],
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  _currentPage = 0;
                });
              },
              icon: Icon(
                Icons.home,
                color: _currentPage == 0
                    ? const Color.fromRGBO(203, 73, 101, 1)
                    : const Color.fromRGBO(40, 40, 40, 1),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _currentPage = 1;
                });
              },
              icon: Icon(
                Icons.search,
                color: _currentPage == 1
                    ? const Color.fromRGBO(203, 73, 101, 1)
                    : const Color.fromRGBO(40, 40, 40, 1),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _currentPage = 2;
                });
              },
              icon: Icon(
                Icons.ondemand_video,
                color: _currentPage == 2
                    ? const Color.fromRGBO(203, 73, 101, 1)
                    : const Color.fromRGBO(40, 40, 40, 1),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _currentPage = 3;
                });
              },
              icon: Icon(
                Icons.card_travel,
                color: _currentPage == 3
                    ? const Color.fromRGBO(203, 73, 101, 1)
                    : const Color.fromRGBO(40, 40, 40, 1),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _currentPage = 4;
                });
              },
              icon: Icon(
                Icons.person,
                color: _currentPage == 4
                    ? const Color.fromRGBO(203, 73, 101, 1)
                    : const Color.fromRGBO(40, 40, 40, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
