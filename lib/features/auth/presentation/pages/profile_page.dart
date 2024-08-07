import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_fridge/features/auth/domain/entities/user.dart';
import 'package:smart_fridge/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:smart_fridge/features/auth/presentation/pages/account_settings_page.dart';
import 'package:smart_fridge/features/auth/presentation/pages/signin_page.dart';
import 'package:smart_fridge/features/auth/presentation/widgets/menu_selection.dart';
import 'package:smart_fridge/features/auth/presentation/widgets/user_card.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    late final User? currentUser;
    currentUser = context.watch<AuthBloc>().state.user;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoggedOut) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const SigninPage(),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Profile',
            style: Theme.of(context)
                .textTheme
                .headlineLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    UserCard(currentUser: currentUser),
                    SizedBox(
                      height: 30.h,
                    ),
                    MenuSection(
                      title: 'Account Settings',
                      icon: Icons.settings,
                      ontap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AccountSettingsPage(),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    MenuSection(
                      title: "Help",
                      icon: Icons.help_outline_outlined,
                      ontap: () {},
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    MenuSection(
                      title: "Terms and Policies",
                      icon: Icons.info_outlined,
                      ontap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const TermsAndPolicies(),
                        //   ),
                        // );
                      },
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    MenuSection(
                      color: Theme.of(context).colorScheme.error,
                      title: "Sign out",
                      icon: Icons.exit_to_app,
                      ontap: () {
                        return _buildSignoutDialog();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildSignoutDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Icon(
            Icons.logout_outlined,
            size: 50,
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Sign out of your account?'),
              SizedBox(height: 10),
            ],
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: Text(
                'sign out',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
              onPressed: () {
                context.read<AuthBloc>().add(LogoutEvent());
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
