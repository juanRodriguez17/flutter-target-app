import 'package:flutter/material.dart';
import 'package:flutter_base_rootstrap/int_constants.dart';
import 'package:flutter_base_rootstrap/presentation/resources/locale/generated/l10n.dart';
import 'package:flutter_base_rootstrap/string_constants.dart';
import 'package:flutter_base_rootstrap/presentation/resources/resources.dart';

class TextInputForm extends StatelessWidget {
  final String labelText;
  final String hintText;
  final bool isSensitive;
  final FieldValidator? validator;
  final Function(String)? onFieldSaved;

  const TextInputForm({
    Key? key,
    required this.labelText,
    required this.hintText,
    this.isSensitive = false,
    this.validator,
    this.onFieldSaved,
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
            obscureText: isSensitive,
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            onSaved: (value) {
              if (value != null) onFieldSaved?.call(value);
            },
            validator: (value) => handleFieldValidation(value, context),
          ),
        ),
      ],
    );
  }

  handleFieldValidation(String? value, BuildContext context) {
    if (validator != null && !validator!.isFieldValid(value, context)) {
      return validator!.errorMessage;
    }

    return null;
  }
}

abstract class FieldValidator {
  String errorMessage;

  FieldValidator({this.errorMessage = ""});

  bool isFieldValid(String? value, BuildContext context);
}

class EmailFieldValidator extends FieldValidator {
  EmailFieldValidator();

  @override
  bool isFieldValid(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      errorMessage = S.of(context).emailEmptyMessage;
      return false;
    }
    if (!RegExp(StringConstants.emailRegex).hasMatch(value)) {
      errorMessage = S.of(context).emailFormatMessage;
      return false;
    }
    return true;
  }
}

class PasswordFieldValidator extends FieldValidator {
  final String? regexExpression;

  PasswordFieldValidator({this.regexExpression});

  @override
  bool isFieldValid(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      errorMessage = S.of(context).passwordEmptyMessage;
      return false;
    }
    if (value.length < IntConstants.minPasswordLength) {
      errorMessage = S.of(context).passwordFormatMessage;
      return false;
    }

    return true;
  }
}
