import 'package:flutter/foundation.dart';

class Product {
  final String upc;
  final String name;
  // final String brandName;
  final String itemName;
  final Map<String, dynamic> fields;

  const Product({
    required this.upc,
    required this.name,
    // required this.brandName,
    required this.itemName,
    required this.fields
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      upc: (json['upc'] ?? ""),
      name: (json['name'] ?? ""),
      // brandName: (json['info']['fields']['brand_name'] ?? json['fields']['brand_name'] ?? ""),
      itemName: (json['info'] != null) ? ((json['info']['fields'] != null) ? (json['info']['fields']['item_name']) : "") : "",
      fields: (json['info'] == null) ? {} : json['info']['fields']
    );
  }
}