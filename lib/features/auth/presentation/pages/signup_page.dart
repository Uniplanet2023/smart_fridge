import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:smart_fridge/config/routes/names.dart';
import 'package:smart_fridge/config/widgets/bottom_bar.dart';
import 'package:smart_fridge/config/widgets/custom_textfield.dart';
import 'package:smart_fridge/core/resources/initialization.dart';
import 'package:smart_fridge/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _signUpFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool validPassword = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoaded) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const BottomBar(),
            ),
          );
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).colorScheme.errorContainer,
              content: Text(
                state.message,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.inverseSurface),
              ),
            ),
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Form(
                    key: _signUpFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sign Up",
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Create your account 🥳",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: SignInButton(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            Buttons.Google,
                            text: "Sign up with Google",
                            onPressed: () => serviceLocator<AuthBloc>()
                                .add(SignInWithGoogleEvent()),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            const Expanded(child: Divider()),
                            Text(
                              "   or sign up with Email   ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant, // Change this to your desired color
                                      fontWeight: FontWeight.w600),
                            ),
                            const Expanded(child: Divider()),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomTextField(
                          controller: _usernameController,
                          hintText: "Enter Username",
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          controller: _emailController,
                          hintText: "Enter Email Address",
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          controller: _passwordController,
                          hintText: 'Password',
                          obscureText: true,
                          isPassword: true,
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 90,
                          child: FlutterPwValidator(
                            controller: _passwordController,
                            minLength: 6,
                            uppercaseCharCount: 1,
                            numericCharCount: 1,
                            width: 350,
                            height: 150,
                            onSuccess: () {
                              setState(() {
                                validPassword = true;
                              });
                            },
                            onFail: () {
                              setState(() {
                                validPassword = false;
                              });
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_signUpFormKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(
                                      SignupEvent(
                                        _emailController.text.trim(),
                                        _passwordController.text.trim(),
                                        _usernameController.text.trim(),
                                      ),
                                    );
                              }
                            },
                            child: BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                                if (state is AuthLoading) {
                                  return const CircularProgressIndicator();
                                } else {
                                  return Text(
                                    'Sign Up',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge,
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Already have an account? '),
                            TextButton(
                              onPressed: () {
                                Navigator.popAndPushNamed(
                                    context, AppRoutes.signinPage);
                              },
                              child: Text(
                                "Sign In!",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
