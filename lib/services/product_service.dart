import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '/models/models.dart';

class ProductService extends ChangeNotifier {
  final String _baseUrl = '143.198.118.203:8100';
  final String _user = 'test';
  final String _pass = 'test2023';

  List<Listado> products = [];
  Listado? selectProduct;
  bool isLoading = true;
  bool isEditCreate = true;

  ProductService() {
    loadProducts();
  }

  Future loadProducts() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.http(
      _baseUrl,
      'ejemplos/product_list_rest/',
    );
    String basicAuth = 'Basic ${base64Encode(utf8.encode('$_user:$_pass'))}';
    final response = await http.get(url, headers: {'authorization': basicAuth});
    final productsMap = productFromJson(response.body);
    products = productsMap.listado;
    isLoading = false;
    notifyListeners();
  }

  Future editOrCreateProduct(Listado product, BuildContext context) async {
    isEditCreate = true;
    notifyListeners();
    if (product.productId == 0) {
      await createProduct(product, context);
    } else {
      await updateProduct(product, context);
    }
    isEditCreate = false;
    notifyListeners();
  }

  Future updateProduct(Listado product, BuildContext context) async {
    final url = Uri.http(
      _baseUrl,
      'ejemplos/product_edit_rest/',
    );
    String basicAuth = 'Basic ${base64Encode(utf8.encode('$_user:$_pass'))}';
    await http.post(url, body: json.encode(product.toJson()), headers: {
      'authorization': basicAuth,
      'Content-Type': 'application/json; charset=UTF-8',
    });
    if (!context.mounted) return;
    Navigator.of(context).pop();
  }

  Future createProduct(Listado product, BuildContext context) async {
    final url = Uri.http(
      _baseUrl,
      'ejemplos/product_add_rest/',
    );
    String basicAuth = 'Basic ${base64Encode(utf8.encode('$_user:$_pass'))}';
    await http.post(url, body: json.encode(product.toJson()), headers: {
      'authorization': basicAuth,
      'Content-type': 'application/json; charset=UTF-8',
    });
    products.clear();
    loadProducts();
    if (!context.mounted) return;
    Navigator.of(context).pop();
  }

  Future deleteProduct(Listado product, BuildContext context) async {
    final url = Uri.http(
      _baseUrl,
      'ejemplos/product_del_rest/',
    );
    String basicAuth = 'Basic ${base64Encode(utf8.encode('$_user:$_pass'))}';
    await http.post(url, body: json.encode(product.toJson()), headers: {
      'authorization': basicAuth,
      'Content-type': 'application/json; charset=UTF-8',
    });
    products.clear();
    loadProducts();
    if (!context.mounted) return;
    Navigator.of(context).pop();
  }
}
