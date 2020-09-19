import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shop/Widgets/CartScreen.dart';
import 'package:shop/Widgets/auth_screen.dart';
import '../Constants/Items.dart';
import 'Product_Builder.dart';
import 'package:badges/badges.dart';
import '../Models/CartModel.dart';
import '../Widgets/DrawerBar.dart';
import '../Models/Shopitems.dart';
import 'package:dio/dio.dart';

enum show { favourite, all }

class ProductsDisplay extends StatefulWidget {
  @override
  _ProductsDisplayState createState() => _ProductsDisplayState();
}

class _ProductsDisplayState extends State<ProductsDisplay> {
  bool _isLoading = false;
  bool _isInit = true;
  Items dataModel;

  void _showError(error) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              elevation: 15,
              title: Text(
                'Oops! An Error Occurred',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              content: Text('Try again later'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushReplacementNamed(context, AuthScreen.id);
                  },
                )
              ],
            ));
  }

  Future<void> getData() async {
    try {
      await Provider.of<Items>(context).fetchAndSetItems();
    } catch (error) {}
  }

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      try {
        dataModel = Provider.of<Items>(context);
        _isLoading = true;

        await dataModel.fetchAndSetItems();
        Dio dio = new Dio();
        final response =
            await dio.download("https://www.google.com/", "./xx.html");
        print(response);
      } catch (error) {
        print(error);
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//    final dataModel = Provider.of<Items>(context, listen: false);
    //final List<Product> data = Provider.of<Items>(context, listen: false).items;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 15,
        title: Text(
          'CWS CART',
          style: TextStyle(fontFamily: 'Fondamento'),
        ),
        actions: <Widget>[
          Consumer<Cart>(
            builder: (c, Cart, child) => GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(CartScreen.id);
              },
              child: Badge(
                animationType: BadgeAnimationType.slide,
                badgeColor: Theme.of(context).accentColor,
                badgeContent: Text(
                    Cart.items == null ? '0' : Cart.items.length.toString()),
                child: Icon(Icons.shopping_cart),
                elevation: 15,
                borderRadius: 9,
              ),
            ),
          ),
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            onSelected: (show value) {
              if (value == show.favourite) {
                dataModel.showFav();
              } else {
                dataModel.showAll();
              }
            },
            itemBuilder: (ctx) {
              return [
                PopupMenuItem(
                  child: Text('Select Favourites'),
                  value: show.favourite,
                ),
                PopupMenuItem(
                  child: Text('Show All'),
                  value: show.all,
                )
              ];
            },
          )
        ],
      ),
      drawer: DrawerItem(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: getData,
              child: Container(
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
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10
//              maxCrossAxisExtent: 400,
//              crossAxisSpacing: 3 / 2,
                      ),
                  itemBuilder: ((context, index) {
                    return GridBuilder(dataModel.items[index]);
                  }),
                  itemCount: dataModel.items.length,
                ),
              ),
            ),
    );
  }
}
