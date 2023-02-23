import 'package:flutter/material.dart';
import 'package:flutter_base_rootstrap/presentation/resources/resources.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color buttonColor;
  final double width;
  final VoidCallback onPressed;

  const CustomButton({
    Key? key,
    required this.text,
    required this.buttonColor,
    required this.width,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: Dimen.primaryButtonHeight,
      color: buttonColor,
      child: TextButton(
        onPressed: () => onPressed.call(),
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .headline5
              ?.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
