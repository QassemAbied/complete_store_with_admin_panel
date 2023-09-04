import 'package:complete_store_with_admin_panel/widget/sale_product/sale_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import '../../inner_screen/details_product.dart';
import '../../inner_screen/on_sale_screen/on_sale_screen.dart';
import '../../provider/product_provider.dart';
import '../../provider/viewed_provider.dart';
import '../text_widget.dart';

class ProductSalle extends StatefulWidget {
  const ProductSalle({super.key});

  @override
  State<ProductSalle> createState() => _ProductSalleState();
}

class _ProductSalleState extends State<ProductSalle> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final onSaleProduct = productProvider.getProductOnSale;
    final viewedProvider = Provider.of<ViewedProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(right: 10.0, top: 10, bottom: 10),
      child: Row(
        children: [
          RotatedBox(
            quarterTurns: -1,
            child: Row(
              children: [
                TextWidget(
                  text: 'ON SALLE',
                  textSize: 22,
                  maxLines: 1,
                  isText: true,
                  color: Colors.red,
                ),
                Icon(
                  IconlyLight.discount,
                  color: Colors.red,
                  size: 30,
                ),
              ],
            ),
          ),
          Flexible(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OnSaleScreen()));
                    },
                    child: TextWidget(
                        text: 'ViewAll',
                        textSize: 20,
                        maxLines: 1,
                        color: Colors.deepPurple),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 200,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          viewedProvider.addProductToHistory(
                              productId: onSaleProduct[index].id);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailsProductScreen(
                                        id: onSaleProduct[index].id,
                                      )));
                        },
                        child: ChangeNotifierProvider.value(
                            value: onSaleProduct[index], child: SaleItem()),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 10,
                      );
                    },
                    itemCount: onSaleProduct.length,
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
