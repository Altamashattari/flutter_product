import 'package:first_app/models/product.dart';
import 'package:first_app/scoped_models/main.dart';
import 'package:first_app/widgets/helpers/ensure-visible.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductCreatePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductCreatePageState();
  }
}

class _ProductCreatePageState extends State<ProductCreatePage> {
  //String _titleValue, _description;
  //double _priceValue;
  Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'price': null,
    'image': 'images/food.jpg'
  };

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _titleFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();

  Widget _buildTitleTextField(Product product) {
    return EnsureVisibleWhenFocused(
        focusNode: _titleFocusNode,
        child: TextFormField(
            focusNode: _titleFocusNode,
            //TextField
            decoration: InputDecoration(labelText: 'Product Title'),
            initialValue: product == null ? '' : product.title,
            //autovalidate: true,
            validator: (String value) {
              //if(value.trim().length <=0) return 'Title is Required';
              if (value.isEmpty || value.length < 5)
                return 'Title is Required and should be 5+ characters longs';
            },
            onSaved: (String value) {
              //  setState(() {
              //if (widget.product == null)
              _formData['title'] = value;
              //else
              // widget.product.title = value;
              // });
            }));
  }

  Widget _buildPriceTextField(Product product) {
    return EnsureVisibleWhenFocused(
        focusNode: _priceFocusNode,
        child: TextFormField(
            focusNode: _priceFocusNode,
            decoration: InputDecoration(labelText: 'Product Price'),
            initialValue: product == null ? '' : product.price.toString(),
            keyboardType: TextInputType.number,
            validator: (String value) {
              if (value.isEmpty ||
                  !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
                return 'Price is required and should be a number';
              }
            },
            onSaved: (String value) {
              //setState(() {
              // if (widget.product == null)
              _formData['price'] = double.parse(value);
              // else
              //   widget.product.price = double.parse(value);
              //});
            }));
  }

  Widget _buildDescriptionTextField(Product product) {
    return EnsureVisibleWhenFocused(
        focusNode: _descriptionFocusNode,
        child: TextFormField(
            focusNode: _descriptionFocusNode,
            decoration: InputDecoration(labelText: 'Product Description'),
            initialValue: product == null ? '' : product.description,
            validator: (String value) {
              //if(value.trim().length <=0) return 'Title is Required';
              if (value.isEmpty || value.length < 10)
                return 'Description is Required and should be 10+ characters longs';
            },
            maxLines: 4,
            onSaved: (String value) {
              // setState(() {
              //if (widget.product == null)
              _formData['description'] = value;
              //else
              //widget.product.description = value;
              //});
            }));
  }

  void onPressSave(
      Function addProduct, Function updateProduct, Function setSelectedProduct,
      [int selectedProductIndex]) {
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();
    if (selectedProductIndex == -1) {
      // final Map<String, dynamic> product = {
      //   'title': _formData['title'],
      //   'description': _formData['description'],
      //   'price': _formData['price'],
      //   'image': 'images/food.jpg'
      // };
      addProduct(_formData['title'], _formData['description'],
              _formData['image'], _formData['price'])
          .then((bool success) {
        if (success) {
          Navigator.pushReplacementNamed(context, '/products')
              .then((_) => setSelectedProduct(null));
        } else {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Something went wrong!'),
                  content: Text('Please try again'),
                  actions: <Widget>[
                    FlatButton(
                        child: Text('Okay'),
                        onPressed: () => Navigator.of(context).pop())
                  ],
                );
              });
        }
      });
    } else {
      updateProduct(_formData['title'], _formData['description'],
              _formData['image'], _formData['price'])
          .then((_) => Navigator.pushReplacementNamed(context, '/products')
              .then((_) => setSelectedProduct(null)));
    }
  }

  Widget _buildSubmitButton() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return model.isLoading
            ? Center(
                child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlue,
              ))
            : RaisedButton(
                //color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                child: Text('Save'),
                onPressed: () => onPressSave(
                    model.addProduct,
                    model.updateProduct,
                    model.selectProduct,
                    model.selectedProductIndex),
              );
      },
    );
  }

  Widget _buildPageContent(BuildContext context, Product product) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 500.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(
            FocusNode()); // to close keyboard if we tap anywhere other than text input - return emplty focusnode
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
            children: <Widget>[
              _buildTitleTextField(product),
              _buildDescriptionTextField(product),
              _buildPriceTextField(product),
              SizedBox(
                  height: 10.0), // add some space vertically or horizontally

              _buildSubmitButton(),
              /*GestureDetector(            // used to create all kinds of listener events
            onTap : onPressSave,
            child: Container(
              color: Colors.green,
              padding: EdgeInsets.all(5.0),
              child: Text('MY Button'),
            ),
          )*/
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    /*return Center(
      child: RaisedButton(child: Text('Save'),
      onPressed: (){
        showModalBottomSheet(context: context, builder: (BuildContext context){
          return Center(child: Text("This is a Modal"),);
        });
      },
      ),
    );*/
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        final Widget pageContent =
            _buildPageContent(context, model.selectedProduct);
        return model.selectedProductIndex == -1
            ? pageContent
            : Scaffold(
                appBar: AppBar(
                  title: Text('Edit Product'),
                ),
                body: pageContent,
              );
      },
    );
  }
}
