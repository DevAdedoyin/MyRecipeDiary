import 'package:flutter_riverpod/flutter_riverpod.dart';

final numberOfIngredients = StateProvider<int>((ref) => 0);

final ingredients = StateProvider<Map<String, dynamic>>((ref) => {});
final ingredientsMeasure = StateProvider<Map<String, dynamic>>((ref) => {});

final selectedImage = StateProvider<String>((ref) => "");

final strIngredient = StateProvider<List<String>>((ref) => []);
final strMeasure = StateProvider<List<String>>((ref) => []);
