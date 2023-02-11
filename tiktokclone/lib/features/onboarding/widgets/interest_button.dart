import 'package:flutter/material.dart';
import 'package:tiktokclone/constants/sizes.dart';
import 'package:tiktokclone/utils.dart';

class InterestButton extends StatefulWidget {
  const InterestButton({
    Key? key,
    required this.interest,
  }) : super(key: key);

  final String interest;

  @override
  State<InterestButton> createState() => _InterestButtonState();
}

class _InterestButtonState extends State<InterestButton> {
  bool _isSelected = false;

  void _onTap() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size16,
          horizontal: Sizes.size24,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black.withOpacity(0.1),
          ),
          color: _isSelected
              ? Theme.of(context).primaryColor
              : isDarkMode(context)
                  ? Colors.grey.shade800
                  : Colors.white,
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              spreadRadius: 5,
            )
          ],
        ),
        child: Text(
          widget.interest,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: _isSelected
                ? Colors.white
                : isDarkMode(context)
                    ? Colors.white
                    : Colors.black87,
          ),
        ),
      ),
    );
  }
}
