import 'package:flutter/material.dart';
import 'grocery_item.dart';

class GroceryManger extends ChangeNotifier {
  final _groceryItems = <GroceryItem>[];

  List<GroceryItem> get groceryItems => List.unmodifiable(_groceryItems);

  String getItemId(int index) {
    final groceryItem = _groceryItems[index];
    return groceryItem.id;
  }

  GroceryItem? getGroceryItem(String id) {
    final index = _groceryItems.indexWhere(
      (element) => element.id == id,
    );
    if (index == -1) return null;
    return groceryItems[index];
  }

  void deleteItem(int index) {
    _groceryItems.removeAt(index);
    notifyListeners();
  }

  void addItem(GroceryItem item) {
    _groceryItems.add(item);
    notifyListeners();
  }

  void updateItem(GroceryItem item) {
    final index = _groceryItems.indexWhere(
      (element) => element.id == item.id,
    );
    _groceryItems[index] = item;
    notifyListeners();
  }

  void completeItem(int index, bool change) {
    final item = _groceryItems[index];
    _groceryItems[index] = item.copyWith(
      isComplete: change,
    );
    notifyListeners();
  }
}
