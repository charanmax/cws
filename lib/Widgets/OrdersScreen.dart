import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop/Models/CartModel.dart';
import 'package:shop/Widgets/DrawerBar.dart';

import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../Models/OrderModel.dart';
import 'dart:math';

class OrdersScreen extends StatefulWidget {
  static const String id = '/OrdersScreen';
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool toggleIcon = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data =
        ModalRoute.of(context).settings.arguments as Map<String, CartItems>;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Orders',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      drawer: DrawerItem(),
      body: Container(
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
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Consumer<Orders>(
            builder: (ctx, Orders, child) => Orders.items.length == 0
                ? Center(
                    child: Text('No Orders Yet '),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Order Total',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 450,
                          child: ListView.builder(
                            itemCount: Orders.items.length,
                            itemBuilder: (context, index) => Column(
                              children: <Widget>[
                                Card(
                                  margin: EdgeInsets.all(10),
                                  child: ListTile(
                                    title: Text(
                                      '₹${Orders.items[index].total}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15),
                                    ),
                                    subtitle: Text(
                                        DateFormat('dd/MM/yyyy hh:mm').format(
                                            Orders.items[index].dateTime),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15)),
                                    trailing: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          toggleIcon = !toggleIcon;
                                        });
                                      },
                                      icon: Icon(toggleIcon
                                          ? Icons.expand_less
                                          : Icons.expand_more),
                                    ),
                                  ),
                                ),
                                if (toggleIcon)
                                  Container(
                                    height: min(
                                        Orders.items[index].orders.length *
                                                20.0 +
                                            100,
                                        180),
                                    child: ListView(
                                      children: Orders.items[index].orders
                                          .map((e) => Row(
                                                children: <Widget>[
                                                  Text(
                                                    e.title,
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  Text(
                                                    e.price.toStringAsFixed(2),
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.grey),
                                                  )
                                                ],
                                              ))
                                          .toList(),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
