import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_fridge/core/helper/shared_preferences_helper.dart';
import 'package:smart_fridge/config/theme/cubit/theme_cubit.dart';
import 'package:smart_fridge/config/theme/theme.dart';
import 'package:smart_fridge/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:smart_fridge/features/auth/presentation/pages/change_password_page.dart';
import 'package:smart_fridge/features/auth/presentation/pages/reauthenticate_page.dart';
import 'package:smart_fridge/features/auth/presentation/pages/signup_page.dart';
import 'package:smart_fridge/features/auth/presentation/widgets/menu_selection.dart';
import 'package:smart_fridge/core/notification/notification_permission.dart';

class AccountSettingsPage extends StatefulWidget {
  const AccountSettingsPage({super.key});

  @override
  State<AccountSettingsPage> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettingsPage> {
  final TextEditingController _updateNameController = TextEditingController();
  bool notify = false;
  bool theme = false;

  @override
  void initState() {
    super.initState();
    notify =
        SharedPreferencesHelper().getBool('notificationPermission') ?? false;
    theme = false;
  }

  // returns display switch button icons based on notification is allowed or not
  final WidgetStateProperty<Icon?> thumbIcon =
      WidgetStateProperty.resolveWith<Icon?>(
    (Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

  // returns display switch button icons based on display theme
  final WidgetStateProperty<Icon?> displayIcon =
      WidgetStateProperty.resolveWith<Icon?>(
    (Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return const Icon(Icons.dark_mode_outlined);
      }
      return const Icon(Icons.light_mode_outlined);
    },
  );

  void updateNotification(bool changedValue) async {
    bool notificationPermission = await toggleNotifications(changedValue);
    notify = notificationPermission;
    setState(() {});
  }

  void toggleTheme(bool currentState) async {
    final cubit = context.read<ThemeCubit>();
    theme = !theme;
    cubit.toggleTheme();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthChangedName) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
              content: Text(
                'Successfully Changed Name',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.inverseSurface),
              ),
            ),
          );
        } else if (state is AuthDeleted) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const SignupPage(),
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
        appBar: AppBar(
          title: Text(
            'Account Settings',
            style: Theme.of(context)
                .textTheme
                .headlineLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                SizedBox(height: 15.h),
                Container(
                  alignment: Alignment.bottomLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    "Account Information",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                MenuSection(
                  title: "Change Name",
                  icon: Icons.manage_accounts_outlined,
                  ontap: () {
                    return _buildChangeNameDialog();
                  },
                ),
                SizedBox(
                  height: 5.h,
                ),
                MenuSection(
                  title: "Change Password",
                  icon: Icons.manage_accounts_outlined,
                  ontap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChangePasswordPage(),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 5.h,
                ),
                MenuSection(
                  title: "Delete Account",
                  icon: Icons.no_accounts_outlined,
                  color: Theme.of(context).colorScheme.error,
                  ontap: () {
                    return _buildDeleteAccountDialog();
                  },
                ),
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    "Notifications",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                MenuSection(
                  title: 'Allow Notifications',
                  icon: Icons.notifications_outlined,
                  transition: Switch(
                    thumbIcon: thumbIcon,
                    value: notify,
                    activeColor: Theme.of(context).colorScheme.primary,
                    onChanged: (bool value) {
                      // This is called when the user toggles the switch.
                      updateNotification(value);
                    },
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    "Display Theme",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                BlocBuilder<ThemeCubit, ThemeData>(
                  builder: (context, state) {
                    bool isDarkMode = state == darkMode;
                    return MenuSection(
                      title: 'Appearance',
                      icon: Icons.light_mode_outlined,
                      transition: Switch(
                        thumbIcon: displayIcon,
                        value: isDarkMode,
                        activeColor: Theme.of(context).colorScheme.primary,
                        onChanged: (bool value) {
                          toggleTheme(value);
                        },
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildDeleteAccountDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Icon(
            Icons.warning_amber,
            size: 50,
            color: Theme.of(context).colorScheme.error,
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  'Do you want really to delete your account? \nYou will not be able to undo this action.'),
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
                'Delete',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
              onPressed: () => {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ReauthenticatePage(),
                  ),
                )
                // context.read<AuthBloc>().add(DeleteUserEvent());
                // Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _buildChangeNameDialog() {
    final formKey = GlobalKey<FormState>();

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Change Name'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Enter a new name:'),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _updateNameController,
                  decoration: const InputDecoration(
                    hintText: 'Enter a new name',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter a valid username';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Save'),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  context
                      .read<AuthBloc>()
                      .add(ChangeNameEvent(_updateNameController.text.trim()));
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
