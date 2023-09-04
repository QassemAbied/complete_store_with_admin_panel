import 'package:flutter/material.dart';

class WishlistModels with ChangeNotifier {
  final String id, productId;
  WishlistModels({required this.id, required this.productId});
}
