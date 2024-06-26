import 'package:flutter/material.dart';
import 'package:mvvm/res/color.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onPress;

  const RoundButton(
      {super.key,
      required this.title,
      required this.onPress,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 40,
        width: 200,
        decoration: BoxDecoration(
          color: AppColors.loginButtonColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: loading ? CircularProgressIndicator(
            color: Colors.black12,
          )
              : Text(
                  title,
                  style: TextStyle(color: AppColors.whiteColor),
                ),
        ),
      ),
    );
  }
}
