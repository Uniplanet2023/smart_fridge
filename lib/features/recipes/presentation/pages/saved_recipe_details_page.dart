import 'package:flutter/material.dart';

class SavedRecipeDetailsPage extends StatelessWidget {
  const SavedRecipeDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recipe Detail',
          style: Theme.of(context)
              .textTheme
              .headlineLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [Text('a')],
          ),
        ),
      ),
    );
  }
}
