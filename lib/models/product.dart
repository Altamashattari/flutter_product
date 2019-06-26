import 'package:flutter/material.dart';

class Product {
  final String id ;
  final String title, description, image;
  final double price;
  final bool isFavorite;
  final String userEmail , userId;

  Product(
      {
      @required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.image,
      @required this.userEmail,
      @required this.userId,
      this.isFavorite = false
      });
}
