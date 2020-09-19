import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Models/ExceptionClass.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  bool get isAuthenticated {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
//      print('hello');
      return true;
    }
    return false;
  }

  String get token {
    return _token;
  }

  DateTime get expiry {
    return _expiryDate;
  }

  Future<bool> autoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final userAuthData = prefs.getString('userData');
    final userDecodedData = json.decode(userAuthData);

    if (!userDecodedData.containsKey('userId')) {
      print("check");
      return false;
    }
    DateTime expiryTime = DateTime.parse(userDecodedData['expiresIn']);

    if (expiryTime.isBefore(DateTime.now())) {
      print("check1");
      return false;
    }
    print(userDecodedData['userId']);
    print(userDecodedData);
    _userId = userDecodedData['userId'];
    _expiryDate = expiryTime;
    _token = userDecodedData['tokenId'];
    notifyListeners();
    return true;
  }

  String get userId {
    return _userId;
  }

  Future<void> authenticate(
      String email, String password, String reference) async {
    var responseBody;
    try {
      final response = await http.post(
          'https://identitytoolkit.googleapis.com/v1/accounts:$reference?key=AIzaSyDFtQlnfX5xTiPPjeuGWHm2qomxGKOUlCc',
          body: jsonEncode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));
      responseBody = jsonDecode(response.body);

      if (responseBody['error'] != null) {
        throw HttpException(responseBody['error']['message']);
      }

      _token = responseBody['idToken'];
      _userId = responseBody['localId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseBody['expiresIn'])));
      notifyListeners();
    } catch (error) {
      print('error1');
      throw error;
    }
  }

  Future<void> signUp(String email, String password) async {
    return authenticate(email, password, 'signUp');
  }

  Future<void> signIn(String email, String password) async {
    return authenticate(email, password, 'signInWithPassword');
  }

  void logout() async {
    _userId = null;
    _token = null;
    _expiryDate = null;
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    notifyListeners();
  }

  void autoLogOut() {
    final expiry = _expiryDate.difference(DateTime.now()).inSeconds;
    print(expiry);
    Timer(Duration(seconds: 3), () {
      logout();
    });
  }
}
