import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop/Widgets/ContactUs.dart';
import 'package:shop/Widgets/ItemsEdit.dart';
import 'package:shop/Widgets/OrdersScreen.dart';
import 'package:shop/main.dart';
import 'package:provider/provider.dart';
import '../Provider/Login.dart';

class DrawerItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 15,
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('CWS CART'),
            automaticallyImplyLeading: false,
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(Shop.id);
            },
            leading: Icon(Icons.shop),
            title: Text(
              'CWS CART',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(OrdersScreen.id);
            },
            leading: Icon(Icons.payment),
            title: Text(
              'ORDERS',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(ItemEdit.id);
            },
            leading: Icon(Icons.edit),
            title: Text(
              'MANAGE PRODUCTS',
              softWrap: true,
              overflow: TextOverflow.fade,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(Contact.id);
            },
            leading: Icon(Icons.contact_phone),
            title: Text(
              'CONTACT US',
              softWrap: true,
              overflow: TextOverflow.fade,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Consumer<Login>(
            builder: (ctx, login, _) => ListTile(
              onTap: () {
                login.logout();
              },
              leading: Icon(Icons.exit_to_app),
              title: Text(
                'LOG OUT',
                softWrap: true,
                overflow: TextOverflow.fade,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),

//          Row(
//            children: <Widget>[
//              IconButton(icon: Icon(Icons.shop),),
//              Text('Menu')
//            ],
//          )
        ],
      ),
    );
  }
}
