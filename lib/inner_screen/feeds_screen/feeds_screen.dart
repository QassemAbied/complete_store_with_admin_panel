import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/product_model.dart';
import '../../provider/product_provider.dart';
import '../../provider/viewed_provider.dart';
import '../../screens/empty_screen.dart';
import '../../widget/text_widget.dart';
import '../details_product.dart';
import 'feeds_item.dart';

class FeedsScreen extends StatefulWidget {
  const FeedsScreen({super.key});

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  final TextEditingController searchTextController = TextEditingController();
  final FocusNode searchTextFocusNode = FocusNode();
  List<ProductModels> searchProductModels = [];
  @override
  void dispose() {
    searchTextController.dispose();
    searchTextFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final allProducts = productProvider.getProduct;
    final viewedProvider = Provider.of<ViewedProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        title: TextWidget(
          text: 'All Product',
          textSize: 25,
          maxLines: 1,
          isText: true,
          color: Colors.white,
        ),
      ),
      body: allProducts.isEmpty
          ?  EmptyScreen(titleEmpty: 'No Product on ourProduct Yet!, \nStay Tuned',)
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
                        setState(() {
                          searchProductModels =
                              productProvider.searchQuery(value);
                        });
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
                    searchTextController.text.isNotEmpty &&
                            searchProductModels.isEmpty
                        ? Center(
                            child: TextWidget(
                              text: 'is Empty sorry',
                              textSize: 22,
                              maxLines: 1,
                              color: Colors.black,
                            ),
                          )
                        : GridView.count(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            childAspectRatio: 0.8,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 10,
                            crossAxisCount: 2,
                            children: List.generate(
                                searchTextController.text.isNotEmpty
                                    ? searchProductModels.length
                                    : allProducts.length, (index) {
                              return InkWell(
                                onTap: () {
                                  viewedProvider.addProductToHistory(
                                      productId: allProducts[index].id);

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DetailsProductScreen(
                                                id: allProducts[index].id,
                                              )));
                                },
                                child: ChangeNotifierProvider.value(
                                    value: searchTextController.text.isNotEmpty
                                        ? searchProductModels[index]
                                        : allProducts[index],
                                    child: const FeedsItem()),
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
