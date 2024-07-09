import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController testController = TextEditingController();

  @override
  void dispose() {
    testController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        bottom: false,
        child: Center(
          child: Text('HOME'),
        ),
      ),
    );
  }
}
