import 'package:complete_store_with_admin_panel/provider/cart_provider.dart';
import 'package:complete_store_with_admin_panel/provider/order_provider.dart';
import 'package:complete_store_with_admin_panel/provider/product_provider.dart';
import 'package:complete_store_with_admin_panel/provider/viewed_provider.dart';
import 'package:complete_store_with_admin_panel/provider/wishlist_provider.dart';
import 'package:complete_store_with_admin_panel/stripe_payment/stripe_keys.dart';
import 'package:complete_store_with_admin_panel/user_state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

import 'data_screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey= ApiKeys.publishableKey;
  await Firebase.initializeApp();
  Provider.debugCheckInvalidValueType= null;
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp ,DeviceOrientation.landscapeLeft]).then((value) {
    runApp(
      MyApp(),
    );
  });

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (BuildContext context) => CartProvider()),
        ChangeNotifierProvider(create: (BuildContext context) => WishlistProvider()),
        ChangeNotifierProvider(create: (BuildContext context) => ViewedProvider()),
        ChangeNotifierProvider(create: (BuildContext context) => OrderProvider()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home:UserState(),
        builder: EasyLoading.init(),
      ),
    );
  }
}

