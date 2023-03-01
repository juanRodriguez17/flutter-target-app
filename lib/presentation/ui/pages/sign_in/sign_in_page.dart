import 'package:flutter/material.dart';
import 'package:flutter_base_rootstrap/presentation/bloc/sign_in/sign_in_cubit.dart';
import 'package:flutter_base_rootstrap/presentation/ui/pages/sign_in/sign_in_view.dart';
import 'package:flutter_base_rootstrap/utils/globals.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => getIt<SignInCubit>(),
        child: const SignInView(),
    );
  }
}
