import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "ありがとうございます",
            style: TextStyle(
                fontSize: 22, color: Color.fromARGB(255, 255, 255, 255)),
          ),
        ),
        automaticallyImplyLeading: false,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Color.fromARGB(255, 23, 235, 168)),
        backgroundColor: const Color.fromARGB(255, 23, 235, 168),
      ),
      body: Stack(
        children: [
          // Círculos en el fondo
          Positioned(
            top: -100,
            left: -100,
            child: CircleAvatar(
              radius: 150,
              backgroundColor: Colors.green.withOpacity(0.2),
            ),
          ),
          Positioned(
            bottom: -150,
            right: -150,
            child: CircleAvatar(
              radius: 180,
              backgroundColor: Colors.greenAccent.withOpacity(0.2),
            ),
          ),
          Positioned(
            top: 100,
            right: -80,
            child: CircleAvatar(
              radius: 100,
              backgroundColor: Colors.cyanAccent.withOpacity(0.2),
            ),
          ),
          // Contenido de la pantalla
          SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: Colors.white.withOpacity(0), // Fondo transparente
              child: Column(
                children: [
                  // Contenedor con el título de Ventas Varias
                  Container(
                    height: 400,
                    padding: const EdgeInsets.symmetric(vertical: 130),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 27, 142, 14),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(22)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          "Ventas Varias",
                          style: TextStyle(
                            fontSize: 30,
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Botón de registro
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: GestureDetector(
                      onTap: () => Navigator.pushNamed(context, "registerEmail",
                          arguments: {"first": true}),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color.fromARGB(255, 23, 235, 168),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: const Text(
                          "Crea una nueva cuenta Aquí --->",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),

                  // Botón de inicio de sesión
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, "loginEmail",
                        arguments: {"first": true}),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color.fromARGB(255, 27, 142, 14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: const Text(
                        "Inicia Sesión",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
