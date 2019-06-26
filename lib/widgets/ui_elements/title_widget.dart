import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget{
  final String title;

  TitleWidget(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
                    title,
                    style: TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Oswald'),
                  );
  }

}