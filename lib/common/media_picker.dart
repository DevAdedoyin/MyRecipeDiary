import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myrecipediary/dashboard/repository/ingredient_repo.dart';

import '../constants/colors.dart';

class MediaPickerWidget extends ConsumerStatefulWidget {
  final bool isImage;

  const MediaPickerWidget({required this.isImage, super.key});

  @override
  ConsumerState<MediaPickerWidget> createState() => _MediaPickerWidgetState();
}

class _MediaPickerWidgetState extends ConsumerState<MediaPickerWidget> {
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;

    final selectedImage_ = ref.watch(selectedImage);
    return ClipRRect(
      borderRadius: BorderRadius.circular(7),
      child: Container(
        width: size.width * 0.9,
        height: size.height * 0.2,
        color: Colors.grey.shade300,
        child: _selectedImage != null
            ? GestureDetector(
                onTap: () {
                  _pickImageFromGallery();
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: FileImage(_selectedImage!),
                    ),
                  ),
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                        widget.isImage
                            ? FontAwesomeIcons.camera
                            : FontAwesomeIcons.video,
                        color: AppColors.black,
                        size: 40),
                    onPressed: () {
                      _pickImageFromGallery();
                    },
                  ),
                  Text(
                    widget.isImage
                        ? "Select image(s)"
                        : "Select video(optional)",
                    style: GoogleFonts.roboto(
                        fontStyle: FontStyle.italic,
                        color: Colors.black54,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
      ),
    );
  }

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage == null) return;
    setState(() {
      _selectedImage = File(returnedImage.path);
      print("SELECTED IMAGE ${returnedImage.name}");
    });
    ref.read(selectedImage.notifier).state = returnedImage.name;
  }
}
