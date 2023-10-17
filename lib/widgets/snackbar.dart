import 'package:flutter/material.dart';

import '../config/color.dart';

class CustomSnackBar extends StatelessWidget {
  final String text;
  const CustomSnackBar({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColor.black.withOpacity(0.8),
      content: Text(text),
    );
  }
}
