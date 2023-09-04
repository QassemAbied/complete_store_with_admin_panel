import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import '../models/product_model.dart';
import '../provider/cart_provider.dart';
import '../provider/product_provider.dart';
import '../provider/viewed_provider.dart';
import '../screens/empty_screen.dart';
import '../services/global_method.dart';
import '../widget/heart_btn.dart';
import '../widget/price_widget.dart';
import '../widget/text_widget.dart';
import 'details_product.dart';

class CatProductScreen extends StatefulWidget {
  final String nameCategory;
 // final String idCategory;

  const CatProductScreen({super.key, required this.nameCategory,});

  @override
  State<CatProductScreen> createState() => _CatProductScreenState();
}

class _CatProductScreenState extends State<CatProductScreen> {
  final TextEditingController searchTextController = TextEditingController();
  final FocusNode searchTextFocusNode = FocusNode();
  @override
  void dispose() {
    searchTextController.dispose();
    searchTextFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final categoryProduct = productProvider.getByCategory(widget.nameCategory);
    final viewedProvider = Provider.of<ViewedProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
  //  final productModel = Provider.of<ProductModels>(context);
    double usePrice=0.0;
    bool isInCart= false;
    // ProductModels onDetailsProduct ;
    // productProvider.getProduct.forEach((element) {
    //   final onDetailsProduct =
    //   productProvider.getProductById(element.id);
    //    usePrice = onDetailsProduct.onSale
    //       ? onDetailsProduct.salePrice
    //       : onDetailsProduct.price;
    //    isInCart = cartProvider.getCartItem.containsKey(element.id);
    // });


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        title: TextWidget(
          text: widget.nameCategory,
          textSize: 25,
          maxLines: 1,
          isText: true,
          color: Colors.white,
        ),
      ),
      body: categoryProduct.isEmpty
          ?  EmptyScreen(titleEmpty: 'No Product on CategoryProduct Yet!, \nStay Tuned',)
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 40, right: 10, left: 10, bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: searchTextController,
                      focusNode: searchTextFocusNode,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: IconButton(
                          onPressed: () {
                            searchTextController.clear();
                            searchTextFocusNode.unfocus();
                          },
                          icon: Icon(
                            Icons.clear,
                            color: searchTextFocusNode.hasFocus
                                ? Colors.red
                                : Colors.black,
                          ),
                        ),
                        labelText: 'what\'s in your mind',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GridView.count(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      childAspectRatio: 0.8,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 10,
                      crossAxisCount: 2,
                      children: List.generate(categoryProduct.length, (index) {
                        return InkWell(
                          onTap: () {
                            viewedProvider.addProductToHistory(
                                productId: categoryProduct[index].id);

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailsProductScreen(
                                          id: categoryProduct[index].id,
                                        )));
                          },
                          child: Container(
                            height: 200,
                            width: 250,
                            padding: const EdgeInsets.only(
                                left: 5, top: 5, right: 5, bottom: 5),
                            decoration: BoxDecoration(
                                color: Colors.deepPurple.shade50,
                                border: Border.all(
                                    width: 2, color: Colors.deepPurple),
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 100,
                                  width: 250,
                                  child: Image(
                                    image: NetworkImage(
                                        categoryProduct[index].image),
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: TextWidget(
                                          text: categoryProduct[index].product,
                                          textSize: 22,
                                          maxLines: 1,
                                          color: Colors.black,
                                        ),
                                      ),
                                      HeartBTN(
                                          productId:
                                              categoryProduct[index].id),
                                    ],
                                  ),
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
                                    // Visibility(
                                    //   visible: onDetailsProduct.onSale,
                                    //   child: TextWidget(
                                    //     text: '\$${onDetailsProduct.price}',
                                    //     textSize: 16,
                                    //     maxLines: 1,
                                    //     isunderline: true,
                                    //     color: Colors.red,
                                    //   ),
                                    // ),
                                  ],
                                ),
                                // ElevatedButton(
                                //   style: ButtonStyle(
                                //       backgroundColor: MaterialStateProperty.all(
                                //           isInCart ? Colors.green : Colors.deepPurple.shade300),
                                //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                //           RoundedRectangleBorder(
                                //               borderRadius: BorderRadius.circular(10)))),
                                //   onPressed: () async {
                                //     await GlobalMethod.addToCart(
                                //       ProductId: isInCart.toString(),
                                //       quntity: 1,
                                //     );
                                //     await cartProvider.fetchDataForCart();
                                //   },
                                //   child: Row(
                                //     children: [
                                //       TextWidget(
                                //           text: isInCart ? 'In Cart ' : 'Add To Cart',
                                //           textSize: 18,
                                //           maxLines: 1,
                                //           isText: true,
                                //           color: Colors.white),
                                //       const Spacer(),
                                //       const Icon(IconlyLight.buy)
                                //     ],
                                //   ),
                                // ),
                              ],
                            ),
                          ),
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
