import 'package:flutter/material.dart';
import 'package:shop/Widgets/DrawerBar.dart';

class Contact extends StatelessWidget {
  static const id = '/Contact';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: DrawerItem(),
        appBar: AppBar(
          centerTitle: true,
          elevation: 15,
          title: Text(
            'Contact Us',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        body: SafeArea(
          child: Container(
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  child: ClipRRect(
                    child: Image.network(
                      'https://cwservices.co.in/images/White%20Background%20Logo%20PNG.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  radius: 50.0,
                ),
                Text(
                  'CWS',
                  style: TextStyle(
                    fontFamily: 'Pacifico',
                    fontSize: 30.0,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'CWS SOLUTIONS',
                ),
                SizedBox(
                  height: 20.0,
                  width: 150.0,
                  child: Divider(
                    color: Colors.teal.shade100,
                  ),
                ),
                Card(
                  color: Colors.white,
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.phone,
                      color: Colors.teal,
                    ),
                    title: Text(
                      '+91 9175467891',
                    ),
                  ),
                ),
                Card(
                  color: Colors.white,
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.email,
                      color: Colors.teal,
                    ),
                    title: Text(
                      'cws@email.com',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Fondamento',
                        color: Colors.teal.shade900,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
