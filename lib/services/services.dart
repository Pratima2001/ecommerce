import 'dart:async';

import 'package:dio/dio.dart';
import 'package:ecommerce1/data/models/category.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/productModule.dart';
import '../data/notifiers/searchNotifier.dart';
import '../data/providers/search.dart';

final listAProvider = FutureProvider<List<MainCategory>>((ref) async {
  return await getallCategories();
});
final allProducts = FutureProvider<List<Product>>((ref) async {
  return await getallProducts();
});

final futureProducts = FutureProvider<List<Product>>((ref) async {
  return await getfutureProducts();
});
final recommandedProducts = FutureProvider<List<Product>>((ref) async {
  return await getrecommandedProducts();
});

final categoryProductsProvider =
    FutureProvider.family<List<Product>, String>((ref, category) {
  return getallProductsByCatgory(category);
});

final searchProvider = StateNotifierProvider<SearchNotifier, SearchState>(
  (ref) => SearchNotifier(),
);

Future<List<MainCategory>> getallCategories() async {
  List<MainCategory> categories = [];
  final dio = Dio();
  final response =
      await dio.get("https://dummyjson.com/products/category-list");
  if (response.statusCode == 200) {
    List list = response.data;
    int id = 0;
    for (String prod in list) {
      id += 1;
      String url = "https://dummyjson.com/products/category/$prod";

      final catRes = await dio.get(url);

      if (catRes.statusCode == 200) {
        List data = catRes.data['products'];
        categories.add(MainCategory(
          id: id,
          name: "${prod[0].toUpperCase()}${prod.substring(1).toLowerCase()}",
          image: Product.fromMap(data[0]).images[0].toString(),
        ));
      }
    }
  }
  return categories;
}

Future<List<Product>> getallProducts() async {
  List<Product> products = [];
  final dio = Dio();
  final Response = await dio.get("https://dummyjson.com/products?limit=0");
  if (Response.statusCode == 200) {
    List data = Response.data['products'];
    for (Map<String, dynamic> prod in data) {
      products.add(Product.fromMap(prod));
    }
  }
  return products;
}

Future<List<Product>> getfutureProducts() async {
  List<Product> products = [];
  final dio = Dio();
  final Response =
      await dio.get("https://dummyjson.com/products?limit=10&skip=20");
  if (Response.statusCode == 200) {
    List data = Response.data['products'];
    for (Map<String, dynamic> prod in data) {
      products.add(Product.fromMap(prod));
    }
  }
  return products;
}

Future<List<Product>> getrecommandedProducts() async {
  List<Product> products = [];
  final dio = Dio();
  final Response =
      await dio.get("https://dummyjson.com/products?limit=50&skip=30");
  if (Response.statusCode == 200) {
    List data = Response.data['products'];
    for (Map<String, dynamic> prod in data) {
      products.add(Product.fromMap(prod));
    }
  }
  return products;
}

Future<List<Product>> getallProductsByCatgory(String category) async {
  List<Product> products = [];
  final dio = Dio();
  String url = "https://dummyjson.com/products/category/$category";

  final Response = await dio.get(url);

  if (Response.statusCode == 200) {
    List data = Response.data['products'];
    for (Map<String, dynamic> prod in data) {
      products.add(Product.fromMap(prod));
    }
  }

  return products;
}

Future<List<Product>> getSearchResult(String query) async {
  List<Product> products = [];
  final dio = Dio();
  String url = "https://dummyjson.com/products/search?q=$query";

  final Response = await dio.get(url);

  if (Response.statusCode == 200) {
    List data = Response.data['products'];
    for (Map<String, dynamic> prod in data) {
      products.add(Product.fromMap(prod));
    }
  }

  return products;
}
