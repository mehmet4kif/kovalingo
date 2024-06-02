import 'package:flutter/material.dart';
import 'package:kovalingo/constants/styles.dart';

class WordPackageButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const WordPackageButton({
    required this.text,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: TextButton(
        onPressed: onTap,
        child: Container(
          decoration:CustomStyles.customCircularBorderContainerStyle,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                style: CustomStyles.whiteAndBoldTextStyleL,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
