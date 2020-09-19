import 'package:flutter/material.dart';
import '../Models/CartModel.dart';

class CardItem extends StatelessWidget {
  final Cart cart;
  final index;
  CardItem(this.cart, this.index);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 15,
      child: Dismissible(
        confirmDismiss: (direction) {
          return showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    title: Text(
                      'Are You Sure?',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    content: Text('Do you want to delete the item from Cart?'),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('yes'),
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                      ),
                      FlatButton(
                        child: Text('no'),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                      ),
                    ],
                  ));
        },
        background: Container(
          padding: EdgeInsets.only(right: 20),
          color: Theme.of(context).errorColor,
          child: Icon(
            Icons.delete,
            size: 40,
          ),
          alignment: Alignment.centerRight,
        ),
        key: Key(DateTime.now().toString()),
        onDismissed: (direction) {
          final title = cart.items.values.elementAt(index).title;
          cart.removeElement(cart.items.keys.elementAt(index));
          Scaffold.of(context).hideCurrentSnackBar();
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text("$title dismissed")));
        },
        child: ListTile(
            title: Text(cart.items.values.elementAt(index).title),
            subtitle: Text(
                '${cart.items.values.elementAt(index).quantity.toString()} *'),
            leading: chip(cart.items.values.elementAt(index).price)),
      ),
    );
  }
}

class chip extends StatelessWidget {
  final double price;
  chip(this.price);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        '₹${price.toStringAsFixed(2)}',
        softWrap: true,
        style: TextStyle(
          color: Theme.of(context).primaryTextTheme.headline6.color,
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
