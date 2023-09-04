import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../consts/firebase_consts.dart';
import '../models/wishlist_models.dart';

class WishlistProvider with ChangeNotifier {
  Map<String, WishlistModels> wishlistItem = {};

  Map<String, WishlistModels> get getWishlistItem {
    return wishlistItem;
  }

  Future<void> fetchDataForWishList() async {
    final User? user = authInstance.currentUser;
    final _uid = user!.uid;
    final DocumentSnapshot wishSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    if (wishSnapshot == null) {
      return;
    } else {
      final leng = wishSnapshot.get('user_wish').length;
      for (int i = 0; i < leng; i++) {
        wishlistItem.putIfAbsent(
            wishSnapshot.get('user_wish')[i]['productId'],
            () => WishlistModels(
                  id: wishSnapshot.get('user_wish')[i]['wishId'],
                  productId: wishSnapshot.get('user_wish')[i]['productId'],
                ));
      }
      notifyListeners();
    }
  }

  Future<void> removeOneWishlistProduct({
    required String productId,
    required String wishId,
  }) async {
    final User? user = authInstance.currentUser;
    final _uid = user!.uid;
    await FirebaseFirestore.instance.collection('users').doc(_uid).update({
      'user_wish': FieldValue.arrayRemove([
        {
          'wishId': wishId,
          'productId': productId,
        }
      ]),
    });
    wishlistItem.remove(productId);
    fetchDataForWishList();
    notifyListeners();
  }

  Future<void> deleteAllProductWishList() async {
    final User? user = authInstance.currentUser;
    final _uid = user!.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(_uid)
        .update({'user_wish': []});
    wishlistItem.clear();
    notifyListeners();
  }

  void clearWishlistProduct() {
    wishlistItem.clear();
    notifyListeners();
  }
}
