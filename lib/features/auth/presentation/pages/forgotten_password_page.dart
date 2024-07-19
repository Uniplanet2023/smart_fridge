import 'package:flutter/material.dart';
import 'package:smart_fridge/config/widgets/custom_textfield.dart';

class ForgottenPasswordPage extends StatefulWidget {
  const ForgottenPasswordPage({super.key});

  @override
  ForgottenPasswordPageState createState() => ForgottenPasswordPageState();
}

class ForgottenPasswordPageState extends State<ForgottenPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetPassword() {
    // if (_formKey.currentState!.validate()) {
    //   context
    //       .read<AuthBloc>()
    //       .add(ResetPasswordEvent(email: _emailController.text));
    //   // Implement your logic to send a reset password email
    //   log('Sending reset password link to: ${_emailController.text}');
    // }
  }
  
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
              const SizedBox(
                height: 10,
              ),
              Text(
                'Enter your email address to receive a password reset link.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: _emailController,
                hintText: 'Email',
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: _resetPassword,
                  child: Text(
                    'Send Reset Link',
                    style: Theme.of(context).textTheme.headlineLarge,
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
