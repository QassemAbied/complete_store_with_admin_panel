import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../models/cart_model.dart';
import '../../provider/cart_provider.dart';
import '../../provider/product_provider.dart';
import '../../widget/heart_btn.dart';
import '../../widget/quantity_controller_widget.dart';
import '../../widget/text_widget.dart';

class CartWidget extends StatefulWidget {
  final int q;
  const CartWidget({super.key, required this.q});

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  final TextEditingController textController = TextEditingController();
  final FocusNode textFocusNode = FocusNode();
  @override
  void initState() {
    textController.text = widget.q.toString();
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
    final cartProvider = Provider.of<CartProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final cartModel = Provider.of<CartModels>(context);
    final onDetailsProduct =
        productProvider.getProductById(cartModel.ProductId);
    double usePrice = onDetailsProduct.onSale
        ? onDetailsProduct.salePrice
        : onDetailsProduct.price;

    return Container(
      width: 200,
      height: 120,
      color: Colors.deepPurple.shade50,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image(
              image: NetworkImage(onDetailsProduct.image),
              height: 200,
              width: 120),
          Expanded(
            child: Column(
              children: [
                TextWidget(
                  text: onDetailsProduct.product,
                  textSize: 23,
                  maxLines: 2,
                  isText: true,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    quantityController(
                        ftx: () {
                          if (textController.text == '1') {
                            return;
                          } else {
                            cartProvider
                                .reduceQuantityByOne(cartModel.ProductId);
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
                        height: 30,
                        width: 30,
                        child: TextFormField(
                          controller: textController,
                          keyboardType: TextInputType.number,
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
                            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                          ],
                        ),
                      ),
                    ),
                    quantityController(
                        ftx: () {
                          cartProvider
                              .increaseQuantityByOne(cartModel.ProductId);
                          setState(() {
                            textController.text =
                                (int.parse(textController.text) + 1).toString();
                          });
                        },
                        iconData: CupertinoIcons.plus,
                        color: Colors.green),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              IconButton(
                  onPressed: () async {
                    await cartProvider.removeOneProduct(
                      ProductId: cartModel.ProductId,
                      quntity: cartModel.quntity,
                      cartId: cartModel.id,
                    );
                  },
                  icon: const Icon(
                    CupertinoIcons.cart_badge_minus,
                    color: Colors.red,
                  )),
              HeartBTN(productId: cartModel.ProductId),
              Center(
                child: Row(
                  children: [
                    TextWidget(
                      text: usePrice.toStringAsFixed(2),
                      textSize: 15,
                      maxLines: 1,
                      isText: true,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Visibility(
                      visible: onDetailsProduct.onSale,
                      child: TextWidget(
                        text: '\$${onDetailsProduct.price}',
                        textSize: 12,
                        maxLines: 1,
                        isunderline: true,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
