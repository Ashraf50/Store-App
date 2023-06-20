import 'package:store_app/helper/api.dart';

class AllCategories {
  Future<List> getAllCategories() async {
    List data = await Api().get(
      url: "https://fakestoreapi.com/products/categories",
      token: '',
    );
    return data;
  }
}
