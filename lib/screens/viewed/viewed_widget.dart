import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/viewed_model.dart';
import '../../provider/cart_provider.dart';
import '../../provider/product_provider.dart';
import '../../services/global_method.dart';
import '../../widget/price_widget.dart';
import '../../widget/quantity_controller_widget.dart';
import '../../widget/text_widget.dart';

class ViewedWidget extends StatefulWidget {
  const ViewedWidget({
    super.key,
  });

  @override
  State<ViewedWidget> createState() => _ViewedWidgetState();
}

class _ViewedWidgetState extends State<ViewedWidget> {
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
    final cartProvider = Provider.of<CartProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final viewedModel = Provider.of<ViewedModels>(context);
    final onDetailsProduct =
        productProvider.getProductById(viewedModel.productId);
    bool isCartList = cartProvider.getCartItem.containsKey(onDetailsProduct.id);

    double usePrice = onDetailsProduct.onSale
        ? onDetailsProduct.salePrice
        : onDetailsProduct.price;
    return Container(
      width: 200,
      height: 110,
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Image(
                image: NetworkImage(onDetailsProduct.image),
                height: 200,
                width: 130),
          ),
          const SizedBox(
            height: 15,
          ),
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
                  height: 20,
                ),
                Expanded(
                  child: Row(
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
                ),
              ],
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Center(
            child: quantityController(
              ftx: () async {
                await GlobalMethod.addToCart(
                  ProductId: onDetailsProduct.id,
                  quntity: 1,
                );
                await cartProvider.fetchDataForCart();
              },
              iconData: isCartList ? Icons.check : CupertinoIcons.plus,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
