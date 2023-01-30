import 'package:demo_shop/constants/color_constants.dart';
import 'package:demo_shop/modules/login/logic/login_bloc.dart';
import 'package:demo_shop/services/routing/routing_constants.dart';
import 'package:demo_shop/utility/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../../../constants/string_constants.dart';
import '../../../utility/helpers/alerts.dart';
import '../../../utility/widgets/sized_box_widgets.dart';
import '../widgets/custom_text_field.dart';

class LoginUI extends StatelessWidget {
  LoginUI({Key? key}) : super(key: key);

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final LoginBloc loginBloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: ListView(
          shrinkWrap: true,
          children: [
            size46H,
            headerText(),
            loginGif(),
            formFields(),
            size46H,
            loginButton(),
          ],
        ),
      ),
    );
  }

  Widget headerText() {
    return const Text(
      loginHere,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
    );
  }

  Widget loginGif() {
    return Center(
      child: Lottie.asset(loginGifPath,
          height: 160, fit: BoxFit.fill, repeat: false),
    );
  }

  Widget formFields() {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextField(
            controller: usernameController,
            hintText: usernameHint,
            labelText: username,
          ),
          size20H,
          CustomTextField(
            controller: passwordController,
            hintText: passwordHint,
            labelText: password,
          )
        ],
      ),
    );
  }

  Widget loginButton() {
    return BlocConsumer(
      bloc: loginBloc,
      listener: (context, state) {
        if (state is LoginSuccess) {
          showSnackBar(context, message: loginSuccessfully);
          context.goNamed(productListScreenName);
        }
        if (state is LoginFailed) {
          showSnackBar(context, message: state.errorMessage, error: true);
        }
      },
      builder: (context, state) {
        if (state is LoginLoading) {
          return CustomButton(onPress: () {}, isLoading: true, text: login);
        }

        return CustomButton(
            onPress: () {
              if (formKey.currentState!.validate()) {
                loginBloc.add(LoginWithUsername(
                    password: passwordController.text.trim(),
                    username: usernameController.text.trim()));
              }
            },
            text: login);
      },
    );
  }
}
