import 'package:flutter/material.dart';
import 'package:flutter_base_rootstrap/presentation/resources/locale/generated/l10n.dart';
import 'package:flutter_base_rootstrap/presentation/resources/resources.dart';
import 'package:flutter_base_rootstrap/presentation/ui/custom/custom_button.dart';
import 'package:flutter_base_rootstrap/presentation/ui/custom/dropdown_input_form.dart';
import 'package:flutter_base_rootstrap/presentation/ui/custom/text_input_form.dart';
import 'package:flutter_base_rootstrap/string_constants.dart';
import 'package:flutter_base_rootstrap/utils/routes.dart';

class SignUpView extends StatelessWidget {
  SignUpView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  String _name = StringConstants.empty;
  String _email = StringConstants.empty;
  String _password = StringConstants.empty;
  String _confirmPassword = StringConstants.empty;
  String _gender = StringConstants.empty;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height + 50,
        ),
        child: Stack(
          children: [
            Scaffold(
              body: Form(
                key: _formKey,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Image.asset(
                      'assets/images/circle_image.png',
                      fit: BoxFit.fitWidth,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 125),
                      child: Column(
                        children: [
                          Text(
                            S.of(context).targetTitle,
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(top: 68),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 66),
                              child: Column(
                                children: [
                                  TextInputForm(
                                    labelText: S.of(context).nameLabel,
                                    hintText: S.of(context).nameHintText,
                                    validator: NameFieldValidator(),
                                    onFieldSaved: (value) {},
                                    onTaped: () {},
                                  ),
                                  const SizedBox(height: 17),
                                  TextInputForm(
                                    labelText: S.of(context).emailLabel,
                                    hintText: S.of(context).emailHintText,
                                    validator: EmailFieldValidator(),
                                    onFieldSaved: (value) {},
                                    onTaped: () {},
                                  ),
                                  const SizedBox(height: 17),
                                  TextInputForm(
                                    labelText: S.of(context).passwordLabel,
                                    hintText: S.of(context).passwordHintText,
                                    isSensitive: true,
                                    validator: PasswordFieldValidator(),
                                    onChanged: (value) {
                                      _password = value.trim();
                                    },
                                    onFieldSaved: (value) {},
                                    onTaped: () {},
                                  ),
                                  const SizedBox(height: 17),
                                  TextInputForm(
                                    labelText:
                                        S.of(context).confirmPasswordLabel,
                                    hintText: S.of(context).passwordHintText,
                                    isSensitive: true,
                                    validator: ConfirmPasswordFieldValidator(
                                      oldPassword: _password,
                                    ),
                                    onFieldSaved: (value) {},
                                    onTaped: () {},
                                  ),
                                  const SizedBox(height: 17),
                                  DropDownInputForm(
                                    labelText: S.of(context).genderLabel,
                                    hintText: S.of(context).genderHintText,
                                    optionsList: const [
                                      "Female",
                                      "Male",
                                      "Other",
                                    ],
                                    validator: GenderFieldValidator(),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(top: 34),
                                    child: CustomButton(
                                      text: S.of(context).signUpTitle,
                                      buttonColor:
                                          Theme.of(context).colorScheme.primary,
                                      width: Dimen.authenticationButtonWidth,
                                      onPressed: () => signUp(context),
                                    ),
                                  ),
                                  const SizedBox(height: 19),
                                  const Divider(
                                    thickness: 0.5,
                                    color: Colors.black,
                                    indent: 44,
                                    endIndent: 44,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: spacing.m),
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushReplacementNamed(
                                          Routes.signInScreen,
                                        );
                                      },
                                      child: Text(
                                        S.of(context).signInTitle,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  signUp(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }

    return;
  }
}
