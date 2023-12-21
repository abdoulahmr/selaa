import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

class ImageUploadWidget extends StatefulWidget {
  const ImageUploadWidget({super.key});

  @override
  _ImageUploadWidgetState createState() => _ImageUploadWidgetState();
}

class _ImageUploadWidgetState extends State<ImageUploadWidget> {
  File? _imageFile;
  final picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _uploadImage() async {
    if (_imageFile == null) {
      print('No image selected.');
      return;
    }

    try {
      final firebase_storage.Reference storageRef = firebase_storage.FirebaseStorage.instance.ref().child('profilePicture/${DateTime.now().millisecondsSinceEpoch}.png');

      await storageRef.putFile(_imageFile!);

      print('Image uploaded successfully.');
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Upload'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _imageFile != null
              ? Image.file(
                  _imageFile!,
                  height: 200,
                )
              : Container(),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _pickImage,
            child: Text('Pick Image'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _uploadImage,
            child: Text('Upload Image'),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ImageUploadWidget(),
  ));
}
