import 'package:flutter/material.dart';
import 'package:shop/Widgets/AddItem.dart';
import 'package:shop/Widgets/ItemInfo.dart';
import 'package:shop/Widgets/ItemsEdit.dart';

import 'package:shop/Widgets/auth_screen.dart';
import 'Widgets/OrdersScreen.dart';
import 'Widgets/Products.dart';
import 'package:provider/provider.dart';
import 'Constants/Items.dart';
import 'Models/CartModel.dart';
import 'Widgets/CartScreen.dart';
import 'Models/OrderModel.dart';
import 'Provider/Login.dart';
import 'Widgets/ContactUs.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (c) => Login(),
        ),
        ChangeNotifierProxyProvider<Login, Items>(
          update: (context, Login, previous) => Items(Login.token, Login.userId,
              Login.expiry, previous == null ? [] : previous.items),
        ),
        ChangeNotifierProxyProvider<Login, Orders>(
          update: (context, Login, previous) => Orders(Login.token,
              Login.userId, previous == null ? [] : previous.items),
        ),
        ChangeNotifierProvider(
          create: (c) => Cart(),
        ),
      ],
      child: Consumer<Login>(
        builder: (context, Login, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              appBarTheme: AppBarTheme(
                color: Colors.redAccent,
              ),
              fontFamily: 'Fondamento',
              primarySwatch: Colors.purple,
              accentColor: Colors.amber,
              textTheme: TextTheme(
                  headline6: TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontFamily: 'Fondamento',
                fontWeight: FontWeight.w700,
              ))),
          home: Login.isAuthenticated
              ? Shop()
              : FutureBuilder(
                  future: Login.autoLogin(),
                  builder: (c, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : AuthScreen(),
                ),
          routes: {
            Shop.id: (ctx) => Shop(),
            AuthScreen.id: (ctx) => AuthScreen(),
            CartScreen.id: (ctx) => CartScreen(),
            OrdersScreen.id: (ctx) => OrdersScreen(),
            ItemInfo.id: (ctx) => ItemInfo(),
            ItemEdit.id: (ctx) => ItemEdit(),
            AddItem.id: (c) => AddItem(),
            Contact.id: (c) => Contact(),
          },
        ),
      ),
    );
  }
}

class Shop extends StatelessWidget {
  static const id = '/ShopScreen';

  @override
  Widget build(BuildContext context) {
    return ProductsDisplay();
  }
}
