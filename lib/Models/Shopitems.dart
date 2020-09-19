import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id, imageUrl, title, description;
  double price;
  bool isFavourite;

  Product(
      {@required this.title,
      @required this.id,
      @required this.imageUrl,
      @required this.price,
      @required this.description,
      this.isFavourite = false});

  Future<void> toggleFavourite(String token, String userId) async {
    isFavourite = !isFavourite;
    final url =
        'https://shop-12f67.firebaseio.com/userFavourites/$userId/$id.json?auth=$token';
    print(url);

    await http
        .put(url,
            body: jsonEncode(
              isFavourite,
            ))
        .then((value) {
      print(value.body);
    });
    notifyListeners();
  }
}
//}
//  List<Product> _products = [
//    Product(
//      id: 'p1',
//      title: 'Red Shirt',
//      description: 'A red shirt - it is pretty red!',
//      price: 29.99,
//      imageUrl:
//          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
//    ),
//    Product(
//      id: 'p2',
//      title: 'Trousers',
//      description: 'A nice pair of trousers.',
//      price: 59.99,
//      imageUrl:
//          'https://allensolly.imgix.net/img/app/product/3/320083-1494770.jpg',
//    ),
//    Product(
//      id: 'p3',
//      title: 'Laptop',
//      description: 'Gaming Laptop',
//      price: 50.567,
//      imageUrl:
//          'https://i.dell.com/is/image/DellContent//content/dam/global-site-design/product_images/dell_client_products/notebooks/inspiron_notebooks/15_3582/pdp/notebook-inspiron-15-3582-in-pdp-gallery-504x350.jpg?fmt=jpg&wid=570&hei=400',
//    ),
//    Product(
//      id: 'p4',
//      title: 'Pocophone',
//      description: 'SmartPhone',
//      price: 20.566,
//      imageUrl:
//          'https://static.toiimg.com/thumb/msid-65515912,width-240,resizemode-4,imgv-1/Xiaomi-Poco-F1.jpg',
//    ),
//    Product(
//        id: 'p5',
//        title: 'Ups',
//        description: 'A Powerful Ups.',
//        price: 59.99,
//        imageUrl:
//            'https://image.shutterstock.com/image-photo/uninterruptible-power-supply-ups-on-600w-232049215.jpg'),
//    Product(
//      id: 'p6',
//      title: 'Fridge',
//      description: 'A multi-functionality Fridge.',
//      price: 59.99,
//      imageUrl:
//          'https://images.samsung.com/is/image/samsung/in-rf9500kf-akg-rf28n9780sg-tl-frontblack-107074192?\$PD_GALLERY_L_JPG\$',
//    ),
//  ];
//
//  List<Product> get items {
//    print([..._products]);
//    return [..._products];
//  }
//
//  void addItem() {
//    //   _products.add(value);
//    notifyListeners();
//  }
//}
