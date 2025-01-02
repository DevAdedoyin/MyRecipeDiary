import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myrecipediary/common/alert_dialogs/error_alert_dialog.dart';
import 'package:myrecipediary/common/app_alert_dialog.dart';
import 'package:myrecipediary/common/elevated_button.dart';
import 'package:myrecipediary/common/gaps.dart';
import 'package:myrecipediary/common/media_picker.dart';
import 'package:myrecipediary/constants/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myrecipediary/constants/font_sizes.dart';
import 'package:myrecipediary/constants/gaps.dart';
import 'package:myrecipediary/utils/validators/meal_input_validators.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../common/alert_dialogs/info_alert_dialog.dart';
import '../../../common/alert_dialogs/success_alert_dialog.dart';
import '../../../common/text_form_field.dart';
import '../../repository/ingredient_repo.dart';
// import 'package:video_player/video_player.dart';

class AddRecipeTab extends ConsumerStatefulWidget {
  const AddRecipeTab({super.key});

  @override
  ConsumerState<AddRecipeTab> createState() => _AddRecipeTabState();
}

class _AddRecipeTabState extends ConsumerState<AddRecipeTab> {
  int maxFileSizeInMB = 100;

  String? _selectedVideoPath;
  String? _errorMessage =
      "The selected video is too large. Maximum size allowed: 100MB.";

  int initialIngredient = 0;

  // List<String> strIngredient = [];
  // List<String> strMeasure = [];

  final _formKey = GlobalKey<FormState>();

  final _mealNameController = TextEditingController();
  final _mealCategoryController = TextEditingController();
  final _mealIngredientsController = TextEditingController();
  final _mealStepsController = TextEditingController();
  final _ingredientController = TextEditingController();
  final _ingredientQuantityController = TextEditingController();

  User? user;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;

    final numberOfIngredients_ = ref.watch(numberOfIngredients);
    final ingredients_ = ref.watch(ingredients);
    final ingredientsMeasure_ = ref.watch(ingredientsMeasure);
    final strIngredient_ = ref.watch(strIngredient);
    final strMeasure_ = ref.watch(strMeasure);
    final selectedImage_ = ref.watch(selectedImage);

    CollectionReference users_ = FirebaseFirestore.instance.collection("meals");

    clearData() {
      ref.read(selectedImage.notifier).state = "";
      ref.read(strIngredient.notifier).state.clear();
      ref.read(strMeasure.notifier).state.clear();
      _mealStepsController.clear();
      _mealCategoryController.clear();
      _mealNameController.clear();
      _ingredientQuantityController.clear();
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Create recipe",
          style: GoogleFonts.roboto(
              color: Colors.white, fontSize: FontSizes.mediumFont),
        ),
        backgroundColor: AppColors.secondaryColor,
        actions: [
          Container(
            margin: EdgeInsets.only(right: Gaps.smallGap),
            child: TextButton(
              onPressed: clearData,
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.black)),
              child: const Text(
                "Clear recipe form",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
      body: SizedBox(
        width: size.width,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                verticalGap(size.height * 0.02),
                const MediaPickerWidget(isImage: true),
                // verticalGap(size.height * 0.02),
                // Container(
                //     width: size.width * 0.9,
                //     padding:
                //         EdgeInsets.symmetric(horizontal: Gaps.extraSmallGap),
                //     decoration: BoxDecoration(
                //         border: Border.all(
                //           color: Colors.black,
                //         ),
                //         borderRadius: BorderRadius.circular(7)),
                //     child: Row(
                //       children: [
                //         Expanded(
                //             child: Container(
                //           child: Text(
                //             _selectedVideoPath == null
                //                 ? "Select video"
                //                 : _selectedVideoPath!,
                //             overflow: TextOverflow.ellipsis,
                //           ),
                //         )),
                //         IconButton(
                //             onPressed: _pickVideo,
                //             icon: const Icon(FontAwesomeIcons.video)),
                //       ],
                //     )),
                verticalGap(size.height * 0.03),
                SizedBox(
                  width: size.width * 0.9,
                  child: TextFormField_.textFormField(
                      prefixIcon: const Icon(
                        Icons.set_meal_rounded,
                        color: AppColors.secondaryColor,
                      ),
                      controller: _mealNameController,
                      // textInputType: TextInputType.emailAddress,
                      hint: "Meal name",
                      validator: (email) =>
                          MealInputValidators.validateMealInput(
                              text: _mealNameController.text),
                      isObscured: false,
                      textInputAction: TextInputAction.next),
                ),
                verticalGap(size.height * 0.03),
                SizedBox(
                  width: size.width * 0.9,
                  child: TextFormField_.textFormField(
                      prefixIcon: const Icon(
                        Icons.category,
                        color: AppColors.secondaryColor,
                      ),
                      controller: _mealCategoryController,
                      // textInputType: TextInputType.emailAddress,
                      hint: "Meal category",
                      validator: (email) =>
                          MealInputValidators.validateMealInput(
                              text: _mealCategoryController.text),
                      isObscured: false,
                      textInputAction: TextInputAction.next),
                ),
                verticalGap(size.height * 0.02),
                strIngredient_.isEmpty
                    ? const SizedBox()
                    : SizedBox(
                        child: Column(
                          children: List.generate(
                            strIngredient_.length,
                            (index) => Card(
                              elevation: 5,
                              margin: EdgeInsets.symmetric(
                                  horizontal: Gaps.bigMediumGap, vertical: 8),
                              child: ListTile(
                                dense: true,
                                title: Text(strIngredient_[index]),
                                subtitle: Text(strMeasure_[index]),
                                trailing: IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {},
                                ),
                                onTap: () {},
                              ),
                            ),
                          ),
                        ),
                      ),
                verticalGap(size.height * 0.02),
                SizedBox(
                    width: size.width * 0.92,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: size.width * 0.5,
                          child: TextFormField_.textFormField(
                              controller: _mealIngredientsController,
                              hint: "Add Ingredient",
                              isObscured: false,
                              textInputAction: TextInputAction.next),
                        ),
                        SizedBox(
                          width: size.width * 0.39,
                          child: TextFormField_.textFormField(
                            controller: _ingredientQuantityController,
                            hint: "Ingredient Qty",
                            isObscured: false,
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                      ],
                    )),
                verticalGap(size.height * 0.01),
                SizedBox(
                  child: ElevatedButton(
                      onPressed: () {
                        String strIngredient_ = "strIngredient";
                        String strMeasure_ = "strMeasure";
                        print("object");
                        if (_mealIngredientsController.text.isNotEmpty &&
                            _ingredientQuantityController.text.isNotEmpty) {
                          ref
                              .read(strIngredient.notifier)
                              .state
                              .add(_mealIngredientsController.text);
                          ref
                              .read(strMeasure.notifier)
                              .state
                              .add(_ingredientQuantityController.text);
                          ref.read(numberOfIngredients.notifier).state++;
                          strIngredient_ += numberOfIngredients_.toString();
                          strMeasure_ += numberOfIngredients_.toString();
                          ref.read(ingredients.notifier).state[strIngredient_] =
                              _mealIngredientsController.text;
                          ref
                                  .read(ingredientsMeasure.notifier)
                                  .state[strMeasure_] =
                              _ingredientQuantityController.text;
                          print("STR TEST");
                          print(ref.read(ingredients.notifier).state);
                          print(ref.read(ingredientsMeasure.notifier).state);
                          _mealIngredientsController.clear();
                          _ingredientQuantityController.clear();
                        } else if ((_mealIngredientsController.text.isEmpty &&
                                _ingredientQuantityController
                                    .text.isNotEmpty) ||
                            (_mealIngredientsController.text.isNotEmpty &&
                                _ingredientQuantityController.text.isEmpty)) {
                          infoAuthAlertWidget(
                              context,
                              "You must enter both the ingredients and their quantities.",
                              "Input Requirements Notice", onTap: () {
                            context.pop();
                          });
                        } else {
                          infoAuthAlertWidget(
                              context,
                              "You must enter both the ingredients and their quantities.",
                              "Input Requirements Notice", onTap: () {
                            context.pop();
                          });
                        }
                      },
                      style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              AppColors.secondaryColor)),
                      child: const Text(
                        "Add Ingredient",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                verticalGap(size.height * 0.03),
                SizedBox(
                  width: size.width * 0.9,
                  child: TextFormField_.textFormField(
                      maxLines: 10,
                      controller: _mealStepsController,
                      // textInputType: TextInputType.emailAddress,
                      hint: "Enter the steps in preparing the meal here",
                      isObscured: false,
                      textInputAction: TextInputAction.next),
                ),
                verticalGap(size.height * 0.02),
                elevatedButton(
                    onPressed: () {
                      if (ref.read(selectedImage.notifier).state.isEmpty) {
                        return infoAuthAlertWidget(
                          context,
                          "Image upload is required. Please select and upload an image before proceeding",
                          "Recipe Submission Requirement",
                        );
                      }
                      if (_mealNameController.text.isEmpty ||
                          _mealCategoryController.text.isEmpty ||
                          _mealStepsController.text.isEmpty) {
                        infoAuthAlertWidget(
                            context,
                            "Please ensure that you enter the meal name, meal category, and preparation steps for your recipe.",
                            "Recipe Submission Requirements", onTap: () {
                          context.pop();
                        });
                      } else {
                        final user = FirebaseAuth.instance.currentUser;
                        String? uid = user?.uid;
                        CollectionReference recipesRef = FirebaseFirestore
                            .instance
                            .collection('users')
                            .doc(uid)
                            .collection('recipes');
                        recipesRef.add({
                          "strMeal": _mealNameController.text,
                          "strCategory": _mealCategoryController.text,
                          "strInstructions": _mealStepsController.text,
                          "strMealThumb": selectedImage_,
                          ...ref.read(ingredients.notifier).state,
                          ...ref.read(ingredientsMeasure.notifier).state,
                          "isFavorite": false,
                          'createdAt': FieldValue.serverTimestamp(),
                          // "strMealThumb	":
                        }).then((value) {
                          clearData();
                          successAlertWidget(
                              context,
                              "Your recipe has been successfully submitted",
                              "Recipe Submitted", onTap: () {
                            context.pop();
                          });
                        }).catchError((error) {
                          errorAlertWidget(
                              context, error, "Recipe Submission Unsuccessful");
                        });
                      }
                    },
                    text: "Submit Your Recipe",
                    width: size.width * 0.85)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickVideo() async {
    try {
      // Open file picker for video files
      final result = await FilePicker.platform.pickFiles(
        type: FileType.video,
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;
        final fileSizeInMB = file.size / (1024 * 1024);

        if (fileSizeInMB > maxFileSizeInMB) {
          setState(() {
            _selectedVideoPath = null;
          });
          AppAlertDialog.failedAlert(
              title: "File Too Large", message: _errorMessage!);
        } else {
          setState(() {
            _selectedVideoPath = file.path;
            _errorMessage = null;
          });
        }
      }
    } catch (e) {
      setState(() {
        _errorMessage = "An error occurred: ${e.toString()}";
      });
      AppAlertDialog.failedAlert(title: "Error", message: _errorMessage!);
    }
  }
}
