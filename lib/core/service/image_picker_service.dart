import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImagePickerService {
  Future<File?> imagePicker(ImageSource e) async {
    XFile? image;
    try {
      image = await ImagePicker().pickImage(source: e);
    } catch (e) {
      print(e);
    }

    if (image != null) {
      final croppedImage = await _cropImage(image.path);
      final directory = await getApplicationDocumentsDirectory();
      final String newPath = '${directory.path}/${image.name}';
      final compressedImage = await compressImage(croppedImage, newPath);
      final pickedFile = File(compressedImage!.path);
      return pickedFile;
    }

    return null;
  }

  Future<XFile?> compressImage(File imageData, String path) async {
    return await FlutterImageCompress.compressAndGetFile(
      imageData.path,
      path,
    );
  }

  Future<File> _cropImage(String imagePath) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imagePath,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9,
      ],
    );

    if (croppedFile != null) {
      return File(croppedFile.path);
    } else {
      return File(croppedFile!.path);
    }
  }
}
