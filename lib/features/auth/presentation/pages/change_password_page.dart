import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_fridge/config/widgets/custom_textfield.dart';
import 'package:smart_fridge/core/resources/initialization.dart';
import 'package:smart_fridge/features/auth/presentation/bloc/auth_bloc.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController =
      TextEditingController();
  bool passwordsMatch = false;
  bool validPassword = false;

  @override
  void initState() {
    super.initState();
    _newPasswordController.addListener(_validatePasswordsMatch);
    _confirmNewPasswordController.addListener(_validatePasswordsMatch);
  }

  void _validatePasswordsMatch() {
    if (_newPasswordController.text == _confirmNewPasswordController.text) {
      if (!passwordsMatch) {
        setState(() {
          passwordsMatch = true;
        });
      }
    } else {
      if (passwordsMatch) {
        setState(() {
          passwordsMatch = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Reset Password",
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  'Enter your current password followed by a new password to reset your Password.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(height: 20.h),
                CustomTextField(
                  obscureText: true,
                  isPassword: true,
                  controller: _currentPasswordController,
                  hintText: 'Current Password',
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomTextField(
                  obscureText: true,
                  isPassword: true,
                  controller: _newPasswordController,
                  hintText: "Enter New Password",
                ),
                SizedBox(height: 5.h),
                const SizedBox(height: 10),
                SizedBox(
                  child: FlutterPwValidator(
                      controller: _newPasswordController,
                      minLength: 6,
                      uppercaseCharCount: 1,
                      numericCharCount: 1,
                      width: 350,
                      height: 100,
                      onSuccess: () {
                        setState(() {
                          validPassword = true;
                        });
                      },
                      onFail: () {
                        setState(() {
                          validPassword = false;
                        });
                      }),
                ),
                SizedBox(height: 5.h),
                SizedBox(
                  height: 10.h,
                ),
                CustomTextField(
                  obscureText: true,
                  isPassword: true,
                  controller: _confirmNewPasswordController,
                  hintText: "Confirm New Password",
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (!passwordsMatch) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor:
                                  Theme.of(context).colorScheme.errorContainer,
                              content: Text(
                                'New password must match with confirmation password',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inverseSurface),
                              ),
                            ),
                          );
                        }
                        if (!validPassword) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor:
                                  Theme.of(context).colorScheme.errorContainer,
                              content: Text(
                                'Password is not Valid',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inverseSurface),
                              ),
                            ),
                          );
                        }
                        if (validPassword && passwordsMatch) {
                          serviceLocator.get<AuthBloc>().add(
                                UpdatePasswordEvent(
                                  serviceLocator
                                      .get<AuthBloc>()
                                      .state
                                      .user
                                      .email,
                                  _currentPasswordController.text.trim(),
                                  _newPasswordController.text.trim(),
                                ),
                              );
                        }
                      }
                    },
                    child: Text(
                      'Save',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
