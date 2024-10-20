import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '/models/models.dart';

class CategoryService extends ChangeNotifier {
  final String _baseUrl = '143.198.118.203:8100';
  final String _user = 'test';
  final String _pass = 'test2023';

  List<ListadoCategoria> categories = [];
  ListadoCategoria? selectProduct;
  bool isLoading = true;
  bool isEditCreate = true;

  CategoryService() {
    loadCategories();
  }
  Future loadCategories() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.http(
      _baseUrl,
      'ejemplos/category_list_rest/',
    );
    String basicAuth = 'Basic ${base64Encode(utf8.encode('$_user:$_pass'))}';
    final response = await http.get(url, headers: {'authorization': basicAuth});
    final productsMap = categoryFromJson(response.body);
    categories = productsMap.listadoCategorias;
    isLoading = false;
    notifyListeners();
  }

  Future editOrCreateCategory(
      ListadoCategoria category, BuildContext context) async {
    isEditCreate = true;
    notifyListeners();
    if (category.categoryId == 0) {
      await createCategory(category, context);
    } else {
      await updateCategory(category, context);
    }
    isEditCreate = false;
    notifyListeners();
  }

  Future updateCategory(ListadoCategoria category, BuildContext context) async {
    final url = Uri.http(
      _baseUrl,
      'ejemplos/category_edit_rest/',
    );
    String basicAuth = 'Basic ${base64Encode(utf8.encode('$_user:$_pass'))}';
    await http.post(url, body: json.encode(category.toJson()), headers: {
      'authorization': basicAuth,
      'Content-Type': 'application/json; charset=UTF-8',
    });
    if (!context.mounted) return;
    Navigator.of(context).pop();
  }

  Future createCategory(ListadoCategoria category, BuildContext context) async {
    final url = Uri.http(
      _baseUrl,
      'ejemplos/category_add_rest/',
    );
    String basicAuth = 'Basic ${base64Encode(utf8.encode('$_user:$_pass'))}';
    await http.post(url, body: json.encode(category.toJson()), headers: {
      'authorization': basicAuth,
      'Content-type': 'application/json; charset=UTF-8',
    });
    categories.clear();
    loadCategories();
    if (!context.mounted) return;
    Navigator.of(context).pop();
  }

  Future deleteCategory(ListadoCategoria category, BuildContext context) async {
    final url = Uri.http(
      _baseUrl,
      'ejemplos/category_del_rest/',
    );
    String basicAuth = 'Basic ${base64Encode(utf8.encode('$_user:$_pass'))}';
    await http.post(url, body: json.encode(category.toJson()), headers: {
      'authorization': basicAuth,
      'Content-type': 'application/json; charset=UTF-8',
    });
    categories.clear();
    loadCategories();
    if (!context.mounted) return;
    Navigator.of(context).pop();
  }
}
