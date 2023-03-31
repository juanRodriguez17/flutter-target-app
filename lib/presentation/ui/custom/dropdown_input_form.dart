import 'package:flutter/material.dart';
import 'package:flutter_base_rootstrap/presentation/resources/locale/generated/l10n.dart';
import 'package:flutter_base_rootstrap/presentation/resources/resources.dart';
import 'package:flutter_base_rootstrap/presentation/ui/custom/text_input_form.dart';
import 'package:flutter_base_rootstrap/string_constants.dart';

class DropDownInputForm extends StatefulWidget {
  final String labelText;
  final String hintText;
  final List optionsList;
  final FieldValidator? validator;
  final Function(String)? onFieldSaved;

  const DropDownInputForm({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.optionsList,
    required this.validator,
    required this.onFieldSaved,
  }) : super(key: key);

  @override
  State<DropDownInputForm> createState() => _DropDownInputFormState();
}

class _DropDownInputFormState extends State<DropDownInputForm> {
  String? _selectedValue = StringConstants.empty;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.labelText,
          style: Theme.of(context).textTheme.headline5,
        ),
        Padding(
          padding: EdgeInsets.only(top: spacing.xxs),
          child: DropdownButtonFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            isExpanded: true,
            hint: Align(
              alignment: Alignment.center,
              child: Text(widget.hintText),
            ),
            icon: const Visibility(
              visible: false,
              child: Icon(Icons.arrow_downward),
            ),
            items: widget.optionsList.map((e) {
              return DropdownMenuItem(
                value: (e as String).toLowerCase(),
                child: Center(child: Text(e)),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedValue = value as String;
              });
            },
            onSaved: (_) {
              if (_selectedValue != null) {
                widget.onFieldSaved?.call(_selectedValue!);
              }
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            validator: (value) =>
                handleFieldValidation(value as String?, context),
          ),
        ),
      ],
    );
  }

  handleFieldValidation(String? value, BuildContext context) {
    if (widget.validator != null &&
        !widget.validator!.isFieldValid(value, context)) {
      return widget.validator!.errorMessage;
    }

    return null;
  }
}

class GenderFieldValidator extends FieldValidator {
  GenderFieldValidator();

  @override
  bool isFieldValid(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      errorMessage = S.of(context).genderEmptyMessage;
      return false;
    }

    return true;
  }
}
