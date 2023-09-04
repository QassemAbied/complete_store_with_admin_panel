import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/product_model.dart';
import '../../provider/product_provider.dart';
import '../../provider/viewed_provider.dart';
import '../../screens/empty_screen.dart';
import '../../widget/text_widget.dart';
import '../details_product.dart';
import 'item_on_sale.dart';

class OnSaleScreen extends StatelessWidget {
  const OnSaleScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    List<ProductModels> onSaleProduct = productProvider.getProductOnSale;
    final viewedProvider = Provider.of<ViewedProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        title: TextWidget(
          text: 'Product On Sale',
          textSize: 25,
          maxLines: 1,
          isText: true,
          color: Colors.white,
        ),
      ),
      body: onSaleProduct.isEmpty
          ?  EmptyScreen(titleEmpty: 'No Product on Sale Yet!, \nStay Tuned',)
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 20, right: 10, left: 10, bottom: 10),
                child: Column(
                  children: [
                    GridView.count(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      childAspectRatio: 0.8,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 10,
                      crossAxisCount: 2,
                      children: List.generate(onSaleProduct.length, (index) {
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
                              value: onSaleProduct[index],
                              child: const ItemOnSale()),
                        );
                      }),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
