import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_principal/models/product.dart';

class ProductManager extends ChangeNotifier {
  ProductManager() {
    _loadAllProduct();
  }

  final Firestore firestore = Firestore.instance;

  List<Product> allProduct = [];

  String _search = '';
  get search => _search;

  set search(String value) {
    _search = value;
    notifyListeners();
  }

  List<Product> get filteredProducts {
    final List<Product> filteredProducts = [];
    if (search.isEmpty) {
      filteredProducts.addAll(allProduct);
    } else {
      filteredProducts.addAll(allProduct
          .where((p) => p.name.toLowerCase().contains(search.toLowerCase())));
    }
    return filteredProducts;
  }

  Future<void> _loadAllProduct() async {
    final QuerySnapshot snapProducts =
        await firestore.collection('products').getDocuments();

    allProduct =
        snapProducts.documents.map((d) => Product.fromDocument(d)).toList();

    notifyListeners();
  }

  Product findProductById(String id) {
    try {
      return allProduct.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  void update(Product product) {
    allProduct.removeWhere((p) => p.id == product.id);
    allProduct.add(product);
    notifyListeners();
  }
}
