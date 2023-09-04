import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/order_models.dart';
import '../../provider/product_provider.dart';
import '../../widget/text_widget.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({
    super.key,
  });

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  final TextEditingController textController = TextEditingController();
  final FocusNode textFocusNode = FocusNode();

  late String orderDateToShow;
  @override
  void didChangeDependencies() {
    final orderModel = Provider.of<OrderModels>(context);
    final orderDate = orderModel.orderDate.toDate();
    orderDateToShow = '${orderDate.day}/ ${orderDate.month}/${orderDate.year}';
    super.didChangeDependencies();
  }

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
    final orderModel = Provider.of<OrderModels>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final getCurrent = productProvider.getProductById(orderModel.productId);
    return Container(
      width: 200,
      height: 110,
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Image(
                image: NetworkImage(orderModel.image), height: 200, width: 120),
          ),
          Expanded(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                TextWidget(
                  text: '${getCurrent.product} × ${orderModel.quantity}',
                  textSize: 20,
                  maxLines: 2,
                  isText: true,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextWidget(
                  text:
                      'paid:\$ ${double.parse(orderModel.price).toStringAsFixed(2)}',
                  textSize: 18,
                  maxLines: 1,
                  isText: true,
                  color: Colors.black38,
                ),
              ],
            ),
          ),
          Center(
            child: TextWidget(
              text: orderDateToShow,
              textSize: 18,
              maxLines: 1,
              isText: false,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
