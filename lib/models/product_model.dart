import 'package:flutter/cupertino.dart';

class ProductModels with ChangeNotifier {
  final String nameCategory, product, id, image;
  final double price, salePrice;
  final bool onSale, pieces;
  ProductModels({
    required this.nameCategory,
    required this.product,
    required this.id,
    required this.image,
    required this.pieces,
    required this.salePrice,
    required this.onSale,
    required this.price,
  });
}
