import 'package:first_app/models/product.dart';
import 'package:first_app/scoped_models/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import './product_card.dart';
import 'package:scoped_model/scoped_model.dart';

class Products extends StatelessWidget {

  _buildProductList(List<Product> products){
    return products.length > 0
        ? ListView.builder(
            // this approach is more efficient when the length of the list is very long ; it removes the item from display when it is not visible and add when it is scrolled down to a next element
            itemBuilder: (BuildContext context,int index) => ProductCard(products[index], index),
            itemCount: products.length,
          )
        : Center(child: Text("No Products Available ! "));
  }

  @override
  Widget build(BuildContext context) {
    /*  return ListView(                                  // listview - this approach is useful when the length of list of known and short
                children: products
                    .map((element) => Card(
                          child: Column(
                            children: <Widget>[
                              Image.asset('images/food.jpg'),
                              Text(element)
                            ],
                          ),
                        ))
                    .toList(),
              );*/
    return ScopedModelDescendant<MainModel>(builder: (BuildContext context,Widget child , MainModel model){
      return _buildProductList(model.displayedProducts);
    },);
  }

  // when you dont want to render anything , returning null will throw an error as widget is expected
  // return Container() which return empty container and dont occupy any space in UI

}
