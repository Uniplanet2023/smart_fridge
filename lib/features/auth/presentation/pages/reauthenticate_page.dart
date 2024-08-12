import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:smart_fridge/config/routes/names.dart';
import 'package:smart_fridge/config/widgets/custom_textfield.dart';
import 'package:smart_fridge/core/resources/initialization.dart';
import 'package:smart_fridge/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:smart_fridge/features/auth/presentation/pages/forgotten_password_page.dart';
import 'package:smart_fridge/features/auth/presentation/pages/signup_page.dart';

class ReauthenticatePage extends StatefulWidget {
  const ReauthenticatePage({super.key});

  @override
  State<ReauthenticatePage> createState() => _ReauthenticatePageState();
}

class _ReauthenticatePageState extends State<ReauthenticatePage> {
  final _signInFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
          // user login was successful, continue with Account Deletion
          context.read<AuthBloc>().add(DeleteUserEvent());
        } else if (state is AuthDeleted) {
          // if account deleted state is invoked, Show successful deletion of
          // user account then navigate to sign up page
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
              content: Text(
                'Account successfully deleted!',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.inverseSurface),
              ),
            ),
          );
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const SignupPage(),
            ),
            ModalRoute.withName(AppRoutes.signinPage),
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
        appBar: AppBar(),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Form(
                    key: _signInFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Reauthenticate",
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Please log in with your credentials to proceed with the account deletion process.",
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
                            text: "Sign in with Google",
                            onPressed: () {
                              serviceLocator<AuthBloc>()
                                  .add(SignInWithGoogleEvent());
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            const Expanded(child: Divider()),
                            Text(
                              "   or Login with Email   ",
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
                          controller: _emailController,
                          hintText: "Enter Email Address",
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          obscureText: true,
                          isPassword: true,
                          controller: _passwordController,
                          hintText: "Enter Password",
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgottenPasswordPage(),
                                  ),
                                );
                              },
                              child: Text(
                                'Forgot Password?',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_signInFormKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(
                                      LoginEvent(
                                        _emailController.text.trim(),
                                        _passwordController.text.trim(),
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
                                    'Sign in',
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
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
