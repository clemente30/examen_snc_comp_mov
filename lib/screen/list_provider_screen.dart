import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/models.dart';
import '../../services/services.dart';
import '../../widgets/widgets.dart';
import 'package:examen_cm_snc/screen/screen.dart';

class ListProviderScreen extends StatelessWidget {
  const ListProviderScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final providerService = Provider.of<ProviderService>(context);
    if (providerService.isLoading) return const LoadingScreen();
    return Scaffold(
      appBar: AppBar(
        title: UpperBar(
            screenName: "Proveedores",
            child: GestureDetector(
              onTap: () {
                providerService.selectProduct = ProveedoresListado(
                    providerid: 0,
                    providerName: "Nombre",
                    providerLastName: "Apellido",
                    providerMail: "nombre.apellido@gmail.com",
                    providerState: "");
                Navigator.pushNamed(context, "editProvider");
              },
              child: const Icon(
                Icons.add,
                size: 24,
                color: Colors.white,
              ),
            )),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: (6 / 1),
              crossAxisCount: 1,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10),
          itemCount: providerService.providers.length,
          itemBuilder: (context, index) {
            final ProveedoresListado provider =
                providerService.providers[index];
            return GestureDetector(
              child: Container(
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 12),
                          child: Icon(Icons.person),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Text(
                              "${provider.providerName} ${provider.providerLastName}",
                              style: const TextStyle(fontSize: 14),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        const Expanded(child: Text("")),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            providerService.selectProduct = provider;
                            Navigator.pushNamed(context, "editProvider");
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
              onTap: () => Navigator.pushNamed(context, "provider",
                  arguments: {"provider": provider}),
            );
          },
        ),
      ),
    );
  }
}
