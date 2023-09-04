import 'package:complete_store_with_admin_panel/screens/viewed/viewed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import '../../provider/viewed_provider.dart';
import '../../widget/show Dialog.dart';
import '../../widget/text_widget.dart';
import '../empty_screen.dart';

class ViewedRecentlyScreen extends StatefulWidget {
  const ViewedRecentlyScreen({super.key});

  @override
  State<ViewedRecentlyScreen> createState() => _ViewedRecentlyScreenState();
}

class _ViewedRecentlyScreenState extends State<ViewedRecentlyScreen> {
  @override
  Widget build(BuildContext context) {
    final viewedProvider = Provider.of<ViewedProvider>(context);
    final viewedItemList = viewedProvider.getViewedItem.values.toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        title: TextWidget(
          text: 'All History',
          textSize: 25,
          maxLines: 1,
          isText: true,
          color: Colors.white,
        ),
      ),
      body: viewedItemList.isEmpty
          ?  EmptyScreen(titleEmpty: 'No Product ViewedRecently Yet!, \nStay Tuned',)
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        TextWidget(
                            text: 'History',
                            textSize: 22,
                            maxLines: 1,
                            isText: true,
                            color: Colors.black),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              showAlertDialog(
                                context: context,
                                text: 'Empty your History?',
                                contentText: 'Are You Sure',
                                ftx: () {
                                  viewedProvider.clearHistoryProduct();
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
                    ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ChangeNotifierProvider.value(
                            value: viewedItemList[index],
                            child: const ViewedWidget());
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 30,
                        );
                      },
                      itemCount: viewedItemList.length,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
