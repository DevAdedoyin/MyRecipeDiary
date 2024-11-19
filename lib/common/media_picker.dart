import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../constants/colors.dart';

class MediaPickerWidget extends StatefulWidget {
  final bool isImage;

  const MediaPickerWidget({required this.isImage, super.key});

  @override
  State<MediaPickerWidget> createState() => _MediaPickerWidgetState();
}

class _MediaPickerWidgetState extends State<MediaPickerWidget> {
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(7),
      child: Container(
        width: size.width * 0.9,
        height: size.height * 0.2,
        color: Colors.grey.shade300,
        child: _selectedImage != null ? Container(   decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: FileImage(
             _selectedImage!
            ),
          ),
        ),) : Column(
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
              widget.isImage ? "Select image(s)" : "Select video(optional)",
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

    if(returnedImage == null) return;
    setState(() {
        _selectedImage = File(returnedImage!.path);
    });
  }
}
