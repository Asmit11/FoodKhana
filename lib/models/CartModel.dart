// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodkhana/models/ProductModel.dart';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
  String? id;
  List<ProductModel>? products;
  String? userid;
  CartModel({
    this.id,
    this.products,
    this.userid,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    id: json["id"],
    userid: json["userid"],
    products: json["products"] == null ? [] : List<ProductModel>.from(json["products"]!.map((x) => ProductModel.fromJson(x))),
  );

  factory CartModel.fromFirebaseSnapshot(DocumentSnapshot<Map<String, dynamic>> json) {
    return CartModel(
      id: json.id,
      userid: json["userid"],
      products: json["products"] == null ? [] : List<ProductModel>.from(json["products"]!.map((x) => ProductModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "userid": userid,
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
  };


}