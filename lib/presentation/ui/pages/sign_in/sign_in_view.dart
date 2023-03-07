import 'package:flutter/material.dart';
import 'package:flutter_base_rootstrap/presentation/bloc/sign_in/sign_in_cubit.dart';
import 'package:flutter_base_rootstrap/presentation/bloc/sign_in/sign_in_state.dart';
import 'package:flutter_base_rootstrap/presentation/resources/locale/generated/l10n.dart';
import 'package:flutter_base_rootstrap/presentation/resources/resources.dart';
import 'package:flutter_base_rootstrap/presentation/ui/custom/custom_button.dart';
import 'package:flutter_base_rootstrap/presentation/ui/custom/text_input_form.dart';
import 'package:flutter_base_rootstrap/string_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInState();
}

class _SignInState extends State<SignInView> {
  final _formKey = GlobalKey<FormState>();

  String _email = StringConstants.empty;
  String _password = StringConstants.empty;
  String? _errorRetrieved;
  String? _errorInputFormat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: BlocConsumer<SignInCubit, SignInState>(
          listenWhen: (prevState, currentState) => prevState != currentState,
          listener: (context, state) {
            listenStates(context, state);
          },
          builder: (context, state) {
            if (state is SignInLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Stack(
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
                                onFieldSaved: (value) {
                                  _email = value.trim();
                                },
                                onTaped: () =>
                                    context.read<SignInCubit>().resetInputs(),
                                errorText: _errorInputFormat,
                              ),
                              const SizedBox(height: 24),
                              TextInputForm(
                                labelText: S.of(context).passwordLabel,
                                hintText: S.of(context).passwordHintText,
                                isSensitive: true,
                                validator: PasswordFieldValidator(),
                                onFieldSaved: (value) {
                                  _password = value.trim();
                                },
                                onTaped: () =>
                                    context.read<SignInCubit>().resetInputs(),
                                errorText: _errorRetrieved,
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
                                  onPressed: () {
                                    // TODO: Implement facebook login
                                  },
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
                                  onPressed: () {
                                    // TODO: Navigate to Sign Up screen
                                  },
                                  child: Text(
                                    S.of(context).signUpTitle,
                                    style:
                                        Theme.of(context).textTheme.headline5,
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
            );
          },
        ),
      ),
    );
  }

  setErrorMessages(bool shouldShowErrors) {
    _errorRetrieved = shouldShowErrors ? S.of(context).signInError : null;
    _errorInputFormat = shouldShowErrors ? StringConstants.empty : null;
  }

  login() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      context.read<SignInCubit>().signIn(_email, _password);
    }
    return;
  }

  listenStates(BuildContext context, SignInState state) {
    if (state is SignInInitial) setErrorMessages(false);
    if (state is SignInError) setErrorMessages(true);
    if (state is SignInSuccessful) {
      // TODO: Navigate to home screen
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Login successful"),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
}
