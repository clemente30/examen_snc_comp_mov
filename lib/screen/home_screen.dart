import 'package:flutter/material.dart';
import '/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<List<dynamic>> screens = [
      [
        "Productos",
        "listProduct",
      ],
      [
        "Categorías",
        "listCategory",
      ],
      [
        "Proveedores",
        "listProvider",
      ],
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const UpperBar(
          screenName: "Welcome to the jungle Otaku",
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(22),
        color: const Color.fromARGB(255, 27, 142, 14),
        child: ListView.builder(
          itemCount: screens.length,
          itemBuilder: (context, index) {
            final screen = screens[index];
            return ListTile(
              title: Text(screen[0]),
              trailing: const Icon(Icons.navigate_next),
              onTap: () => Navigator.pushNamed(context, screen[1]),
            );
          },
        ),
      ),
    );
  }
}
