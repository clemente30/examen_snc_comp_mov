import 'package:flutter/material.dart';
import '/widgets/widgets.dart';

class LoginEmailScreen extends StatelessWidget {
  const LoginEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
        screenName: "Iniciar Sesión Kyoudaisan",
        backgroundColor: Color.fromARGB(255, 23, 235, 168),
        statusBarColor: Color.fromARGB(255, 23, 235, 168),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 24),
                child: Text(
                  "Ingrese sus datos rápido y no muera en el intento.",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: SimpleForm(
                  isLogIn: true,
                  route: "home",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
