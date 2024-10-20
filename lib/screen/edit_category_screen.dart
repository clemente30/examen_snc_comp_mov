import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../../providers/providers.dart';
import '../../services/services.dart';
import '../../widgets/widgets.dart';

class EditCategoryScreen extends StatelessWidget {
  const EditCategoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final categoryService = Provider.of<CategoryService>(context);
    return ChangeNotifierProvider(
        create: (_) => CategoryFormProvider(categoryService.selectProduct!),
        child: _CategoryScreenBody(
          categoryService: categoryService,
        ));
  }
}

class _CategoryScreenBody extends StatelessWidget {
  const _CategoryScreenBody({
    required this.categoryService,
  });

  final CategoryService categoryService;
  @override
  Widget build(BuildContext context) {
    final categoryForm = Provider.of<CategoryFormProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const UpperBar(
          screenName: "Editar categoría",
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: _CategoryForm(),
            ),
            GestureDetector(
              onTap: () async {
                if (!categoryForm.isValidForm()) return;
                await categoryService.editOrCreateCategory(
                    categoryForm.category, context);
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
                if (!categoryForm.isValidForm()) return;
                await categoryService.deleteCategory(
                    categoryForm.category, context);
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color.fromARGB(151, 233, 230, 234)),
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

class _CategoryForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categoryForm = Provider.of<CategoryFormProvider>(context);
    final category = categoryForm.category;
    return Form(
      key: categoryForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.text,
            initialValue: category.categoryName,
            decoration: InputDecoration(
              label: const Text("Nombre de la Categoría"),
              contentPadding: const EdgeInsets.all(16),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onChanged: (value) => category.categoryName = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Nombre inválido';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
