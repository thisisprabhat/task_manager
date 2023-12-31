import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '/presentation/screens/authentication/signup.dart';
import '/presentation/screens/homescreen/homescreen.dart';
import '/presentation/widgets/loader.dart';
import '/domain/bloc/auth_bloc/auth_bloc.dart';
import '/core/constants/app_assets.dart';
import '/core/constants/styles.dart';
import '/core/utils/input_validation.dart';

part 'components/login_icon_texts.dart';
part 'components/login_bottom_buttons.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  static const String path = '/login';
  static const String routeName = 'login';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateLoginSuccess) {
          // Navigator.pushReplacementNamed(context, HomeScreen.path);
          context.goNamed(HomeScreen.routeName);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Login"),
            backgroundColor: colorScheme.background,
          ),
          body: state is AuthStateLoggingIn
              ? const Loader()
              : GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      children: [
                        const LoginIconAndTexts(),
                        TextFormField(
                          controller: _emailController,
                          validator: InputValidator.email,
                          decoration: const InputDecoration(
                            label: Text('Email'),
                            hintText: 'Enter your Email',
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _isPasswordVisible,
                          validator: InputValidator.password,
                          decoration: InputDecoration(
                            suffix: InkWell(
                              borderRadius: borderRadiusDefault,
                              child: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onTap: () => setState(
                                () => _isPasswordVisible = !_isPasswordVisible,
                              ),
                            ),
                            label: const Text('Password'),
                            hintText: 'Enter your password',
                          ),
                        ),
                        LoginBottomButtons(
                          onLoginPressed: () {
                            FocusScope.of(context).unfocus();
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                    AuthEventLoginWithEmailAndPassword(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    ),
                                  );
                              _emailController.clear();
                              _passwordController.clear();
                            }
                          },
                          onCreateNewAccountPressed: () {
                            // Navigator.pushNamed(context, Signup.path);
                            context.pushNamed(Signup.routeName);
                          },
                        ),
                        const SizedBox(height: 20)
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
