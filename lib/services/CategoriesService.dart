import 'package:store_app/Models/ProductModel.dart';
import 'package:store_app/helper/api.dart';

class CategoriesService {
  Future<List<ProductModel>> getCategoriesProduct({
    required String category_name,
  }) async {
    List data = await Api().get(
      url: "https://fakestoreapi.com/products/category/$category_name",
      token: '',
    );
    List<ProductModel> productList = [];
    for (int i = 0; i < data.length; i++) {
      productList.add(ProductModel.fromJson(data[i]));
    }
    return productList;
  }
}
