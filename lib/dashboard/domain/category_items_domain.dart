class CategoryItemsModel {
  final String strMeal;
  final String strMealThumb;
  final String idMeal;

  CategoryItemsModel({
    required this.strMeal,
    required this.strMealThumb,
    required this.idMeal,
  });

  factory CategoryItemsModel.fromJson(Map<String, dynamic> data) {
    final strMeal = data["strMeal"] as String;
    final strMealThumb = data["strMealThumb"] as String;
    final idMeal = data["idMeal"] as String;

    return CategoryItemsModel(
      strMeal: strMeal,
      strMealThumb: strMealThumb,
      idMeal: idMeal,
    );
  }
}

class ListOfCategoryModelItems {
  final List<CategoryItemsModel> listOfCategoryItemsModel;

  ListOfCategoryModelItems({required this.listOfCategoryItemsModel});

  factory ListOfCategoryModelItems.fromJson(Map<String, dynamic> data) {
    final listOfCategoryItemsModel = data["meals"] as List<dynamic>;
    List<Map<String, dynamic>> listOfCategoryModelData =
        listOfCategoryItemsModel.cast<Map<String, dynamic>>();

    final List<CategoryItemsModel> meals = listOfCategoryModelData
        .map((cat) => CategoryItemsModel.fromJson(cat))
        .toList();

    return ListOfCategoryModelItems(listOfCategoryItemsModel: meals);
  }
}
