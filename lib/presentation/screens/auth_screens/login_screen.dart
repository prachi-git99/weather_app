import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_weather_app/presentation/consts/consts.dart';

import '../../../application/blocs/auth_bloc/auth_bloc.dart';
import '../../../application/blocs/auth_bloc/auth_event.dart';
import '../../../application/blocs/auth_bloc/auth_state.dart';
import '../../widgets/common_widgets/custom_sizedbox.dart';
import '../../widgets/form_widgets/custom_textfield.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: black,
      resizeToAvoidBottomInset: true,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          } else if (state is AuthAuthenticated) {
            Navigator.pushReplacementNamed(context, '/');
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(appAllPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/world_map_bg.png"),
              mediumVerticalSizedBox(),
              const Text("Login to your Account",
                  style: TextStyle(
                      color: white,
                      fontWeight: FontWeight.w600,
                      fontFamily: poppins,
                      fontSize: extraLargeFont)),
              largeVerticalSizedBox(),
              customTextField(
                  controller: _emailController,
                  hintText: emailHintText,
                  obscureText: false,
                  keyBoardType: TextInputType.emailAddress),
              smallVerticalSizedBox(),
              customTextField(
                  controller: _passwordController,
                  obscureText: true,
                  hintText: passwordHintText,
                  keyBoardType: TextInputType.text),
              smallVerticalSizedBox(),
              SizedBox(
                width: size.width,
                child: FilledButton(
                    onPressed: () {
                      BlocProvider.of<AuthBloc>(context).add(
                        AuthLoggedIn(
                          email: _emailController.text,
                          password: _passwordController.text,
                        ),
                      );
                    },
                    child: const Text(loginBtnText,
                        style: TextStyle(color: white, fontFamily: poppins))),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/register');
                },
                child: const Text(
                  needToRegisterBtnText,
                  style: TextStyle(color: white, fontFamily: poppins),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}