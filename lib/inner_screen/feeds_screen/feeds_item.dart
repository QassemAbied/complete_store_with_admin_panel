import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import '../../models/product_model.dart';
import '../../provider/cart_provider.dart';
import '../../services/global_method.dart';
import '../../widget/heart_btn.dart';
import '../../widget/text_widget.dart';

class FeedsItem extends StatefulWidget {
  const FeedsItem({super.key});

  @override
  State<FeedsItem> createState() => _FeedsItemState();
}

class _FeedsItemState extends State<FeedsItem> {
  @override
  Widget build(BuildContext context) {
    final productModel = Provider.of<ProductModels>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    bool isInCart = cartProvider.getCartItem.containsKey(productModel.id);
    return Container(
      height: 200,
      width: 250,
      padding: const EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
      decoration: BoxDecoration(
          color: Colors.deepPurple.shade50,
          border: Border.all(width: 2, color: Colors.deepPurple),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          SizedBox(
            height: 100,
            width: 250,
            child: Image(
              image: NetworkImage(productModel.image),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextWidget(
                    text: productModel.product,
                    textSize: 20,
                    maxLines: 1,
                    color: Colors.black,
                  ),
                ),
                HeartBTN(productId: productModel.id),
              ],
            ),
          ),
          Row(
            children: [
              TextWidget(
                text: productModel.onSale
                    ? '\$${productModel.salePrice.toStringAsFixed(2)}'
                    : '\$${productModel.price}',
                textSize: 18,
                maxLines: 1,
                isText: true,
                color: Colors.black,
              ),
              const SizedBox(
                width: 3,
              ),
              Visibility(
                visible: productModel.onSale,
                child: TextWidget(
                  text: '\$${productModel.price}',
                  textSize: 16,
                  maxLines: 1,
                  isunderline: true,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    isInCart ? Colors.green : Colors.deepPurple.shade300),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)))),
            onPressed: () async {
              await GlobalMethod.addToCart(
                ProductId: productModel.id,
                quntity: 1,
              );
              await cartProvider.fetchDataForCart();
            },
            child: Row(
              children: [
                TextWidget(
                    text: isInCart ? 'In Cart' : 'Add To Cart',
                    textSize: 18,
                    maxLines: 1,
                    isText: true,
                    color: Colors.white),
                const Spacer(),
                const Icon(IconlyLight.buy)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
