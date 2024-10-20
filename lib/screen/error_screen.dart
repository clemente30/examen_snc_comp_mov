import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const SingleChildScrollView(
        child: Center(
          child: Text(
              "Ohhhhh algo salió mal ;( tranquilo, respira y vamos de nuevo)."),
        ),
      ),
    );
  }
}
