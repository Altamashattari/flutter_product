import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped_models/main.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  String _email, _pass;
  bool _val = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
      image: AssetImage('images/background.jpg'),
    );
  }

  Widget _buildUserIdTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Email ID', filled: true, fillColor: Colors.white),
      keyboardType: TextInputType.emailAddress,
      validator: (String value){
        if(value.isEmpty || !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?").hasMatch(value)){
          return 'Enter Valid Email Address';
        }
      },
      onSaved: (String value) {
        //setState(() {
          _email = value;
        //});
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Password', filled: true, fillColor: Colors.white),
      obscureText: true,
      validator: (String value){
        if(value.isEmpty) return 'Invalid Password' ;
      },
      onSaved: (String value) {
        //setState(() {
          _pass = value;
        //});
      },
    );
  }

  void onSubmitForm(Function login) {
    //print(_email + " " + _pass);
    if (!_formKey.currentState.validate() || !_val) return;
    _formKey.currentState.save();
    login(_email,_pass);
    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width; // another property - orientation
    final double targetWidth =  deviceWidth > 768.0 ? 500.0 :  deviceWidth * 0.95 ;
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Form(
          key: _formKey,
          child: Container(
          decoration: BoxDecoration(
            image: _buildBackgroundImage(),
          ),
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: SingleChildScrollView(
                child: Container(
                    width: targetWidth, // media query used for responsive design 
                    child: Column(children: <Widget>[
              _buildUserIdTextField(),
              SizedBox(
                height: 20.0,
              ),
              _buildPasswordTextField(),
              _buildSwitchTile(),
              SizedBox(
                height: 10.0,
              ),
              ScopedModelDescendant<MainModel>(
                builder: (BuildContext context, Widget child, MainModel model){
                  return RaisedButton(
                  //color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  child: Text("Login"),
                  onPressed: () => onSubmitForm(model.login)
                  );
                },
              ) 
            ]))),
          ),
        )));
  }

  SwitchListTile _buildSwitchTile() {
    return SwitchListTile(
      value: _val,
      onChanged: (bool value) {
        setState(() {
          _val = value;
        });
      },
      title: Text(
        "Accept terms and conditions",
        style: TextStyle(fontSize: 20.0, color: Colors.black),
      ),
    );
  }
}
