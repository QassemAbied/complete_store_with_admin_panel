import 'package:complete_store_with_admin_panel/widget/our_product/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../inner_screen/details_product.dart';
import '../../inner_screen/feeds_screen/feeds_screen.dart';
import '../../models/product_model.dart';
import '../../provider/product_provider.dart';
import '../../provider/viewed_provider.dart';
import '../text_widget.dart';

class AllProductWidget extends StatefulWidget {
  const AllProductWidget({super.key});

  @override
  State<AllProductWidget> createState() => _AllProductWidgetState();
}

class _AllProductWidgetState extends State<AllProductWidget> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    List<ProductModels> allProducts = productProvider.getProduct;
    final viewedProvider = Provider.of<ViewedProvider>(context);

    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                text: 'Our Product',
                textSize: 18,
                maxLines: 1,
                isText: true,
                color: Colors.black,
              ),
              const SizedBox(
                width: 10,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const FeedsScreen()));
                },
                child: TextWidget(
                  text: 'Browse All',
                  textSize: 20,
                  maxLines: 1,
                  color: Colors.deepPurple,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          GridView.count(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            childAspectRatio: 0.8,
            mainAxisSpacing: 20,
            crossAxisSpacing: 10,
            crossAxisCount: 2,
            children: List.generate(allProducts.length, (index) {
              return InkWell(
                onTap: () {
                  viewedProvider.addProductToHistory(
                      productId: allProducts[index].id);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailsProductScreen(
                                id: allProducts[index].id,
                              )));
                },
                child: ChangeNotifierProvider.value(
                    value: allProducts[index], child: const ProductWidget()),
              );
            }),
          )
        ],
      ),
    );
  }
}
