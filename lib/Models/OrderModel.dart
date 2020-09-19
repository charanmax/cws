import 'dart:convert';

import 'package:flutter/material.dart';
import '../Models/CartModel.dart';
import 'package:http/http.dart' as http;

class OrderModel {
  final String id;
  final double total;
  final DateTime dateTime;
  final List<CartItems> orders;
  OrderModel(
      {@required this.dateTime,
      @required this.id,
      @required this.total,
      @required this.orders});
}

class Orders with ChangeNotifier {
  final String token;
  List<OrderModel> _items = [];
  final String userId;

  Orders(this.token, this.userId, this._items);

  List<CartItems> orders;

  List<OrderModel> get items {
    return [..._items];
  }

  Future<void> addOrder(
      String id, double total, List<CartItems> orders, String token) async {
    final url =
        'https://shop-12f67.firebaseio.com/orders/$userId.json?auth=$token';
    final DateTime date = DateTime.now();

    await http.post(url,
        body: jsonEncode({
          'dateTime': date.toIso8601String(),
          'total': total,
          'orders': orders
              .map((element) => {
                    'price': element.price,
                    'id': element.id,
                    'title': element.title,
                    'quantity': element.quantity,
                  })
              .toList(),
        }));
    final response = await http.get(url);
    final data = jsonDecode(response.body) as Map<String, dynamic>;

    List<OrderModel> cartItems = [];
    data.forEach((key, value) {
      cartItems.insert(
          0,
          OrderModel(
              id: key,
              total: value['total'],
              dateTime: DateTime.parse(value['dateTime']),
              orders: (value['orders'] as List<dynamic>)
                  .map((e) => CartItems(
                      id: e['id'],
                      title: e['title'],
                      price: e['price'],
                      quantity: e['quantity']))
                  .toList()));
    });
    final price = cartItems[0].total;
    print(price);

    _items = cartItems;

    notifyListeners();
  }

//  Future<void> getAndSetOrders() async {
//    try {
//      final List<OrderModel> list = [];
//      final url = 'https://shop-12f67.firebaseio.com/orders.json?auth=$token';
//      final response = await http.get(url);
//      final responseBody = jsonDecode(response.body) as Map<String, dynamic>;
//      print(responseBody);
//      responseBody.forEach((key, value) {
//        print(value[' total']);
//        list.add(OrderModel(
//          id: key,
//          dateTime: DateTime.parse(value['dateTime']),
//          total: value['total'],
//          orders: (value['orders'] as List<dynamic>).map((element) {
//            orders.add(CartItems(
//              id: element['id'],
//              price: element['price'],
//              title: element['title'],
//              quantity: element['quantity'],
//            ));
//          }).toList(),
//        ));
//      });
//    } catch (er) {}
//  }
}
