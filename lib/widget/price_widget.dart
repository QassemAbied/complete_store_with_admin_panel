import 'package:complete_store_with_admin_panel/widget/text_widget.dart';
import 'package:flutter/material.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget(
      {super.key,
      required this.sallePrice,
      required this.price,
      required this.textPrice,
      required this.isOnSale});
  final double sallePrice, price;
  final String textPrice;
  final bool isOnSale;
  @override
  Widget build(BuildContext context) {
    double userPrice = isOnSale ? sallePrice : price;
    return Row(
      children: [
        TextWidget(
          text: '\$${(userPrice * int.parse(textPrice)).toStringAsFixed(2)}',
          textSize: 17,
          maxLines: 1,
          isText: true,
          color: Colors.black38,
        ),
        SizedBox(
          width: 5,
        ),
        Visibility(
          visible: isOnSale ? true : false,
          child: TextWidget(
            text: '\$${(price * int.parse(textPrice)).toStringAsFixed(2)}',
            textSize: 15,
            maxLines: 1,
            isunderline: true,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
