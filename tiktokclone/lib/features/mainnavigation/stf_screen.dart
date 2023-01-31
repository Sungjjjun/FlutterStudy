import 'package:flutter/material.dart';
import 'package:tiktokclone/constants/sizes.dart';

class StfScreen extends StatefulWidget {
  const StfScreen({super.key});

  @override
  State<StfScreen> createState() => _StfScreenState();
}

class _StfScreenState extends State<StfScreen> {
  int _click = 0;

  void _increase() {
    setState(() {
      _click = _click + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$_click',
            style: const TextStyle(
              fontSize: Sizes.size44,
            ),
          ),
          TextButton(
            onPressed: _increase,
            child: const Text("+"),
          ),
        ],
      ),
    );
  }
}
