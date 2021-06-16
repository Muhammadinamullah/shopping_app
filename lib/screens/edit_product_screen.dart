import 'package:flutter/material.dart';
import '../providers/products.dart';
import '../providers/product.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routePath = '/edit-product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _formGlobalKey = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: null,
    title: '',
    description: '',
    price: 0,
    imageUrl: '',
  );

  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };
  //var _isInit = true;

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _saveForm() {
    final _isValid = _formGlobalKey.currentState.validate();
    if (!_isValid) {
      return;
    }
    _formGlobalKey.currentState.save();
    Provider.of(context, listen: false).addProduct(_editedProduct);
    Navigator.of(context).pop();
    // print(_editedProduct.id);
    // print(_editedProduct.title);
    // print(_editedProduct.description);
    // print(_editedProduct.imageUrl);
    // print(_editedProduct.price);
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      validator:
      // ignore: unnecessary_statements
      (value) {
        if (_imageUrlController.text.isEmpty ||
            !_imageUrlController.text.startsWith('http') &&
                !_imageUrlController.text.startsWith('https') ||
            !_imageUrlController.text.endsWith('.png') &&
                !_imageUrlController.text.endsWith('.jpg') &&
                !_imageUrlController.text.endsWith('.jpeg')) {
          return;
        }
      };
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Products'),
        actions: [IconButton(onPressed: _saveForm, icon: Icon(Icons.save))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formGlobalKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                // ignore: missing_return
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter the Title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedProduct = Product(
                      id: _editedProduct.id,
                      title: value,
                      description: _editedProduct.description,
                      price: _editedProduct.price,
                      imageUrl: _editedProduct.imageUrl);
                },
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Price',
                ),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                // ignore: missing_return
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter the Price!';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please Enter valid amount!';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Please enter valid pirice';
                  }
                  ;
                },
                onSaved: (value) {
                  _editedProduct = Product(
                      id: _editedProduct.id,
                      title: _editedProduct.title,
                      description: _editedProduct.description,
                      price: double.parse(value),
                      imageUrl: _editedProduct.imageUrl);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                focusNode: _descriptionFocusNode,
                onSaved: (value) {
                  _editedProduct = Product(
                      id: _editedProduct.id,
                      title: _editedProduct.title,
                      description: value,
                      price: _editedProduct.price,
                      imageUrl: _editedProduct.imageUrl);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter Description about Product!';
                  }
                  if (value.length < 10) {
                    return 'Description must be atleast 10 characters!';
                  }
                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 8, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? Text('Enter a URL')
                        : FittedBox(
                            child: Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  Expanded(
                      child: TextFormField(
                    decoration: InputDecoration(labelText: 'Image URL'),
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.done,
                    controller: _imageUrlController,
                    onSaved: (value) {
                      _editedProduct = Product(
                          id: _editedProduct.id,
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          price: _editedProduct.price,
                          imageUrl: value);
                    },
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter Image url';
                      }
                      if (!value.startsWith('http') &&
                          !value.startsWith('https')) {
                        return 'Please enter Valid URL';
                      }
                      if (!value.endsWith('.png') &&
                          !value.endsWith('.jpg') &&
                          !value.endsWith('.jpeg')) {
                        return 'Please enter Valid URL';
                      }
                    },
                    onEditingComplete: () {
                      setState(() {});
                    },
                  )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
