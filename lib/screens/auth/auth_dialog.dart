import 'package:flutter/material.dart';
import '../../widget/text_widget.dart';

Future<void> showAlertDialogRegister({
  required BuildContext context,
  required String text,
  required String contentText,
}) async {
  return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              const Icon(
                Icons.error,
                color: Colors.red,
                size: 35,
              ),
              TextWidget(
                text: text,
                textSize: 22,
                maxLines: 1,
                isText: true,
                color: Colors.black,
              ),
            ],
          ),
          content: TextWidget(
            text: contentText,
            textSize: 18,
            maxLines: 5,
            isText: true,
            color: Colors.black,
          ),
          actions: [
            TextWidget(
              text: 'Cancel',
              textSize: 18,
              maxLines: 1,
              isText: true,
              color: Colors.white,
            ),
          ],
        );
      });
}
