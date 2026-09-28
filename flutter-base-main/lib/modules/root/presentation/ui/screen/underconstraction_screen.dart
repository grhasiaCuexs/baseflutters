import 'package:flutter/material.dart';

class UnderConstructionScreen extends StatelessWidget {
  const UnderConstructionScreen(
    this.titlePage, {
    super.key,
  });

  final String titlePage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        child: Text("Halaman $titlePage dalam pengembangan"),
      ),
    );
  }
}
