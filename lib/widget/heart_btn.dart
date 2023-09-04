import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import '../provider/product_provider.dart';
import '../provider/wishlist_provider.dart';
import '../services/global_method.dart';

class HeartBTN extends StatelessWidget {
  const HeartBTN({super.key, required this.productId, this.isWishList = false});
  final bool isWishList;
  final String productId;
  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final getCurrent = productProvider.getProductById(productId);
    bool isInWishlist = wishlistProvider.getWishlistItem.containsKey(productId);

    return GestureDetector(
      onTap: () async {
        try {
          if (isInWishlist == false) {
            await GlobalMethod.addToWishList(productId: productId);
          } else {
            await wishlistProvider.removeOneWishlistProduct(
              productId: productId,
              wishId: wishlistProvider.getWishlistItem[getCurrent.id]!.id,
            );
          }
          await wishlistProvider.fetchDataForWishList();
        } catch (error) {
        } finally {}
      },
      child: Icon(
        IconlyBold.heart,
        color: isInWishlist ? Colors.red : Colors.grey,
        size: 30,
      ),
    );
  }
}
