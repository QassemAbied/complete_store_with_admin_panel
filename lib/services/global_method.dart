import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

import '../consts/firebase_consts.dart';

class GlobalMethod {
  static Future<void> addToCart({
    required String ProductId,
    required int quntity,
  }) async {
    final _uuid = Uuid().v4();
    final User? user = authInstance.currentUser;
    final _uid = user!.uid;
    try {
      await FirebaseFirestore.instance.collection('users').doc(_uid).update({
        'user_cart': FieldValue.arrayUnion([
          {
            'cartId': _uuid,
            'productId': ProductId,
            'quntity': quntity,
          }
        ]),
      });
      await Fluttertoast.showToast(
        msg: 'you add product in cart',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } catch (error) {
      Fluttertoast.showToast(
        msg: '$error',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  static Future<void> addToWishList({
    required String productId,
  }) async {
    final _uuid = Uuid().v4();
    final User? user = authInstance.currentUser;
    final _uid = user!.uid;
    try {
      await FirebaseFirestore.instance.collection('users').doc(_uid).update({
        'user_wish': FieldValue.arrayUnion([
          {
            'wishId': _uuid,
            'productId': productId,
          }
        ]),
      });
      await Fluttertoast.showToast(
        msg: 'you add product in WishList',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } catch (error) {
      Fluttertoast.showToast(
        msg: '$error',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }
}
