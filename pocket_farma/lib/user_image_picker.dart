import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({Key? key}) : super(key: key);

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? pickedImage;

  Future picImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) {
      return;
    }
    final imageTemp = File(pickedImage.path);
    setState(() {
      this.pickedImage = imageTemp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: LayoutBuilder(builder: (context, constraints) {
                if (pickedImage != null) {
                  return SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.file(
                        pickedImage!,
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      ));
                } else {
                  return const Text("Please Upload Your Documnet");
                }
              }),
            ),
            TextButton(
                onPressed: picImage, child: const Text("Upload documnet")),
          ],
        ),
      ),
    );
  }
}
