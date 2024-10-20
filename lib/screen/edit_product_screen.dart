import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/providers.dart';
import '../../services/services.dart';
import '../../widgets/widgets.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);
    return ChangeNotifierProvider(
        create: (_) => ProductFormProvider(productService.selectProduct!),
        child: _ProductScreenBody(
          productService: productService,
        ));
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    required this.productService,
  });

  final ProductService productService;
  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const UpperBar(
          screenName: "Editar producto",
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: Column(children: [
            SizedBox(
              height: 300,
              child: Image(
                image: NetworkImage(productService.selectProduct!.productImage),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: _ProductForm(),
            ),
            GestureDetector(
              onTap: () async {
                if (!productForm.isValidForm()) return;
                await productService.editOrCreateProduct(
                    productForm.product, context);
                if (!context.mounted) return;
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color.fromARGB(255, 23, 235, 168)),
                child: const Text(
                  "Guardar",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            GestureDetector(
              onTap: () async {
                if (!productForm.isValidForm()) return;
                await productService.deleteProduct(
                    productForm.product, context);
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color.fromARGB(255, 213, 212, 214)),
                child: const Text(
                  "Eliminar",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 23, 235, 168)),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;
    return Form(
      key: productForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.text,
            initialValue: product.productName,
            decoration: InputDecoration(
              label: const Text("Nombre de Producto"),
              contentPadding: const EdgeInsets.all(16),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onChanged: (value) => product.productName = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Nombre inválido';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            keyboardType: TextInputType.number,
            initialValue: product.productPrice.toString(),
            decoration: InputDecoration(
              label: const Text("Valor"),
              contentPadding: const EdgeInsets.all(16),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onChanged: (value) {
              if (int.tryParse(value) == null) {
                product.productPrice = 0;
              } else {
                product.productPrice = int.parse(value);
              }
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            keyboardType: TextInputType.url,
            initialValue: product.productImage,
            decoration: InputDecoration(
              label: const Text("Dirección Url de la imagen"),
              contentPadding: const EdgeInsets.all(16),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onChanged: (value) => product.productImage = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Dirección Url inválida';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
