import 'package:complete_store_with_admin_panel/data_screen.dart';
import 'package:complete_store_with_admin_panel/provider/cart_provider.dart';
import 'package:complete_store_with_admin_panel/provider/product_provider.dart';
import 'package:complete_store_with_admin_panel/provider/wishlist_provider.dart';
import 'package:complete_store_with_admin_panel/screens/auth/login_screen.dart';
import 'package:complete_store_with_admin_panel/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserState extends StatefulWidget {
  const UserState({Key? key}) : super(key: key);

  @override
  State<UserState> createState() => _UserStateState();
}

class _UserStateState extends State<UserState> {
  void initState() {
    Future.delayed(Duration(seconds: 3), () async {
      final productProvider =
      Provider.of<ProductProvider>(context, listen: false);
      final cartProvider = Provider.of<CartProvider>(context, listen: false);
      final wishlistProvider =
      Provider.of<WishlistProvider>(context, listen: false);
      //final User? user = authInstance.currentUser;

      await productProvider.fetchProduct();
      await cartProvider.fetchDataForCart();
      await  wishlistProvider.fetchDataForWishList();
      setState(() {

      });

      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => MainScreen()));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:FirebaseAuth.instance.authStateChanges() ,
      builder: (context , userSnapshot){
        if(userSnapshot.data==null){
          return LoginScreen();
        }else if(userSnapshot.hasData){
          return MainScreen();

        }else if(userSnapshot.hasError){
          return Scaffold(
            body: Text('WE FOUND ERROR',
              style: TextStyle(
                fontSize: 30,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }
        return Scaffold(
          body: Text('WE FOUND ERROR',
            style: TextStyle(
              fontSize: 30,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}