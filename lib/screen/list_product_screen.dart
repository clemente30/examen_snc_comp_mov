import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../models/models.dart';
import '../../services/services.dart';
import '../../widgets/widgets.dart';
import 'package:examen_cm_snc/screen/screen.dart';

class ListProductScreen extends StatelessWidget {
  const ListProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);
    if (productService.isLoading) return const LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: UpperBar(
          screenName: "Productos",
          child: GestureDetector(
            onTap: () {
              productService.selectProduct = Listado(
                productId: 0,
                productName: "Producto",
                productPrice: 1000,
                productImage:
                    "https://abravidro.org.br/wp-content/uploads/2015/04/sem-imagem4.jpg",
                productState: "",
              );
              Navigator.pushNamed(context, "editProduct");
            },
            child: const Icon(
              Icons.add,
              size: 24,
              color: Colors.white,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: (1 / 2),
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemCount: productService.products.length,
          itemBuilder: (context, index) {
            final Listado product = productService.products[index];
            return GestureDetector(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(
                      height: 140,
                      child: Image(
                        image: NetworkImage(product.productImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Row(
                      children: [
                        const Expanded(child: Text("")),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            productService.selectProduct = product;
                            Navigator.pushNamed(context, "editProduct");
                          },
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          product.productName,
                          style: const TextStyle(fontSize: 14),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "\$${NumberFormat('#,###', 'es_CL').format(product.productPrice)}",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () => Navigator.pushNamed(context, "product",
                  arguments: {"product": product}),
            );
          },
        ),
      ),
    );
  }
}
