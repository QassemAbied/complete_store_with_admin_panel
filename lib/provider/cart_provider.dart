import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../consts/firebase_consts.dart';
import '../models/cart_model.dart';

class CartProvider extends ChangeNotifier {
  Map<dynamic, CartModels> cerItems = {};

  Map<dynamic, CartModels> get getCartItem {
    return cerItems;
  }

//   void addProductsToCart({
//     required String ProductId,
//     required int quntity,
// }){
//     cerItems.putIfAbsent(ProductId, () => CartModels(
//         id: DateTime.now().toString(),
//         ProductId: ProductId,
//         quntity: quntity
//     ),
//     );
//     notifyListeners();
//   }

  Future<void> fetchDataForCart() async {
    final User? user = authInstance.currentUser;
    final _uid = user!.uid;
    final DocumentSnapshot _userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    if (_userSnapshot == null) {
      return;
    }
    final leng = _userSnapshot.get('user_cart').length;
    for (int i = 0; i < leng; i++) {
      cerItems.putIfAbsent(
          _userSnapshot.get('user_cart')[i]['productId'],
          () => CartModels(
                id: _userSnapshot.get('user_cart')[i]['cartId'],
                ProductId: _userSnapshot.get('user_cart')[i]['productId'],
                quntity: _userSnapshot.get('user_cart')[i]['quntity'],
              ));
    }
    notifyListeners();
  }

  void reduceQuantityByOne(String productId) {
    cerItems.update(productId, (value) {
      return CartModels(
        id: value.id,
        ProductId: value.ProductId,
        quntity: value.quntity - 1,
      );
    });
    notifyListeners();
  }

  void increaseQuantityByOne(String productId) {
    cerItems.update(productId, (value) {
      return CartModels(
        id: value.id,
        ProductId: value.ProductId,
        quntity: value.quntity + 1,
      );
    });
    notifyListeners();
  }

  Future<void> removeOneProduct({
    required String ProductId,
    required int quntity,
    required String cartId,
  }) async {
    final User? user = authInstance.currentUser;
    final _uid = user!.uid;
    await FirebaseFirestore.instance.collection('users').doc(_uid).update({
      'user_cart': FieldValue.arrayRemove([
        {
          'cartId': cartId,
          'productId': ProductId,
          'quntity': quntity,
        }
      ])
    });
    cerItems.remove(ProductId);
    fetchDataForCart();
    notifyListeners();
  }

  Future<void> deleteAllProduct() async {
    final User? user = authInstance.currentUser;
    final _uid = user!.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(_uid)
        .update({'user_cart': []});
    cerItems.clear();
    notifyListeners();
  }

  void clearProduct() {
    cerItems.clear();
    notifyListeners();
  }
}
