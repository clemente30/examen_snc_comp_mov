import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  List<ListadoCategoria> listadoCategorias;

  Category({
    required this.listadoCategorias,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        listadoCategorias: List<ListadoCategoria>.from(
            json["Listado Categorias"]
                .map((x) => ListadoCategoria.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Listado Categorias":
            List<dynamic>.from(listadoCategorias.map((x) => x.toJson())),
      };
}

class ListadoCategoria {
  int categoryId;
  String categoryName;
  String categoryState;

  ListadoCategoria({
    required this.categoryId,
    required this.categoryName,
    required this.categoryState,
  });

  factory ListadoCategoria.fromJson(Map<String, dynamic> json) =>
      ListadoCategoria(
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        categoryState: json["category_state"],
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "category_name": categoryName,
        "category_state": categoryState,
      };
}
