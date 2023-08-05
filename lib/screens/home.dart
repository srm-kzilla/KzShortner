import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KzLinks'),
      ),
      body: Center(
        child: TextButton(
          child: const Text('Hello World'),
          onPressed: () {},
        ),
      ),
    );
  }
}
