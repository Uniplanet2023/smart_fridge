import 'package:flutter/material.dart';

class ScanReceiptsScreen extends StatefulWidget {
  const ScanReceiptsScreen({super.key});

  @override
  State<ScanReceiptsScreen> createState() => _ScanReceiptsScreenState();
}

class _ScanReceiptsScreenState extends State<ScanReceiptsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Scan receipts'),
      ),
    );
  }
}
