import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/product_model.dart';

class ProductProvider with ChangeNotifier {
  static final List<ProductModels> productList = [];

  List<ProductModels> get getProduct {
    return productList;
  }

  List<ProductModels> get getProductOnSale {
    return productList.where((element) => element.onSale).toList();
  }

  Future<void> fetchProduct() async {
    await FirebaseFirestore.instance
        .collection('product')
        .get()
        .then((QuerySnapshot productSnapshot) {
      productSnapshot.docs.forEach((element) {
        productList.insert(
            0,
            ProductModels(
              nameCategory: element.get('productCategoryName'),
              product: element.get('title'),
              id: element.get('id'),
              image: element.get('imageUrl'),
              pieces: element.get('isPrice'),
              salePrice: element.get('salePrice').toDouble(),
              onSale: element.get('isOnSale'),
              price: double.parse(element.get('price')),
            ));
      });
    });
    notifyListeners();
  }

  ProductModels getProductById(String productId) {
    return productList.firstWhere((element) => element.id == productId);
  }

  List<ProductModels> getByCategory(String namesCategory) {
    return productList
        .where((element) => element.nameCategory
            .toUpperCase()
            .contains(namesCategory.toUpperCase()))
        .toList();
  }

  List<ProductModels> searchQuery(String searchTitle) {
    List<ProductModels> _searchList = productList
        .where((element) =>
            element.product.toUpperCase().contains(searchTitle.toUpperCase()))
        .toList();
    return _searchList;
  }
}
