import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class AuthFeatureButton extends StatelessWidget {
  const AuthFeatureButton({
    super.key,
    required this.onClickEvent,
    required this.text,
    this.alignment = Alignment.centerRight,
    this.isEnabled = true,
  });

  final void Function()? onClickEvent;
  final String text;
  final Alignment? alignment;
  final bool? isEnabled;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment!,
      child: ElevatedButton(
        onPressed: isEnabled! ? onClickEvent : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.darkColor,
          foregroundColor: AppColors.thirdColor,
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(text),
      ),
    );
  }
}
