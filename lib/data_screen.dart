// import 'package:complete_store_with_admin_panel/provider/cart_provider.dart';
// import 'package:complete_store_with_admin_panel/provider/product_provider.dart';
// import 'package:complete_store_with_admin_panel/provider/wishlist_provider.dart';
// import 'package:complete_store_with_admin_panel/screens/main_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import 'consts/firebase_consts.dart';
//
// class DataScreen extends StatefulWidget {
//   const DataScreen({super.key});
//
//   @override
//   State<DataScreen> createState() => _DataScreenState();
// }
//
// class _DataScreenState extends State<DataScreen> {
//   @override
//   void initState() {
//     Future.delayed(Duration(microseconds: 10), () async {
//       final productProvider =
//           Provider.of<ProductProvider>(context, listen: false);
//       final cartProvider = Provider.of<CartProvider>(context, listen: false);
//       final wishlistProvider =
//           Provider.of<WishlistProvider>(context, listen: false);
//       //final User? user = authInstance.currentUser;
//
//         await productProvider.fetchProduct();
//        await cartProvider.fetchDataForCart();
//        await  wishlistProvider.fetchDataForWishList();
//
//
//
//
//
//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (context) => MainScreen()));
//     });
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [],
//       ),
//     );
//   }
// }
