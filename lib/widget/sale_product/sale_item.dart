import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import '../../models/product_model.dart';
import '../../provider/cart_provider.dart';
import '../../services/global_method.dart';
import '../heart_btn.dart';
import '../price_widget.dart';
import '../text_widget.dart';

class SaleItem extends StatefulWidget {
  const SaleItem({super.key});

  @override
  State<SaleItem> createState() => _SaleItemState();
}

class _SaleItemState extends State<SaleItem> {
  @override
  Widget build(BuildContext context) {
    final productModel = Provider.of<ProductModels>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    bool isInCart = cartProvider.getCartItem.containsKey(productModel.id);

    return Container(
      width: 200,
      height: 200,
      color: Colors.deepPurple.shade50,
      child: Stack(
        children: [
          Column(
            children: [
              Image(
                image: NetworkImage(productModel.image),
                height: 120,
                width: 170,
                fit: BoxFit.fitHeight,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PriceWidget(
                    sallePrice: productModel.salePrice,
                    price: productModel.price,
                    textPrice: '1',
                    isOnSale: true),
              ),
              TextWidget(
                text: productModel.product,
                textSize: 22,
                maxLines: 1,
                isText: true,
                color: Colors.black,
              ),
            ],
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Column(
              children: [
                HeartBTN(productId: productModel.id),
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
