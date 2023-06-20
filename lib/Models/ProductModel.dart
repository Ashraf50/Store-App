class ProductModel {
  final int id;
  final String title;
  final price;
  final String description;
  final String image;
  final String Category;
  RatingModel ratingModel;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.ratingModel,
    required this.Category,
  });
  factory ProductModel.fromJson(jsonData) {
    return ProductModel(
      id: jsonData["id"],
      title: jsonData["title"],
      price: jsonData["price"],
      description: jsonData["description"],
      image: jsonData["image"],
      Category: jsonData["category"],
      ratingModel: RatingModel.fromJson(jsonData["rating"]),
    );
  }
}

class RatingModel {
  final rate;
  final int count;
  RatingModel({
    required this.rate,
    required this.count,
  });
  factory RatingModel.fromJson(jsonData) {
    return RatingModel(
      rate: jsonData["rate"],
      count: jsonData["count"],
    );
  }
}
