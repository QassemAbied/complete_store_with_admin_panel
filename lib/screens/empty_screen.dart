import 'package:flutter/material.dart';

class EmptyScreen extends StatefulWidget {
  final String titleEmpty;
   EmptyScreen({super.key, required this.titleEmpty});

  @override
  State<EmptyScreen> createState() => _EmptyScreenState();
}

class _EmptyScreenState extends State<EmptyScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 80),
        child: Column(
          children: [
            Image(
              image: AssetImage('assets/images/box.png'),
              fit: BoxFit.cover,
            ),
            Text(
              widget.titleEmpty,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
