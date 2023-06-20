import 'package:store_app/Models/ProductModel.dart';
import '../helper/api.dart';

class AllProduct {
  Future<List<ProductModel>> getAllProduct() async {
    List data = await Api().get(
      url: "https://fakestoreapi.com/products",
      token: '',
    );
    List<ProductModel> ProductList = [];
    for (int i = 0; i < data.length; i++) {
      ProductList.add(ProductModel.fromJson(data[i]));
    }
    return ProductList;
  }
}
