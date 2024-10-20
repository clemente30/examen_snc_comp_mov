import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = "AIzaSyBmAVJe92z1axwfgfAjaMO9czuseLnRD-w";

  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      "email": email,
      "password": password,
    };
    final url = Uri.https(
        _baseUrl, "/v1/accounts:signInWithPassword", {"key": _firebaseToken});
    final response = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedResponse = json.decode(response.body);
    if (decodedResponse.containsKey("idToken")) {
      return decodedResponse["idToken"];
    } else {
      return null;
    }
  }

  Future<String?> register(String email, String password) async {
    final Map<String, dynamic> authData = {
      "email": email,
      "password": password,
    };
    final url =
        Uri.https(_baseUrl, "/v1/accounts:signUp", {"key": _firebaseToken});
    final response = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedResponse = json.decode(response.body);
    if (decodedResponse.containsKey("idToken")) {
      return decodedResponse["idToken"];
    } else {
      return null;
    }
  }
}
