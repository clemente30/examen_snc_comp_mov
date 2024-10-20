import 'package:provider/provider.dart';
import '../providers/login_form_provider.dart';
import '../services/services.dart';
import 'package:flutter/material.dart';

class SimpleForm extends StatelessWidget {
  final bool isLogIn;
  final String route;

  const SimpleForm({super.key, required this.isLogIn, required this.route});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ChangeNotifierProvider(
        create: (_) => LoginFormProvider(),
        child: LoginForm(isLogIn: isLogIn, route: route),
      ),
    ]);
  }
}

class LoginForm extends StatelessWidget {
  final bool isLogIn;
  final String route;

  const LoginForm({super.key, required this.isLogIn, required this.route});

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Form(
      key: loginForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(children: [
        TextFormField(
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              label: const Text("Correo electrónico..."),
              contentPadding: const EdgeInsets.all(16),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              prefixIcon: const Icon(
                Icons.email_outlined,
                color: Color.fromARGB(255, 23, 235, 168),
              )),
          onChanged: (value) => loginForm.email = value,
          validator: (value) {
            return (value != null && value.length >= 6)
                ? null
                : "Correo inválido.";
          },
        ),
        const SizedBox(height: 50),
        TextFormField(
          autocorrect: false,
          keyboardType: TextInputType.text,
          obscureText: true,
          decoration: InputDecoration(
              label: const Text("Contraseña..."),
              contentPadding: const EdgeInsets.all(16),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              prefixIcon: const Icon(
                Icons.key_off_outlined,
                color: Color.fromARGB(255, 23, 235, 168),
              )),
          onChanged: (value) => loginForm.password = value,
          validator: (value) {
            return (value != null && value.length >= 4)
                ? null
                : 'Contraseña no válida';
          },
        ),
        const SizedBox(height: 50),
        MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          disabledColor: const Color.fromARGB(255, 218, 26, 26),
          color: const Color.fromARGB(255, 23, 235, 168),
          elevation: 0,
          onPressed: loginForm.isLoading
              ? null
              : () async {
                  FocusScope.of(context).unfocus();
                  final authService =
                      Provider.of<AuthService>(context, listen: false);

                  if (!loginForm.isValidForm()) return;

                  loginForm.isLoading = true;

                  if (isLogIn) {
                    final String? idToken = await authService.login(
                        loginForm.email, loginForm.password);
                    if (idToken != null) {
                      if (!context.mounted) return;
                      Navigator.pushNamed(context, route,
                          arguments: {"idToken": idToken});
                    }
                  } else {
                    final String? idToken = await authService.register(
                        loginForm.email, loginForm.password);
                    if (idToken != null) {
                      if (!context.mounted) return;
                      Navigator.pushNamed(context, route,
                          arguments: {"idToken": idToken});
                    }
                  }

                  loginForm.isLoading = false;
                },
          child: Container(
            width: 200,
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: loginForm.isLoading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : const Text(
                    'Continuar',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
          ),
        ),
        const SizedBox(height: 12),
      ]),
    );
  }
}
