import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop/Models/Shopitems.dart';
import 'package:shop/Widgets/AddItem.dart';
import 'DrawerBar.dart';
import 'package:provider/provider.dart';
import '../Constants/Items.dart';
import 'package:http/http.dart' as http;
import '../Provider/Login.dart';

class ItemEdit extends StatefulWidget {
  static const String id = '/ItemEdit';

  @override
  _ItemEditState createState() => _ItemEditState();
}

class _ItemEditState extends State<ItemEdit> {
  List<Product> userProducts;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//    final List data = Provider.of<Items>(context).items;
    print("hello");

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddItem.id);
            },
          )
        ],
        title: Text('Your Items'),
        elevation: 15,
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
        child: FutureBuilder(
          future:
              Provider.of<Items>(context, listen: false).fetchAndSetItems(true),
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : RefreshIndicator(
                      onRefresh: () async {
                        Provider.of<Items>(context, listen: false)
                            .fetchAndSetItems(true);
                      },
                      child: Consumer<Items>(
                        builder: (ctx, data, _) => ListView.builder(
                          itemBuilder: (c, i) => Card(
                            elevation: 15,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(data.items[i].imageUrl),
                              ),
                              title: Text(data.items[i].title),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    color: Theme.of(context).errorColor,
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          AddItem.id,
                                          arguments: data.items[i]);
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    color: Theme.of(context).errorColor,
                                    onPressed: () {
//                        data.removeItem(i);
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                          itemCount: data.items.length,
                        ),
                      ),
                    ),
        ),
      ),
    );
  }
}
