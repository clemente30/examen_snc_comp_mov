import 'package:examen_cm_snc/models/models.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProviderService extends ChangeNotifier {
  final String _baseUrl = '143.198.118.203:8100';
  final String _user = 'test';
  final String _pass = 'test2023';

  List<ProveedoresListado> providers = [];
  ProveedoresListado? selectProduct;
  bool isLoading = true;
  bool isEditCreate = true;

  ProviderService() {
    loadProviders();
  }

  Future loadProviders() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.http(
      _baseUrl,
      'ejemplos/provider_list_rest/',
    );
    String basicAuth = 'Basic ${base64Encode(utf8.encode('$_user:$_pass'))}';
    final response = await http.get(url, headers: {'authorization': basicAuth});
    final providersMap = providerFromJson(response.body);
    providers = providersMap.proveedoresListado;
    isLoading = false;
    notifyListeners();
  }

  Future editOrCreateProviders(
      ProveedoresListado provider, BuildContext context) async {
    isEditCreate = true;
    notifyListeners();
    if (provider.providerid == 0) {
      await createProvider(provider, context);
    } else {
      await updateProvider(provider, context);
    }
    isEditCreate = false;
    notifyListeners();
  }

  Future updateProvider(
      ProveedoresListado provider, BuildContext context) async {
    final url = Uri.http(
      _baseUrl,
      'ejemplos/provider_edit_rest/',
    );
    String basicAuth = 'Basic ${base64Encode(utf8.encode('$_user:$_pass'))}';
    await http.post(url, body: json.encode(provider.toJson()), headers: {
      'authorization': basicAuth,
      'Content-Type': 'application/json; charset=UTF-8',
    });
    if (!context.mounted) return;
    Navigator.of(context).pop();
  }

  Future createProvider(
      ProveedoresListado provider, BuildContext context) async {
    final url = Uri.http(
      _baseUrl,
      'ejemplos/provider_add_rest/',
    );
    String basicAuth = 'Basic ${base64Encode(utf8.encode('$_user:$_pass'))}';
    await http.post(url, body: json.encode(provider.toJson()), headers: {
      'authorization': basicAuth,
      'Content-type': 'application/json; charset=UTF-8',
    });
    providers.clear();
    loadProviders();
    if (!context.mounted) return;
    Navigator.of(context).pop();
  }

  Future deleteProvider(
      ProveedoresListado provider, BuildContext context) async {
    final url = Uri.http(
      _baseUrl,
      'ejemplos/provider_del_rest/',
    );
    String basicAuth = 'Basic ${base64Encode(utf8.encode('$_user:$_pass'))}';
    await http.post(url, body: json.encode(provider.toJson()), headers: {
      'authorization': basicAuth,
      'Content-type': 'application/json; charset=UTF-8',
    });
    providers.clear();
    loadProviders();
    if (!context.mounted) return;
    Navigator.of(context).pop();
  }
}
