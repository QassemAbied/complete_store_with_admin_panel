import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/order_provider.dart';
import '../../widget/text_widget.dart';
import '../empty_screen.dart';
import 'order_widget.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    final order = orderProvider.getOrderList;
    return FutureBuilder(
        future: orderProvider.fetchorder(),
        builder: (context, snapShot) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.deepPurple,
              elevation: 0,
              title: TextWidget(
                text: 'All Order',
                textSize: 25,
                maxLines: 1,
                isText: true,
                color: Colors.white,
              ),
            ),
            body: order.isEmpty
                ?  EmptyScreen(titleEmpty: 'No Product on Order Yet!, \nStay Tuned',)
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              TextWidget(
                                  text: 'Order Cart( ${order.length} )',
                                  textSize: 22,
                                  maxLines: 1,
                                  isText: true,
                                  color: Colors.black),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return ChangeNotifierProvider.value(
                                value: order[index],
                                child: const OrderWidget(),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const Divider(
                                height: 2,
                                color: Colors.black,
                              );
                            },
                            itemCount: order.length,
                          ),
                        ],
                      ),
                    ),
                  ),
          );
        });
  }
}
