import 'dart:convert';

import 'package:flutter/material.dart';
import '../Models/Shopitems.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../Provider/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Items with ChangeNotifier {
  bool _showFavourites = false;
  List<Product> _products = [
//    Product(
//      id: 'p1',
//      title: 'OnePlus Bullets',
//      description:
//          'With the OnePlus Bullets Wireless Z Bluetooth Headset, you can experience low-latency, high-quality immersive audio no matter wherever you are. This headset features a Quick Switch feature to switch between devices, Quick Pair for fast pairing, and a 9.2 mm Dynamic Driver for foot-tapping music.',
//      price: 10000,
//      imageUrl:
//          'https://rukminim1.flixcart.com/image/150/150/k2arbm80/headphone/c/v/m/realme-buds-original-imafhzf2yxgn8hyh.jpeg?q=70',
//    ),
//    Product(
//      id: 'p2',
//      title: 'Trousers',
//      description:
//          'This slim-fit chino pant features wrinkle-free fabric, a flat-front design, and button-through back welt pockets for a tailored look and all-day comfort...',
//      price: 59.99,
//      imageUrl:
//          'https://allensolly.imgix.net/img/app/product/3/320083-1494770.jpg',
//    ),
//    Product(
//      id: 'p3',
//      title: 'Laptop',
//      description:
//          'If you are a multitasker, then this laptop is ideal for you. It comes with the 10th Gen Intel Core i3-10110U processor, along with a DDR4 RAM of 4 GB, which can be increased if needed. On top of that, it boasts a compact, sleek, and lightweight design, making it your ideal travel partner. Furthermore, its nearly bezel-free NanoEdge display comes with up to 87% screen-to-body ratio so that you can see every detail.',
//      price: 50.567,
//      imageUrl:
//          'https://i.dell.com/is/image/DellContent//content/dam/global-site-design/product_images/dell_client_products/notebooks/inspiron_notebooks/15_3582/pdp/notebook-inspiron-15-3582-in-pdp-gallery-504x350.jpg?fmt=jpg&wid=570&hei=400',
//    ),
//    Product(
//      id: 'p4',
//      title: 'Pocophone',
//      description:
//          '  Meet the POCO F1 - the first flagship smartphone from POCO by Xiaomi. The POCO F1 sports Qualcomm flagship Snapdragon 845 processor, an octa-core CPU with a maximum clock speed of 2.8 GHz which is supported by 6 GB of LPDDR4X RAM. It is coupled with a LiquidCool Technology that allows the device to sustain peak performance for a longer period of time. On the back, it features a 12MP + 5MP Dual Pixel AI dual camera setup. The main camera sensor features 1.4 um pixels, Dual Pixel Autofocus, and Multi-frame noise reduction. On the front, it sports a 20 MP high-res front camera and IR Face unlock. POCO F1 also boasts of a massive 4000 mAh (typ) battery with Quick Charge 3.0 to keep you going all-day long.',
//      price: 20.566,
//      imageUrl:
//          'https://static.toiimg.com/thumb/msid-65515912,width-240,resizemode-4,imgv-1/Xiaomi-Poco-F1.jpg',
//    ),
//    Product(
//        id: 'p5',
//        title: 'A powerful Ups',
//        description:
//            'The Luminous UPS helps deliver continuous power supply so your important data and tasks don’t get affected when there is a power outage in your area. This line-interactive UPS offers a seamless supply of power for high-end gaming PCs, PS4 consoles, Xbox consoles, desktops, and more.',
//        price: 59.99,
//        imageUrl:
//            'https://image.shutterstock.com/image-photo/uninterruptible-power-supply-ups-on-600w-232049215.jpg'),
//    Product(
//      id: 'p6',
//      title: 'Fridge',
//      description:
//          'With this refrigerator from Samsung, you can relish the freshness of your fruits and vegetables, thanks to features like the spacious Vege Box and Antibacterial Gasket. You won’t need to invest in an external stabiliser, thanks to its stabiliser-free operation. Equipped with toughened glass shelves, this fridge can hold up to 150 kg and you can store food in heavy and large utensils.',
//      price: 59.99,
//      imageUrl:
//          'https://images.samsung.com/is/image/samsung/in-rf9500kf-akg-rf28n9780sg-tl-frontblack-107074192?\$PD_GALLERY_L_JPG\$',
//    ),
//    Product(
//      id: 'p7',
//      title: 'Realme Tv',
//      description:
//          'Bezel-less Design:This realme TV’s Bezel-less design makes it a thing of beauty. Thanks to its 8.7 mm thin bezels, this TV makes your favourite video content highly immersive.',
//      price: 25000,
//      imageUrl:
//          'https://rukminim1.flixcart.com/image/416/416/kae95e80/television/f/6/y/realme-tv-32-original-imafrz79pweqeafh.jpeg?q=70',
//    ),
//    Product(
//        id: 'p8',
//        title: 'AC',
//        description:
//            'Don\'t worry about sweaty days and uncomfortable nights - bring home the MarQ by Flipkart AC to experience pleasant summers. Featuring a 100% copper condenser, this AC ensures energy saving and easy maintenance while its Humidity Regulation and Control feature senses and controls the humidity levels to provide you with a cool and pleasant ambiance throughout. That\'s not all, this AC also comes with a Hidden Display feature which switches off the LED display with just a click on the remote and its Sleep Mode reduces excessive cooling',
//        price: 25000,
//        imageUrl:
//            'https://rukminim1.flixcart.com/image/312/312/jt7jhjk0/air-conditioner-new/6/8/4/fkac153siainc-1-5-inverter-marq-by-flipkart-original-imafehzvkjkf4hnu.jpeg?q=70'),
  ];

  final token;
  final userId;
  final DateTime expiryDate;
  Items(this.token, this.userId, this.expiryDate, this._products);

  List<Product> get items {
    if (_showFavourites) {
      return _products.where((element) => element.isFavourite).toList();
    }
    return [..._products];
  }

  List userProducts = [];

  void removeItem(int index) {
    _products.removeAt(index);
    notifyListeners();
  }

  List get userList {
    return userProducts;
  }

  Future<void> fetchAndSetItems([bool getUser = false]) async {
    try {
      final urlString = '&orderBy="creatorId"&equalTo="$userId"';
      var url;
      getUser == false
          ? url = 'https://shop-12f67.firebaseio.com/products.json?auth=$token'
          : url =
              'https://shop-12f67.firebaseio.com/products.json?auth=$token&orderBy="creatorId"&equalTo="$userId"';
      final url2 =
          'https://shop-12f67.firebaseio.com/userFavourites/$userId.json?auth=$token';
      final response2 = await http.get(url2);
      final userFavourites = json.decode(response2.body);
      final response = await http.get(url);
      final decodedData = jsonDecode(response.body);

      final List<Product> _loadedProducts = [];
      final data = decodedData as Map<String, dynamic>;
      data.forEach((key, value) {
        _loadedProducts.add(Product(
          title: value['title'],
          id: key,
          imageUrl: value['imageUrl'],
          description: value['description'],
          price: value['price'],
          isFavourite:
              userFavourites == null ? false : userFavourites[key] ?? false,
        ));
      });
      _products = _loadedProducts;
      final prefs = await SharedPreferences.getInstance();
      final prodData = jsonEncode({
        'userId': userId,
        'tokenId': token,
        'expiresIn': expiryDate.toIso8601String(),
      });
      prefs.setString('userData', prodData);
    } catch (error) {
      print('error');
      throw error;
    }

    notifyListeners();

//    final String id, imageUrl, title, description;
//    double price;
//    bool isFavourite;
//    final url =
//        'https://shop-12f67.firebaseio.com/userProducts/$userId.json?auth=$token';
//    final response = await http.get(url);
//    final responseBody = json.decode(response.body);
//    final userProductsList = responseBody;
////    userProductsList.forEach((key, value) => print(value));
//
//    userProductsList.forEach((key, value) {
//      String title = value['title'];
//      String id = key;
//      double price = value['price'];
//      String description = value['description'];
//      String imageUrl = value['imageUrl'];
//      userProducts.add(Product(
//        title: title,
//        price: price,
//        id: id,
//        description: description,
//        imageUrl: imageUrl,
//      ));
//    });
//    print(userProducts);
  }

  Future<void> addItem(Product product) {
    final url = 'https://shop-12f67.firebaseio.com/products.json?auth=$token';

    return http
        .post(url,
            body: jsonEncode({
              'title': product.title,
              'description': product.description,
              'price': product.price,
              'imageUrl': product.imageUrl,
              'creatorId': userId,
            }))
        .then((value) {
      _products.add(Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: jsonDecode(value.body)['name'],
      ));

      print(jsonDecode(value.body)['name']);

      notifyListeners();
    });
  }

  Future<void> updateItem(Product product) async {
    final index = _products.indexWhere((element) {
      return element.id == product.id;
    });
    if (index >= 0) {
      _products[index] = product;
    }

    final url =
        'https://shop-12f67.firebaseio.com/products/${product.id}.json?auth=$token';

    await http.patch(url,
        body: jsonEncode({
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
        }));
  }

  Product findById(String id) {
    Product data;
    _products.forEach((element) {
      if (element.id == id) {
        data = element;
      }
    });
    return data;
  }

  void showFav() {
    _showFavourites = true;
    notifyListeners();
  }

  void showAll() {
    _showFavourites = false;
    notifyListeners();
  }

  void logout() {}
}

//Product(
//id: 'p1',
//title: 'Red Shirt',
//description: 'A red shirt - it is pretty red!',
//price: 29.99,
//imageUrl:
//'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
//),
//Product(
//id: 'p2',
//title: 'Trousers',
//description: 'A nice pair of trousers.',
//price: 59.99,
//imageUrl:
//'https://allensolly.imgix.net/img/app/product/3/320083-1494770.jpg',
//),
//Product(
//id: 'p3',
//title: 'Laptop',
//description: 'Gaming Laptop',
//price: 50.567,
//imageUrl:
//'https://i.dell.com/is/image/DellContent//content/dam/global-site-design/product_images/dell_client_products/notebooks/inspiron_notebooks/15_3582/pdp/notebook-inspiron-15-3582-in-pdp-gallery-504x350.jpg?fmt=jpg&wid=570&hei=400',
//),
//Product(
//id: 'p4',
//title: 'Pocophone',
//description: 'SmartPhone',
//price: 20.566,
//imageUrl:
//'https://static.toiimg.com/thumb/msid-65515912,width-240,resizemode-4,imgv-1/Xiaomi-Poco-F1.jpg',
//),
//Product(
//id: 'p5',
//title: 'Ups',
//description: 'A Powerful Ups.',
//price: 59.99,
//imageUrl:
//'https://image.shutterstock.com/image-photo/uninterruptible-power-supply-ups-on-600w-232049215.jpg'),
//Product(
//id: 'p6',
//title: 'Fridge',
//description: 'A multi-functionality Fridge.',
//price: 59.99,
//imageUrl:
//'https://images.samsung.com/is/image/samsung/in-rf9500kf-akg-rf28n9780sg-tl-frontblack-107074192?\$PD_GALLERY_L_JPG\$',
//),
