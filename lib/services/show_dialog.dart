// import 'package:flutter/material.dart';
// import 'package:complete_astore_adminpanel/widget/text_widget.dart';
//
// class ShowDialog extends StatelessWidget {
//   const ShowDialog({super.key, required this.text, required this.widget, required this.textButton, required this.onPressed});
//   final String text;
//   final String textButton;
//   final Function onPressed;
//
//   final Widget widget;
//   @override
//   Widget build(BuildContext context) async {
//     return await showDialog(
//         context: context,
//         builder: (context){
//           return AlertDialog(
//             title: TextWidget(
//               text: text,
//                 color: Colors.deepPurple,
//               textSize: 22,
//               isText: true,
//               maxLines: 1,
//             ),
//             content: widget,
//             actions: [
//               ElevatedButton(
//                 onPressed: ()=>onPressed(),
//                 child: TextWidget(
//                   text: textButton,
//                   textSize: 20,
//                   maxLines: 1,
//                   isText: true,
//                   color: Colors.white,
//                 ),
//               )
//             ],
//           );
//         }
//     );
//   }
// }
