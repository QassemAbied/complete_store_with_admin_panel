import 'package:flutter/material.dart';
import '../widget/our_product/all_product_widget.dart';
import '../widget/banner_widget.dart';
import '../widget/sale_product/product_salle.dart';
import 'empty_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    bool isEmpty = false;
    return Scaffold(
      body: isEmpty
          ? EmptyScreen(titleEmpty: '',)
          : SingleChildScrollView(
              child: Column(
                children: [
                  BannerWidget(),
                  const ProductSalle(),
                  const AllProductWidget(),
                ],
              ),
            ),
    );
  }
}
