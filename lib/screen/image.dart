import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saraih_app/api-service/cache_services.dart';
import 'package:saraih_app/functions/snack_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageChoice extends StatefulWidget {
  const ImageChoice({super.key});

  @override
  State<ImageChoice> createState() => _ImageChoiceState();
}

class _ImageChoiceState extends State<ImageChoice> {
  XFile? phoneImage;
  File? phoneImage1;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Choose an option'),
      content: Text('Please select one of the options below.'),
      actions: <Widget>[
        TextButton( 
          onPressed: () async {
            Navigator.of(context).pop();
            phoneImage = await getImageFromYourPhoneCamera();
            try {
              if (phoneImage != null) {
                setState(() {
                  phoneImage1 = File(phoneImage!.path);
                });
               _saveImagePath(phoneImage);
              } else {
                // Handle the case when no image is selected
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('No image selected from camera.')),
                );
                setState(() {
                  phoneImage1 =
                      File('images/blank-profile-picture-973461_1280.png');
                });
                _saveImagePath(phoneImage);
                print(phoneImage);
              }
            } catch (e) {
              print(e);
            }
          },
          child: Text('From Camera'),
        ),
        TextButton(
          onPressed: () async {
            Navigator.of(context).pop();
            phoneImage = await getImageFromYourPhoneGallery();
            try {
              if (phoneImage != null) {
                setState(() {
                  phoneImage1 = File(phoneImage!.path);
                });
              } else {
                showSnackBar(context, "No image selected from gallery.");
                setState(() {
                  phoneImage1 =
                      File('images/blank-profile-picture-973461_1280.png');
                });
                CacheService.saveData(
                  value: phoneImage1,
                  key: 'image',
                );
              }
            } catch (e) {
              print(e);
            }
          },
          child: Text('From Gallery'),
        ),
      ],
    );
  }

  Future<XFile?> getImageFromYourPhoneCamera() async {
    final phoneCameraImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    return phoneCameraImage;
  }

  Future<XFile?> getImageFromYourPhoneGallery() async {
    final phoneGalleryImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    return phoneGalleryImage;
  }

}
Future<void> _saveImagePath(XFile? image) async {
    if (image != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('profileImagePath', image.path);
    }
  }




