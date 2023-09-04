import 'package:complete_store_with_admin_panel/widget/text_widget.dart';
import 'package:flutter/material.dart';

Future<void> showAlertDialog({
  context,
  required String text,
  required String contentText,
  required Function ftx,
  required String bottomText,
  bool? nextBottom,
}) async {
  return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: TextWidget(
            text: text,
            textSize: 22,
            maxLines: 1,
            isText: true,
            color: Colors.black,
          ),
          content: TextWidget(
            text: contentText,
            textSize: 20,
            maxLines: 2,
            color: Colors.black38,
          ),
          actions: [
            nextBottom == true
                ? ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: TextWidget(
                      text: 'Cancel',
                      textSize: 18,
                      maxLines: 1,
                      isText: true,
                      color: Colors.white,
                    ),
                  )
                : Container(),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
              ),
              onPressed: () => ftx(),
              child: TextWidget(
                text: bottomText,
                textSize: 18,
                maxLines: 1,
                isText: true,
                color: Colors.red,
              ),
            )
          ],
        );
      });
}
