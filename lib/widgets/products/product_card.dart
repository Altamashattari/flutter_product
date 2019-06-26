import 'package:first_app/models/product.dart';
import 'package:first_app/scoped_models/main.dart';
import 'package:first_app/widgets/products/address_tag.dart';
import 'package:first_app/widgets/ui_elements/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import './price_tag.dart';

class ProductCard extends StatelessWidget {
  final Product products;
  final int index;

  ProductCard(this.products, this.index);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          FadeInImage(
            image: NetworkImage(products.image),
            height: 300.0,
            fit: BoxFit.cover,
            placeholder: AssetImage('images/background.jpg'),
          ),

          //SizedBox(height: 10.0),
          _buildTitlePriceRow(),
          AddressTag('Bangalore, India'),
          Text(products.userEmail),

          // for adding padding , we can use padding widget
          // Padding(
          //   padding: EdgeInsets.only(top: 10.0) ,
          //   child: Text(products[index]['title']),
          //   )

          _buildIconButtonBar(context)
        ],
      ),
    );
  }

  Container _buildTitlePriceRow() {
    return Container(
        //margin: EdgeInsets.all(10.0),
        // margin : EdgeInsets.symmetric(horizontal : 10.0, vertical : 10.0), ----- used when same margin is required for symmetric directions
        margin: EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TitleWidget(products.title),
            SizedBox(
              width: 10.0,
            ),
            PriceTag(products.price.toString())
          ],
        ));
  }

  Widget _buildIconButtonBar(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return ButtonBar(alignment: MainAxisAlignment.center, children: <Widget>[
        IconButton(
          icon: Icon(Icons.info),
          color: Colors.green,
          onPressed: () => {
                Navigator.pushNamed<bool>(
                    context, '/product/' + model.allProducts[index].id)
              },
        ),
        IconButton(
          icon: Icon(model.allProducts[index].isFavorite
              ? Icons.favorite
              : Icons.favorite_border),
          color: Colors.red,
          onPressed: () {
            model.selectProduct(model.allProducts[index].id);
            model.toggleProductFavoriteStatus();
          },
        )
      ]);
    });
  }
}
