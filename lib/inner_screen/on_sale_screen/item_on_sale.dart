import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import '../../models/product_model.dart';
import '../../provider/cart_provider.dart';
import '../../services/global_method.dart';
import '../../widget/price_widget.dart';
import '../../widget/text_widget.dart';

class ItemOnSale extends StatefulWidget {
  const ItemOnSale({super.key});

  @override
  State<ItemOnSale> createState() => _ItemOnSaleState();
}

class _ItemOnSaleState extends State<ItemOnSale> {
  @override
  Widget build(BuildContext context) {
    final productModel = Provider.of<ProductModels>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    bool isInCart = cartProvider.getCartItem.containsKey(productModel.id);
    return Container(
      width: 200,
      height: 200,
      padding: const EdgeInsets.only(left: 5, top: 5, right: 2, bottom: 5),
      decoration: BoxDecoration(
          color: Colors.deepPurple.shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2, color: Colors.deepPurple)),
      child: Stack(
        children: [
          Column(
            children: [
              Image(
                image: NetworkImage(productModel.image),
                height: 150,
                width: 170,
              ),
              PriceWidget(
                  sallePrice: productModel.salePrice,
                  price: productModel.price,
                  textPrice: '1',
                  isOnSale: true),
              Expanded(
                child: TextWidget(
                  text: productModel.product,
                  textSize: 20,
                  maxLines: 1,
                  isText: true,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Column(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    IconlyBold.heart,
                    color: Colors.grey,
                    size: 30,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    await GlobalMethod.addToCart(
                      ProductId: productModel.id,
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
          ),
        ],
      ),
    );
  }
}
