import 'package:first_app/scoped_models/main.dart';
import 'package:flutter/material.dart';

import 'product_create.dart';
import 'product_list.dart';

class ProductsAdminPage extends StatelessWidget {
  final MainModel model;
  ProductsAdminPage(this.model);
  Drawer _buildDrawer(BuildContext context){
    return Drawer(
              child: Column(
            children: <Widget>[
              AppBar(
                automaticallyImplyLeading: false, // disable hamburgger icon
                title: Text('Choose'),
              ),
              ListTile(
                leading: Icon(Icons.view_list),
                title: Text("All Products"),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/products');
                },
              )
            ],
          ));
  }
  AppBar _buildAppBar(){
    return AppBar(
            title: Text('Manage Products'),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  text: 'Create Product',
                  icon: Icon(Icons.create),
                ),
                Tab(
                  text: 'My Products',
                  icon: Icon(Icons.list)
                )
              ],
            ),
          );
  }
   
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          drawer: _buildDrawer(context),
          appBar: _buildAppBar(),
          body: TabBarView(
            children: <Widget>[
              ProductCreatePage(),
              ProductListPage(model),
            ],
          )
        ));
  }
}
