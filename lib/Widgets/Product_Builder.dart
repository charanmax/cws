import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/Widgets/ItemInfo.dart';
import '../Provider/Login.dart';
import '../Models/CartModel.dart';

class GridBuilder extends StatefulWidget {
  final data;
  GridBuilder(this.data);

  @override
  _GridBuilderState createState() => _GridBuilderState();
}

class _GridBuilderState extends State<GridBuilder> {
  @override
  Widget build(BuildContext context) {
//  final data = Provider.of<Product>(context);
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(ItemInfo.id, arguments: widget.data);
      },
      child: Card(
        elevation: 15,
//              margin: EdgeInsets.all(15),
        child: GridTile(
          footer: GridTileBar(
              leading: Consumer<Login>(
                builder: (context, Login, child) => IconButton(
                  color: Colors.amber,
                  onPressed: () {
                    setState(() {
                      widget.data.toggleFavourite(Login.token, Login.userId);
                    });
                  },
                  icon: Icon(widget.data.isFavourite
                      ? Icons.favorite
                      : Icons.favorite_border),
                ),
              ),
              trailing: Consumer<Cart>(
                builder: (ctx, Cart, child) => IconButton(
                  color: Colors.amber,
                  onPressed: () {
                    Cart.addItem(
                        widget.data.id, widget.data.title, widget.data.price);
                    Scaffold.of(context).hideCurrentSnackBar();
                    Scaffold.of(context).showSnackBar(SnackBar(
                        action: SnackBarAction(
                          label: 'UNDO',
                          onPressed: () {
                            Cart.removeSingleItem(widget.data.id);
                          },
                        ),
                        content: Text("${widget.data.title} added to cart")));
                  },
                  icon: Icon(Icons.shopping_cart),
                ),
              ),
              backgroundColor: Colors.black54,
              title: Text(
                widget.data.title,
                style: TextStyle(fontFamily: 'Fondamento'),
                textAlign: TextAlign.center,
              )),
          child: Hero(
            tag: widget.data.id,
            child: FadeInImage(
              image: NetworkImage(
                widget.data.imageUrl,
              ),
              fit: BoxFit.cover,
              placeholder: AssetImage(
                'assets/images/placeholder.jpg',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
//                  decoration: BoxDecoration(
//                      gradient: LinearGradient(
//                    colors: [Colors.blue.withOpacity(0.7), Colors.blue],
//                    begin: Alignment.topLeft,
//                    end: Alignment.bottomRight,
//                  )),
//                child: Column(
//                  children: <Widget>[
//                    Expanded(
//                      child: ClipRRect(
//                        child: Image.network(
//
//                          fit: BoxFit.cover,
//                        ),
//                        borderRadius: BorderRadius.circular(15),
//                      ),
//                    ),
//                    Text(products[index].title),
//                  ],
//                ),
