import 'package:flutter/material.dart';

Widget quantityController(
    {required Function ftx, required IconData iconData, required Color color}) {
  return Material(
    borderRadius: BorderRadius.circular(10),
    color: color,
    child: InkWell(
      onTap: () => ftx(),
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            iconData,
            color: Colors.white,
          )),
    ),
  );
}
