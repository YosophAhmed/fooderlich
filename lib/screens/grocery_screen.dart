import 'package:flutter/material.dart';
import 'empty_grocery_screen.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import 'grocery_item_screen.dart';
import 'grocery_list_screen.dart';

class GroceryScreen extends StatelessWidget {
  const GroceryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final manger = Provider.of<GroceryManger>(context, listen: false);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GroceryItemScreen(
                  onCreate: (item) {
                    manger.addItem(item);
                    Navigator.pop(context);
                  },
                  onUpdate: (item) {},
                ),
              ));
        },
      ),
      body: buildGroceryScreen(),
    );
  }

  Widget buildGroceryScreen() {
    return Consumer<GroceryManger>(builder: (context, manger, child) {
      if (manger.groceryItems.isNotEmpty) {
        return GroceryListScreen(groceryManger: manger);
      } else {
        return const EmptyGroceryScreen();
      }
    });
  }
}
