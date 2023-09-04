import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../inner_screen/cat_product_screen.dart';
import '../../models/product_model.dart';
import '../../provider/product_provider.dart';
import '../empty_screen.dart';
import 'category_items.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Color> colorList = [
    Colors.red.shade50,
    Colors.brown.shade50,
    Colors.deepPurple.shade50,
    Colors.green.shade50,
    Colors.blue.shade50,
    Colors.purple.shade50,
  ];
  List<Color> colorBorder = [
    Colors.red,
    Colors.brown,
    Colors.deepPurple,
    Colors.green,
    Colors.blue,
    Colors.purple,
  ];

  List<Map<String, dynamic>> cat=[
  {
  'imagePath': 'assets/images/144.png',
    'catTitle': 'Computers',
},
    {
      'imagePath': 'assets/images/wxdfcg.png',
      'catTitle': 'LabTop',
    },
    {
      'imagePath': 'assets/images/137.png',
      'catTitle': 'Smart watches',
    },
    {
      'imagePath': 'assets/images/146.png',
      'catTitle': 'Electronic devices',
    },
    {
      'imagePath': 'assets/images/101.png',
      'catTitle': 'Smart phones',
    },
    {
      'imagePath': 'assets/images/140.png',
      'catTitle': 'electronics',
    }

  ];

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<ProductProvider>(context);
   // final productModel = Provider.of<ProductModels>(context);
   // final allCategory = categoryProvider.getProduct;

    return Scaffold(
      body: cat.isEmpty
          ?  EmptyScreen(titleEmpty: 'No Product on Category Yet!, \nStay Tuned',)
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10, right: 10, left: 10, bottom: 10),
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
                      children: List.generate(cat.length, (index) {

                        return CategoryItems(
                          colorList: colorList[index],
                          colorBorder: colorBorder[index],
                          image: cat[index]['imagePath'],
                          title: cat[index]['catTitle'],
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
