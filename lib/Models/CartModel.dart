import 'package:flutter/material.dart';

class CartItems {
  final String id, title;
  final double price;
  int quantity;
  CartItems({
    @required this.id,
    @required this.title,
    @required this.price,
    this.quantity,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItems> _items = {};

  void addItem(String id, String title, double price) {
    if (_items.containsKey(id)) {
      _items.update(id, (value) {
        return CartItems(
            id: DateTime.now().toString(),
            title: title,
            price: price,
            quantity: value.quantity + 1);
      });
    } else {
      _items.putIfAbsent(id, () {
        return CartItems(
            id: DateTime.now().toString(),
            title: title,
            price: price,
            quantity: 1);
      });
    }
    notifyListeners();
  }

  Map<String, CartItems> get items {
    return {..._items};
  }

  void removeItems() {
    _items = {};
    notifyListeners();
  }

  void removeSingleItem(String id) {
    if (!_items.containsKey(id)) {
      return;
    }
    if (_items[id].quantity > 1) {
      _items.update(
          id,
          (value) => CartItems(
              id: value.id,
              title: value.title,
              price: value.price,
              quantity: value.quantity - 1));
    } else {
      _items.remove(id);
    }
    notifyListeners();
  }

  void removeElement(String id) {
    print(id);
    _items.remove(id);

    notifyListeners();
  }

  double get totalPrice {
    double total = 0;
    _items.forEach((key, value) {
      total += value.quantity * value.price;
    });
    return total;
  }
}
