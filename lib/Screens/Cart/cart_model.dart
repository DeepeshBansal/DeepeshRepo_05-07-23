import 'package:flutter/material.dart';

class Cart {
  late final int? id;
  final String? productId;
  final String? productName;
  final String? restaurantName;
  final String? identity;
  final String? menutype;
  final int? initialPrice;
  final int? productPrice;
  final ValueNotifier<int>? quantity;
  final String? categoryTag;
  final String? image;

  Cart(
      {required this.id,
      required this.productId,
      required this.productName,
      required this.restaurantName,
      required this.identity,
      required this.menutype,
      required this.initialPrice,
      required this.productPrice,
      required this.quantity,
      required this.categoryTag,
      required this.image});

  Cart.fromMap(Map<dynamic, dynamic> data)
      : id = data['id'],
        productId = data['productId'],
        productName = data['productName'],
        restaurantName = data['restaurantName'],
        initialPrice = data['initialPrice'],
        identity = data['identity'],
        menutype = data['menutype'],
        productPrice = data['productPrice'],
        quantity = ValueNotifier(data['quantity']),
        categoryTag = data['categoryTag'],
        image = data['image'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'restaurantName' : restaurantName, 
      'identity': identity,
      'menutype': menutype,
      'initialPrice': initialPrice,
      'productPrice': productPrice,
      'quantity': quantity?.value,
      'categoryTag': categoryTag,
      'image': image,
    };
  }

  Map<String, dynamic> quantityMap() {
    return {
      'productId': productId,
      'quantity': quantity!.value,
    };
  }
}