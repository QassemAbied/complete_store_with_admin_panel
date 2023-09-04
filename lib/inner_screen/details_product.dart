import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import '../provider/cart_provider.dart';
import '../provider/product_provider.dart';
import '../provider/viewed_provider.dart';
import '../services/global_method.dart';
import '../widget/heart_btn.dart';
import '../widget/quantity_controller_widget.dart';
import '../widget/text_widget.dart';

class DetailsProductScreen extends StatefulWidget {
  final String id;
  const DetailsProductScreen({super.key, required this.id});

  @override
  State<DetailsProductScreen> createState() => _DetailsProductScreenState();
}

class _DetailsProductScreenState extends State<DetailsProductScreen> {
  final TextEditingController textController = TextEditingController();
  final FocusNode textFocusNode = FocusNode();
  @override
  void initState() {
    textController.text = '1';
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    textFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final onDetailsProduct = productProvider.getProductById(widget.id);
    double usePrice = onDetailsProduct.onSale
        ? onDetailsProduct.salePrice
        : onDetailsProduct.price;
    final cartProvider = Provider.of<CartProvider>(context);
    bool isInCart = cartProvider.getCartItem.containsKey(onDetailsProduct.id);
    final viewedProvider = Provider.of<ViewedProvider>(context);
    final size = MediaQuery.of(context).size.height;
    double total=0.0;
    cartProvider.getCartItem.forEach((key, value) {
      total += (onDetailsProduct.onSale
          ? onDetailsProduct.salePrice
          : onDetailsProduct.price) * value.quntity;
    });

    return WillPopScope(
      onWillPop: () async {
        viewedProvider.addProductToHistory(productId: onDetailsProduct.id);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple.shade300,
          elevation: 0,
          title: TextWidget(
            text: 'Details Product',
            textSize: 25,
            maxLines: 1,
            isText: true,
            color: Colors.black,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image(
                image: NetworkImage(onDetailsProduct.image),
                height: size * 0.4,
                width: double.infinity,
              ),
              Container(
                width: double.infinity,
                height: size * 0.5,
                color: Colors.deepPurple.shade50,
                child: Padding(
                  padding: const EdgeInsets.only(top: 40, right: 10, left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          TextWidget(
                            text: onDetailsProduct.product,
                            textSize: 30,
                            maxLines: 1,
                            isText: true,
                            color: Colors.black,
                          ),
                          const Spacer(),
                          Expanded(
                            child: HeartBTN(productId: onDetailsProduct.id),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          TextWidget(
                            text: '\$${usePrice.toStringAsFixed(2)}',
                            textSize: 22,
                            maxLines: 1,
                            isText: true,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 0,
                          ),
                          Visibility(
                            visible: onDetailsProduct.onSale ? true : false,
                            child: Text(
                              '\$${onDetailsProduct.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 17,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.deepPurple.shade300),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)))),
                            onPressed: () {},
                            child: TextWidget(
                                text: 'Free Delivery',
                                textSize: 20,
                                maxLines: 1,
                                isText: true,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          quantityController(
                              ftx: () {
                                if (textController.text == '1') {
                                  return;
                                } else {
                                  setState(() {
                                    textController.text =
                                        (int.parse(textController.text) - 1)
                                            .toString();
                                  });
                                }
                              },
                              iconData: CupertinoIcons.minus,
                              color: Colors.red),
                          Flexible(
                            flex: 2,
                            child: SizedBox(
                              height: 50,
                              width: 50,
                              child: TextFormField(
                                controller: textController,
                                keyboardType: TextInputType.number,
                                key: const ValueKey('quantity'),
                                maxLines: 1,
                                focusNode: textFocusNode,
                                onChanged: (value) {
                                  if (value.isEmpty) {
                                    setState(() {
                                      textController.text = '1';
                                    });
                                  }
                                },
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                ),
                                textAlign: TextAlign.center,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp('[0-9]')),
                                ],
                              ),
                            ),
                          ),
                          quantityController(
                              ftx: () {
                                setState(() {
                                  textController.text =
                                      (int.parse(textController.text) + 1)
                                          .toString();
                                });
                              },
                              iconData: CupertinoIcons.plus,
                              color: Colors.green),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomSheet: Container(
          width: double.infinity,
          height: size * 0.1,
          color: Colors.deepPurple.shade100,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    TextWidget(
                      text: 'Total',
                      textSize: 18,
                      maxLines: 1,
                      isText: true,
                      color: Colors.red,
                    ),
                    //const Spacer(),
                    TextWidget(
                      text: '\$$usePrice',
                      textSize: 18,
                      maxLines: 1,
                      isText: true,
                      color: Colors.black,
                    ),
                  ],
                ),
                const Spacer(),
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(isInCart
                            ? Colors.green
                            : Colors.deepPurple.shade300),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)))),
                    onPressed: () async {
                      await GlobalMethod.addToCart(
                        ProductId: onDetailsProduct.id,
                        quntity: int.parse(textController.text),
                      );
                      await cartProvider.fetchDataForCart();
                    },
                    child: Row(
                      children: [
                        TextWidget(
                            text: isInCart ? 'InCart' : 'Add To Cart',
                            textSize: 16,
                            maxLines: 1,
                            isText: true,
                            color: Colors.white),
                        const SizedBox(
                          width: 3,
                        ),
                        Expanded(child: const Icon(IconlyLight.buy))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
