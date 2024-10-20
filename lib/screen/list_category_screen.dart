import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/models.dart';
import '../../services/services.dart';
import '../../widgets/widgets.dart';
import 'package:examen_cm_snc/screen/screen.dart';

class ListCategoryScreen extends StatelessWidget {
  const ListCategoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final categoryService = Provider.of<CategoryService>(context);
    if (categoryService.isLoading) return const LoadingScreen();
    return Scaffold(
        appBar: AppBar(
          title: UpperBar(
              screenName: "Categorías",
              child: GestureDetector(
                onTap: () {
                  categoryService.selectProduct = ListadoCategoria(
                      categoryId: 0,
                      categoryName: "Categoría",
                      categoryState: "");
                  Navigator.pushNamed(context, "editCategory");
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
              itemCount: categoryService.categories.length,
              itemBuilder: (context, index) {
                final ListadoCategoria category =
                    categoryService.categories[index];
                return GestureDetector(
                  child: Container(
                    width: double.infinity,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: Text(
                                  category.categoryName,
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
                                categoryService.selectProduct = category;
                                Navigator.pushNamed(context, "editCategory");
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  onTap: () => Navigator.pushNamed(context, "category",
                      arguments: {"category": category}),
                );
              },
            )));
  }
}
