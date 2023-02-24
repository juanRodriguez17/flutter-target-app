import 'package:flutter/material.dart';
import 'package:flutter_base_rootstrap/presentation/resources/resources.dart';

class TextInputForm extends StatelessWidget {
  final String labelText;
  final String hintText;

  const TextInputForm({
    Key? key,
    required this.labelText,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          labelText,
          style: Theme.of(context).textTheme.headline5,
        ),
        Padding(
          padding: EdgeInsets.only(top: spacing.xxs),
          child: TextFormField(
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
