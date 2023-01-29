import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPress;
  final String text;
  final double? textSize;
  final bool isLoading;
  const CustomButton(
      {Key? key,
      required this.onPress,
      required this.text,
      this.textSize,
      this.isLoading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Theme.of(context).primaryColor,
      height: 20,
      minWidth: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: Theme.of(context).primaryColor)),
      onPressed: onPress,
      child: !isLoading
          ? Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: textSize ?? 20),
            )
          : const SizedBox(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2.0,
              ),
            ),
    );
  }
}
