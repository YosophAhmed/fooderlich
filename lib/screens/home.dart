import 'package:flutter/material.dart';
import 'package:fooderlich/screens/explore_screen.dart';
import 'recipes_screen.dart';
import 'grocery_screen.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';

class Home extends StatefulWidget {
  final int currentTab;

  const Home({
    super.key,
    required this.currentTab,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static List<Widget> pages = [
    ExploreScreen(),
    RecipesScreen(),
    const GroceryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateManger>(builder: (
      context,
      appStateManger,
      child,
    ) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Fooderlich',
            style: Theme.of(context).textTheme.headline6,
          ),
          centerTitle: true,
          actions: [
            profileButton(widget.currentTab),
          ],
        ),
        body: IndexedStack(
          index: appStateManger.getSelectedTab,
          children: pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor:
              Theme.of(context).textSelectionTheme.selectionColor,
          currentIndex: appStateManger.getSelectedTab,
          onTap: (index) {
            appStateManger.goToTab(index: index);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Recipes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'To Buy',
            ),
          ],
        ),
      );
    });
  }

  Widget profileButton(int currentTab) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: GestureDetector(
        child: const CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage(
            'assets/profile_pics/person_stef.jpeg',
          ),
        ),
        onTap: () {},
      ),
    );
  }
}
