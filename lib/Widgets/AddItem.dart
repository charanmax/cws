import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../Models/Shopitems.dart';
import 'package:provider/provider.dart';
import '../Constants/Items.dart';

class AddItem extends StatefulWidget {
  static const String id = '/AddItem';
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  bool _isInit = true;
  bool _showSpinner = false;
  final _priceFocusNode = FocusNode();
  final _descFocusNode = FocusNode();
  var _imageUrl;
  var dataModel;
  Product dataItem;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    dataModel = Provider.of<Items>(context, listen: false);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      dataItem = ModalRoute.of(context).settings.arguments as Product;
      _imageUrl = TextEditingController(
          text: dataItem == null ? '' : dataItem.imageUrl);
      _isInit = false;
    }
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  void dispose() {
    _descFocusNode.dispose();
    _priceFocusNode.dispose();
    _imageUrl.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void saveItem(Items dataModel) {
    if (_fbKey.currentState.saveAndValidate()) {
      final Map<String, Object> data = _fbKey.currentState.value;

      if (dataItem != null) {
        final Product productItem = Product(
          price: double.parse(data['price']),
          title: data['title'],
          id: dataItem.id,
          description: data['description'],
          imageUrl: data['imageUrl'],
          isFavourite: dataItem.isFavourite,
        );
        dataModel.updateItem(productItem).then((value) {
          setState(() {
            _showSpinner = false;
          });

          print(productItem);
          Navigator.pop(context);
        });
      } else {
        print("hey");
        final Product productItem = Product(
            price: double.parse(data['price']),
            title: data['title'],
            id: DateTime.now().toString(),
            description: data['description'],
            imageUrl: data['imageUrl']);
        dataModel.addItem(productItem).then((value) {
          setState(() {
            _showSpinner = false;
          });

          print(productItem);
          Navigator.pop(context);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add New Item'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                setState(() {
                  _showSpinner = true;
                });
                saveItem(dataModel);
              },
            )
          ],
        ),
        body: _showSpinner
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                child: ListView(
                  children: <Widget>[
                    FormBuilder(
                      key: _fbKey,
                      child: Column(
                        children: <Widget>[
                          FormBuilderTextField(
                            initialValue:
                                dataItem == null ? '' : dataItem.title,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            attribute: "title",
                            decoration: InputDecoration(labelText: "Title"),
                            validators: [
                              FormBuilderValidators.required(
                                  errorText: 'The title is required'),
                            ],
                            onFieldSubmitted: (_) {
                              print("test");

                              FocusScope.of(context)
                                  .requestFocus(_priceFocusNode);
                            },
                          ),
                          FormBuilderTextField(
                            initialValue: dataItem == null
                                ? ''
                                : dataItem.price.toString(),
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_descFocusNode);
                            },
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            attribute: "price",
                            decoration: InputDecoration(labelText: "Price"),
                            validators: [
                              FormBuilderValidators.required(
                                  errorText: 'The price is required'),
                              FormBuilderValidators.numeric(
                                  errorText: 'price should be numeric'),
                            ],
                            focusNode: _priceFocusNode,
                          ),
                          FormBuilderTextField(
                            initialValue:
                                dataItem == null ? '' : dataItem.description,
                            onFieldSubmitted: (_) {
//                      FocusScope.of(context).requestFocus(_descFocusNode);
                            },
                            keyboardType: TextInputType.multiline,
                            attribute: "description",
                            decoration:
                                InputDecoration(labelText: "Description"),
                            validators: [
                              FormBuilderValidators.required(
                                  errorText: 'This field is required'),
                              FormBuilderValidators.minLength(10,
                                  errorText: 'please enter more info')
                            ],
                            focusNode: _descFocusNode,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                height: 100,
                                width: 100,
                                margin: EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 8),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: Colors.grey,
                                )),
                                child: FittedBox(
                                  child: _imageUrl.text.isEmpty
                                      ? Container()
                                      : Image.network(
                                          _imageUrl.text,
                                          fit: BoxFit.cover,
                                        ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Expanded(
                                child: FormBuilderTextField(
                                  controller: _imageUrl,
                                  onFieldSubmitted: (_) {
                                    setState(() {});
                                  },
                                  keyboardType: TextInputType.url,
                                  attribute: "imageUrl",
                                  textInputAction: TextInputAction.done,
                                  decoration: InputDecoration(labelText: "url"),
                                  validators: [
                                    FormBuilderValidators.required(
                                        errorText: 'The url is required'),
                                    FormBuilderValidators.url(
                                        errorText: 'Please enter a valid url'),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
