// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:store_app/Models/ProductModel.dart';

class Cart with ChangeNotifier {
  // create new properties & methods
  List selectedProduct = [];
  double price = 0;

  add(ProductModel product) {
    selectedProduct.add(product);
    price += product.price.round();
    notifyListeners();
  }

  delete(ProductModel product) {
    selectedProduct.remove(product);
    price -= product.price.round();
    notifyListeners();
  }
}

class Favorite with ChangeNotifier {
  // create new properties & methods
  List selectedProduct = [];
  add(ProductModel product) {
    selectedProduct.add(product);
    notifyListeners();
  }

  bool IsSelected(ProductModel product) {
    final isSelected = selectedProduct.contains(product);
    return isSelected;
    // notifyListeners();
  }

  delete(ProductModel product) {
    selectedProduct.remove(product);
    notifyListeners();
  }
}
