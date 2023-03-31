import 'package:flutter/material.dart';
import 'package:flutter_base_rootstrap/presentation/bloc/sign_up/sign_up_cubit.dart';
import 'package:flutter_base_rootstrap/presentation/ui/pages/sign%20up/sign_up_view.dart';
import 'package:flutter_base_rootstrap/utils/globals.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SignUpCubit>(),
      child: SignUpView(),
    );
  }
}
