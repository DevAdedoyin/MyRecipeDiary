import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myrecipediary/common/app_alert_dialog.dart';
import 'package:myrecipediary/common/gaps.dart';
import 'package:myrecipediary/common/media_picker.dart';
import 'package:myrecipediary/constants/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myrecipediary/constants/font_sizes.dart';
import 'package:myrecipediary/constants/gaps.dart';
import 'package:myrecipediary/utils/validators/meal_input_validators.dart';

import '../../../common/text_form_field.dart';
// import 'package:video_player/video_player.dart';

class AddRecipeTab extends ConsumerStatefulWidget {
  const AddRecipeTab({super.key});

  @override
  ConsumerState<AddRecipeTab> createState() => _AddRecipeTabState();
}

class _AddRecipeTabState extends ConsumerState<AddRecipeTab> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    final _mealNameController = TextEditingController();
    final _mealCategoryController = TextEditingController();
    final _mealIngredientsController = TextEditingController();
    final _mealStepsController = TextEditingController();

    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    int maxFileSizeInMB = 100;

    String? _selectedVideoPath;
    String? _errorMessage =
        "The selected video is too large. Maximum size allowed: $maxFileSizeInMB MB.";

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
        AppAlertDialog.failedAlert(
            title: "Error", message: _errorMessage!);
      }
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
              onPressed: () {},
              child: Text(
                "Submit recipe",
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.black)),
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
                verticalGap(size.height * 0.02),
                Container(
                    width: size.width * 0.9,
                    padding:
                        EdgeInsets.symmetric(horizontal: Gaps.extraSmallGap),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(7)),
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                          child: Text(
                            _selectedVideoPath == null
                                ? "Select video"
                                : _selectedVideoPath!,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )),
                        IconButton(
                            onPressed: _pickVideo,
                            icon: Icon(FontAwesomeIcons.video)),
                      ],
                    )),
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
                verticalGap(size.height * 0.03),
                SizedBox(
                    width: size.width * 0.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: size.width * 0.6,
                          child: TextFormField_.textFormField(
                              prefixIcon: const Icon(
                                Icons.category,
                                color: AppColors.secondaryColor,
                              ),
                              controller: _mealIngredientsController,
                              // textInputType: TextInputType.emailAddress,
                              suffixIcon: GestureDetector(
                                  onTap: () {}, child: Icon(Icons.send)),
                              hint: " Add Ingredient",
                              // validator: (email) =>
                              //     MealInputValidators.validateMealInput(
                              //         text: _mealCategoryController.text),
                              isObscured: false,
                              textInputAction: TextInputAction.next),
                        ),
                        SizedBox(
                          width: size.width * 0.3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.remove_circle)),
                              Text("1"),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.add_circle_rounded)),
                            ],
                          ),
                        )
                      ],
                    )),
                verticalGap(size.height * 0.03),
                SizedBox(
                  width: size.width * 0.9,
                  child: TextFormField_.textFormField(
                      prefixIcon: const Icon(
                        FontAwesomeIcons.sort,
                        color: AppColors.secondaryColor,
                      ),
                      maxLines: 5,
                      controller: _mealStepsController,
                      // textInputType: TextInputType.emailAddress,
                      hint: "Meal steps (Step 1)",
                      validator: (email) =>
                          MealInputValidators.validateMealInput(
                              text: _mealCategoryController.text),
                      isObscured: false,
                      suffixIcon: GestureDetector(
                          onTap: () {}, child: Icon(Icons.send)),
                      textInputAction: TextInputAction.next),
                ),
                verticalGap(size.height * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
