class CategoryModel {
  final String idCategory;
  final String strCategory;
  final String strCategoryThumb;
  final String strCategoryDescription;

  CategoryModel(
      {required this.idCategory,
      required this.strCategory,
      required this.strCategoryDescription,
      required this.strCategoryThumb});

  factory CategoryModel.fromJson(Map<String, dynamic> data) {
    final idCategory = data["idCategory"] as String;
    final strCategory = data["strCategory"] as String;
    final strCategoryThumb = data["strCategoryThumb"] as String;
    final strCategoryDescription = data["strCategoryDescription"] as String;

    return CategoryModel(
        idCategory: idCategory,
        strCategory: strCategory,
        strCategoryThumb: strCategoryThumb,
        strCategoryDescription: strCategoryDescription);
  }
}

class ListOfCategoryModel {
  final List<CategoryModel> listOfCategoryModel;

  ListOfCategoryModel({required this.listOfCategoryModel});

  factory ListOfCategoryModel.fromJson(Map<String, dynamic> data) {
    final listOfCategoryModel = data["categories"] as List<dynamic>;
    List<Map<String, dynamic>> listOfCategoryModelData =
        listOfCategoryModel.cast<Map<String, dynamic>>();

    final List<CategoryModel> categories =
    listOfCategoryModelData.map((cat) => CategoryModel.fromJson(cat)).toList();

    return ListOfCategoryModel(listOfCategoryModel: categories);
  }
}
