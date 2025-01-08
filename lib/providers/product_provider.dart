import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product.dart';
import 'dart:convert';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products => _products;

  ProductProvider() {
    _loadProducts();
  }

  // Mengambil data produk dari SharedPreferences
  Future<void> _loadProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final productData = prefs.getString('products');
    if (productData != null) {
      List<dynamic> decodedData = json.decode(productData);
      _products = decodedData
          .map((item) => Product.fromMap(item))
          .toList();
      notifyListeners();
    }
  }

  // Menyimpan data produk ke SharedPreferences
  Future<void> _saveProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedData = json.encode(_products.map((product) => product.toMap()).toList());
    prefs.setString('products', encodedData);
  }

  // Menambahkan produk baru
  void addProduct(Product product) {
    _products.add(product);
    _saveProducts();
    notifyListeners();
  }

  // Mengupdate produk yang sudah ada
  void updateProduct(int index, Product updatedProduct) {
    _products[index] = updatedProduct;
    _saveProducts();
    notifyListeners();
  }

  // Menghapus produk
  void deleteProduct(int index) {
    _products.removeAt(index);
    _saveProducts();
    notifyListeners();
  }
}