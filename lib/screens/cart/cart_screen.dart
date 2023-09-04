
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complete_store_with_admin_panel/stripe_payment/payment_manger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:uuid/uuid.dart';
import '../../consts/firebase_consts.dart';
import '../../provider/cart_provider.dart';
import '../../provider/order_provider.dart';
import '../../provider/product_provider.dart';
import '../../widget/show Dialog.dart';
import '../../widget/text_widget.dart';
import '../empty_screen.dart';
import 'cart_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    double total = 0.0;
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItemList = cartProvider.getCartItem.values.toList();
    final orderProvider = Provider.of<OrderProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    cartProvider.getCartItem.forEach((key, value) {
      final onDetailsProduct = productProvider.getProductById(value.ProductId);
      total += (onDetailsProduct.onSale
              ? onDetailsProduct.salePrice
              : onDetailsProduct.price) *
          value.quntity;
    });
    return Scaffold(
      body: cartItemList.isEmpty
          ?  EmptyScreen(titleEmpty: 'No Product Cart Yet!, \nStay Tuned',)
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        TextWidget(
                            text: 'Cart(${cartItemList.length})',
                            textSize: 22,
                            maxLines: 1,
                            isText: true,
                            color: Colors.black),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              showAlertDialog(
                                context: context,
                                text: 'Empty your Cart?',
                                contentText: 'Are You Sure',
                                ftx: () async {
                                  await cartProvider.deleteAllProduct();
                                  cartProvider.clearProduct();
                                  Navigator.pop(context);
                                },
                                bottomText: 'Ok',
                                nextBottom: true,
                              );
                            },
                            icon: const Icon(IconlyLight.delete)),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.deepPurple.shade300),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10)))),
                          onPressed: () async {
                            final productProvider =
                                Provider.of<ProductProvider>(context,
                                    listen: false);
                            await PaymentManager.makePayment(
                                context, total.toInt(), 'USD');

                            cartProvider.getCartItem
                                .forEach((key, value) async {
                              final getCurrent = productProvider
                                  .getProductById(value.ProductId);
                              try {
                                final User? user = authInstance.currentUser;
                                final _uid = user!.uid;
                                final orderId = Uuid().v4();
                                await FirebaseFirestore.instance
                                    .collection('order')
                                    .doc(orderId)
                                    .set({
                                  'orderId': orderId,
                                  'userId': _uid,
                                  'productId': value.ProductId,
                                  'price': (getCurrent.onSale
                                          ? getCurrent.salePrice
                                          : getCurrent.price) *
                                      value.quntity,
                                  'quantity': value.quntity,
                                  'userName': user.displayName,
                                  'totalPrice': total.toString(),
                                  'imageUrl': getCurrent.image,
                                  'orderDate': Timestamp.now(),
                                });
                                await cartProvider.deleteAllProduct();
                                cartProvider.clearProduct();
                                await orderProvider.fetchorder();
                                await Fluttertoast.showToast(
                                  msg: 'your order has been pleased',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                );
                              } catch (error) {
                                await Fluttertoast.showToast(
                                  msg: '$error',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                );
                                print(error);
                              } finally {}
                            });
                          },
                          child: TextWidget(
                              text: 'Order Now',
                              textSize: 18,
                              maxLines: 1,
                              isText: true,
                              color: Colors.white),
                        ),
                        const Spacer(),
                        TextWidget(
                            text: 'total Price : \$$total',
                            textSize: 18,
                            maxLines: 1,
                            isText: true,
                            color: Colors.black),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: cartItemList.length,
                      itemBuilder: (context, index) {
                        return ChangeNotifierProvider.value(
                            value: cartItemList[index],
                            child: CartWidget(
                              q: cartItemList[index].quntity,
                            ));
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 15,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
