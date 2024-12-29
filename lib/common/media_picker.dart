import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myrecipediary/dashboard/repository/ingredient_repo.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../constants/colors.dart';
import 'alert_dialogs/error_alert_dialog.dart';

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

  // image upload and download
  Future _pickImageFromGallery() async {
    try {
      final XFile? returnedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (returnedImage == null) {
        print("No image selected.");
        return;
      }

      setState(() {
        _selectedImage = File(returnedImage.path);
        print("SELECTED IMAGE PATH: ${_selectedImage!.path}");
      });

      final path = "images/${DateTime.now().millisecondsSinceEpoch}/${returnedImage.name}";
      final file = File(returnedImage.path);

      final storeRef = FirebaseStorage.instance.ref().child(path);
      final uploadTask = storeRef.putFile(file);

      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) async {
        if (snapshot.state == TaskState.success) {
          // Upload finished successfully
          try {
            final downloadUrl = await storeRef.getDownloadURL();
            // print("Download URL: $downloadUrl");

            // Step 6: Store the download URL in your state or Firestore
            ref.read(selectedImage.notifier).state = downloadUrl;
          } catch (e) {
            errorAlertWidget(
                context, "IMAGE DOWNLOAD FAILED", "Failed to get download URL",
                onTap: () {
              context.pop();
            });
            // print("Failed to get download URL: $e");
          }
        } else if (snapshot.state == TaskState.canceled) {
          // Upload was canceled
          errorAlertWidget(
              context, "IMAGE UPLOAD CANCELLED", "Upload was canceled.",
              onTap: () {
            context.pop();
          });
          // print("Upload was canceled.");
        } else if (snapshot.state == TaskState.running) {
          // Upload is in progress
          // print(
          //     "Uploading: ${snapshot.bytesTransferred}/${snapshot.totalBytes}");
        }
      });
    } catch (e) {
      throw Exception("Image upload failed: $e");
    }
  }
}
