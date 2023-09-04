import 'package:flutter/material.dart';

class CartModels extends ChangeNotifier {
  final String id, ProductId;
  final int quntity;

  CartModels({
    required this.id,
    required this.ProductId,
    required this.quntity,
  });
}
