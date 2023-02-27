import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_base_rootstrap/presentation/resources/locale/generated/l10n.dart';
import 'package:flutter_base_rootstrap/presentation/resources/resources.dart';
import 'package:flutter_base_rootstrap/presentation/ui/custom/custom_button.dart';
import 'package:flutter_base_rootstrap/presentation/ui/custom/text_input_form.dart';

class SignInView extends StatelessWidget {
  SignInView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      padding: const EdgeInsets.symmetric(horizontal: 66),
                      child: Column(
                        children: [
                          TextInputForm(
                            labelText: S.of(context).emailLabel,
                            hintText: S.of(context).emailHintText,
                            validator: EmailFieldValidator(),
                          ),
                          const SizedBox(height: 24),
                          TextInputForm(
                            labelText: S.of(context).passwordLabel,
                            hintText: S.of(context).passwordHintText,
                            isPassword: true,
                            validator: PasswordFieldValidator(),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 26),
                            child: CustomButton(
                              text: S.of(context).signInTitle,
                              buttonColor:
                                  Theme.of(context).colorScheme.primary,
                              width: Dimen.authenticationButtonWidth,
                              onPressed: () => login(),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: spacing.s),
                            child: Text(
                              S.of(context).forgotYourPassword,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(fontSize: 10.5),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: spacing.xl),
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                S.of(context).connectWithFacebook,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    ?.copyWith(letterSpacing: 2.4),
                              ),
                            ),
                          ),
                          const SizedBox(height: 60),
                          const Divider(
                            thickness: 0.5,
                            color: Colors.black,
                            indent: 44,
                            endIndent: 44,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: spacing.m),
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                S.of(context).signUpTitle,
                                style: Theme.of(context).textTheme.headline5,
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
    );
  }

  login() {
    if (!_formKey.currentState!.validate()) {
      // Invalid
      log("Invalid");
      return;
    }
    _formKey.currentState!.save();

    // TODO: Make login call

  }
}
