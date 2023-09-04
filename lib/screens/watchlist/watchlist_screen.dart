import 'package:complete_store_with_admin_panel/screens/watchlist/watchlist_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import '../../provider/wishlist_provider.dart';
import '../../widget/show Dialog.dart';
import '../../widget/text_widget.dart';
import '../empty_screen.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final wishListItem = wishlistProvider.getWishlistItem.values.toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        title: TextWidget(
          text: 'All WishList',
          textSize: 25,
          maxLines: 1,
          isText: true,
          color: Colors.white,
        ),
      ),
      body: wishListItem.isEmpty
          ?  EmptyScreen(titleEmpty: 'No Product WishList Yet!, \nStay Tuned',)
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        TextWidget(
                            text: 'Watchlist(${wishListItem.length})',
                            textSize: 22,
                            maxLines: 1,
                            isText: true,
                            color: Colors.black),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              showAlertDialog(
                                context: context,
                                text: 'Empty your Watchlist?',
                                contentText: 'Are You Sure',
                                ftx: () async {
                                  await wishlistProvider
                                      .deleteAllProductWishList();
                                  wishlistProvider.clearWishlistProduct();
                                  Navigator.pop(context);
                                },
                                bottomText: 'Ok',
                                nextBottom: true,
                              );
                            },
                            icon: const Icon(IconlyLight.delete)),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GridView.count(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      childAspectRatio: 0.9,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 10,
                      crossAxisCount: 2,
                      children: List.generate(wishListItem.length, (index) {
                        return ChangeNotifierProvider.value(
                            value: wishListItem[index],
                            child: const WatchlistWidget());
                      }),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
