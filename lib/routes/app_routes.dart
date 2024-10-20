import 'package:flutter/material.dart';
import '/screen/screen.dart';

class AppRoutes {
  static const initialRoute = 'login';

  static Map<String, Widget Function(BuildContext)> routes = {
    'home': (BuildContext context) => const HomeScreen(),
    'login': (BuildContext context) => const LoginScreen(),
    'loginEmail': (BuildContext context) => const LoginEmailScreen(),
    'registerEmail': (BuildContext context) => const RegisterEmailScreen(),
    'loading': (BuildContext context) => const ProductScreen(),
    'listProduct': (BuildContext context) => const ListProductScreen(),
    'listCategory': (BuildContext context) => const ListCategoryScreen(),
    'listProvider': (BuildContext context) => const ListProviderScreen(),
    'product': (BuildContext context) => const ProductScreen(),
    'category': (BuildContext context) => const CategoryScreen(),
    'provider': (BuildContext context) => const ProviderScreen(),
    'editProduct': (BuildContext context) => const EditProductScreen(),
    'editCategory': (BuildContext context) => const EditCategoryScreen(),
    'editProvider': (BuildContext context) => const EditProviderScreen(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => const ErrorScreen());
  }
}
