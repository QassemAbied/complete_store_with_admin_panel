import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../inner_screen/cat_product_screen.dart';
import '../../models/product_model.dart';
import '../../widget/text_widget.dart';
import '../empty_screen.dart';

class CategoryItems extends StatefulWidget {
  final Color colorList;
  final Color colorBorder;
  final String image;
  final String title;
  const CategoryItems(
      {super.key, required this.colorList, required this.colorBorder, required this.image, required this.title});

  @override
  State<CategoryItems> createState() => _CategoryItemsState();
}

class _CategoryItemsState extends State<CategoryItems> {

  @override
  Widget build(BuildContext context) {
    //final productModel = Provider.of<ProductModels>(context);

   return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CatProductScreen(
                nameCategory:widget.title,
                //idCategory: allCategory[index].id,
              )
          ),
        );
      },
      child: Container(
        height: 200,
        width: 250,
        decoration: BoxDecoration(
            color: widget.colorList,
            border: Border.all(width: 2, color: widget.colorBorder),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            SizedBox(
              height: 180,
              width: 250,
              child: Image(
                image: AssetImage(widget.image),
              ),
            ),
            TextWidget(
                text: widget.title,
                textSize: 22,
                maxLines: 1,
                color: Colors.deepPurpleAccent),
          ],
        ),
      ),
    );
  }
}
