//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
//import 'package:flutter_form_builder/flutter_form_builder.dart';
//import 'package:shop/Widgets/DrawerBar.dart';
//import 'package:shop/Widgets/OrdersScreen.dart';
//
//class UserDetails extends StatelessWidget {
//  static const id = '/UserDetails';
//  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
//  @override
//  Widget build(BuildContext context) {
//    return SafeArea(
//      child: Scaffold(
//        drawer: DrawerItem(),
//        appBar: AppBar(
//          centerTitle: true,
//          elevation: 15,
//          title: Text(
//            'CWS CART',
//            style: TextStyle(fontFamily: 'Fondamento'),
//          ),
//        ),
//        body: Container(
//          decoration: BoxDecoration(
//            gradient: LinearGradient(
//              colors: [
//                Colors.blue.withOpacity(0.7),
//                Colors.red.withOpacity(0.7),
////                  Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
////                  Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
//              ],
//              begin: Alignment.topLeft,
//              end: Alignment.bottomRight,
//              stops: [0.0, 1.0],
//            ),
//          ),
//          height: MediaQuery.of(context).size.height -
//              MediaQuery.of(context).padding.top -
//              MediaQuery.of(context).viewInsets.top,
//          child: SingleChildScrollView(
//            child: Column(children: <Widget>[
//              FormBuilder(
//                key: _fbKey,
//                child: Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: Column(
//                    children: <Widget>[
//                      FormBuilderTextField(
//                        attribute: "name",
//                        decoration:
//                            InputDecoration(labelText: "Enter Your Name"),
//                        validators: [
//                          FormBuilderValidators.required(),
//                        ],
//                      ),
//                      FormBuilderTextField(
//                        attribute: "address",
//                        decoration:
//                            InputDecoration(labelText: "Enter Your Address"),
//                        validators: [
//                          FormBuilderValidators.required(),
//                        ],
//                      ),
//                      FormBuilderTextField(
//                        attribute: "landmark",
//                        decoration: InputDecoration(labelText: "Any Landmarks"),
//                        validators: [
//                          FormBuilderValidators.required(),
//                        ],
//                      ),
//                      FormBuilderTextField(
//                        attribute: "phno",
//                        decoration: InputDecoration(labelText: "Contact no"),
//                        validators: [
//                          FormBuilderValidators.required(),
//                          FormBuilderValidators.numeric(
//                              errorText: 'Value should be numeric'),
//                        ],
//                      ),
//                      FormBuilderDropdown(
//                        attribute: "state",
//                        decoration: InputDecoration(labelText: "state"),
//                        // initialValue: 'Male',
//                        hint: Text('Select State'),
//                        validators: [FormBuilderValidators.required()],
//                        items: [
//                          "Andhra Pradesh",
//                          "Arunachal Pradesh",
//                          "Assam",
//                          "Bihar",
//                          "Chhattisgarh",
//                          "Goa",
//                          "Gujarat",
//                          "Haryana",
//                          "Himachal Pradesh",
//                          "Jammu and Kashmir",
//                          "Jharkhand",
//                          "Karnataka",
//                          "Kerala",
//                          "Madhya Pradesh",
//                          "Maharashtra",
//                          "Manipur",
//                          "Meghalaya",
//                          "Mizoram",
//                          "Nagaland",
//                          "Odisha",
//                          "Punjab",
//                          "Rajasthan",
//                          "Sikkim",
//                          "Tamil Nadu",
//                          "Telangana",
//                          "Tripura",
//                          "Uttarakhand",
//                          "Uttar Pradesh",
//                          "West Bengal",
//                          "Andaman and Nicobar Islands",
//                          "Chandigarh",
//                          "Dadra and Nagar Haveli",
//                          "Daman and Diu",
//                          "Delhi",
//                          "Lakshadweep",
//                          "Puducherry"
//                        ]
//                            .map((state) => DropdownMenuItem(
//                                value: state, child: Text("$state")))
//                            .toList(),
//                      ),
//                      SizedBox(
//                        height: 40,
//                      ),
//                      Row(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          children: <Widget>[
//                            FlatButton(
//                              child: Text(
//                                "Order Now",
//                                style: TextStyle(
//                                    color: Colors.white, fontSize: 20),
//                              ),
//                              color: Colors.redAccent,
//                              onPressed: () {
//                                if (_fbKey.currentState.saveAndValidate()) {
//                                  print(_fbKey.currentState.value);
//                                  Navigator.of(context)
//                                      .pushNamed(OrdersScreen.id);
//                                }
//                              },
//                            ),
//                          ])
//                    ],
//                  ),
//                ),
//              )
//            ]),
//          ),
//        ),
//      ),
//    );
//  }
//}
