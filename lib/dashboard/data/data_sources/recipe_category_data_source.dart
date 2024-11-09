import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myrecipediary/exception/http_exceptions.dart';
import 'package:myrecipediary/dashboard/domain/category.dart';

class RecipeCategoriesDataSource {
  static Future<ListOfCategoryModel> fetchCategories(
      ) async {
    try {

      String uri =
          "https://www.themealdb.com/api/json/v1/1/categories.php";

      final response = await http.get(Uri.parse(uri));

      print("CATEGORIES $response");
      final responseBody = jsonDecode(response.body);
      print(responseBody);
      if (response.statusCode == 200) {
        return ListOfCategoryModel.fromJson(
            responseBody
            // as Map<String, dynamic>
        );
      } else {
        print("Unabble to fetch data");
        throw  HttpException(
          'Unable to fetch currency data. Please wait after some times and try again.',
        );
      }
    } catch (e) {
      print("EXCEPTION ${e.toString()}");
      throw HttpException(e.toString());
    }
  }
}