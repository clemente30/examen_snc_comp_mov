import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:examen_cm_snc/widgets/widgets.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
        screenName: "",
        backgroundColor: Colors.white,
        statusBarColor: Color.fromARGB(255, 23, 235, 168),
        showBackButton: false,
      ),
      body: Container(
        color: Colors.white,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
