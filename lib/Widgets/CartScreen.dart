import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:shop/Widgets/OrdersScreen.dart';

import '../Provider/Login.dart';
import '../Models/CartModel.dart';
import '../Widgets/CartItem.dart';
import '../Models/OrderModel.dart';
import '../Widgets/DrawerBar.dart';

class CartScreen extends StatefulWidget {
  static const String id = '/CartScreen';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _showSpinner = false;
  @override
  Widget build(BuildContext context) {
    final token = Provider.of<Login>(context, listen: false).token;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 15,
        title: Text(
          'Your Cart',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      drawer: DrawerItem(),
      body: _showSpinner
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.withOpacity(0.7),
                    Colors.red.withOpacity(0.7),
//                  Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
//                  Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 1.0],
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Consumer<Cart>(
                        builder: (c, Cart, child) => Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    const Text(
                                      'Total',
                                      style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Spacer(),
                                    chip(Cart.totalPrice),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Consumer<Orders>(
                                      builder: (ctx, Orders, child) =>
                                          FlatButton(
                                        child: Text(
                                          "ORDER NOW",
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .primaryTextTheme
                                                .headline6
                                                .color,
                                          ),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _showSpinner = true;
                                          });

                                          Orders.addOrder(
                                                  DateTime.now().toString(),
                                                  Cart.totalPrice,
                                                  Cart.items.values.toList(),
                                                  token)
                                              .then((value) {
                                            setState(() {
                                              Future.delayed(Duration.zero)
                                                  .then((value) {
                                                _showSpinner = false;
                                              });

                                              Navigator.pushNamed(
                                                  context, OrdersScreen.id,
                                                  arguments: Cart.items);
                                              Cart.removeItems();
                                            });
                                          });
                                        },
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                Text(
                                  'Swipe to delete a cart item',
                                  style: TextStyle(fontSize: 20),
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.7,
                                  child: ListView.builder(
                                      itemCount: Cart.items.length,
                                      itemBuilder: (context, index) =>
                                          CardItem(Cart, index)),
                                )
                              ],
                            ))
                  ],
                ),
              ),
            ),
    );
  }
}
