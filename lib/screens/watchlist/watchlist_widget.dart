import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import '../../models/wishlist_models.dart';
import '../../provider/cart_provider.dart';
import '../../provider/product_provider.dart';
import '../../services/global_method.dart';
import '../../widget/heart_btn.dart';
import '../../widget/price_widget.dart';
import '../../widget/text_widget.dart';

class WatchlistWidget extends StatefulWidget {
  const WatchlistWidget({super.key});

  @override
  State<WatchlistWidget> createState() => _WatchlistWidgetState();
}

class _WatchlistWidgetState extends State<WatchlistWidget> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final wishlistModel = Provider.of<WishlistModels>(context);
    final onDetailsProduct =
        productProvider.getProductById(wishlistModel.productId);
    final cartProvider = Provider.of<CartProvider>(context);
    bool isInCart = cartProvider.getCartItem.containsKey(onDetailsProduct.id);
    double usePrice = onDetailsProduct.onSale
        ? onDetailsProduct.salePrice
        : onDetailsProduct.price;

    return Container(
      height: 200,
      width: 250,
      padding: const EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
      decoration: BoxDecoration(
          color: Colors.deepPurple.shade50,
          border: Border.all(width: 2, color: Colors.deepPurple),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 120,
                width: 110,
                child: Image(
                  image: NetworkImage(onDetailsProduct.image),
                ),
              ),
              Column(
                children: [
                  HeartBTN(productId: onDetailsProduct.id),
                  IconButton(
                    onPressed: () async {
                      await GlobalMethod.addToCart(
                        ProductId: onDetailsProduct.id,
                        quntity: 1,
                      );
                      await cartProvider.fetchDataForCart();
                    },
                    icon: Icon(
                      IconlyBold.bag,
                      color: isInCart ? Colors.green : Colors.grey,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ],
          ),
          TextWidget(
            text: onDetailsProduct.product,
            textSize: 22,
            maxLines: 1,
            color: Colors.black,
          ),
          SizedBox(
            height: 7,
          ),
          Row(
            children: [
              TextWidget(
                text: usePrice.toStringAsFixed(2),
                textSize: 18,
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
                  textSize: 16,
                  maxLines: 1,
                  isunderline: true,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
