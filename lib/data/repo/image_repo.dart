import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

XFile? pickedImageFile;

Future<XFile?> pickImageRepo(ImageSource source) async {
  final picker = ImagePicker();
  final pickedImage = await picker.pickImage(source: source);
  if (pickedImage != null) {
    pickedImageFile = XFile(pickedImage.path);
    return pickedImageFile;
  }
  return null;
}

Future<String> uploadImageToStorageRepo(XFile imageFile) async {
  File file = File(imageFile.path);
  // Get a reference to the storage service
  final Reference storageRef = FirebaseStorage.instance.ref().child('profile_images/${DateTime.now().millisecondsSinceEpoch}');

  // Upload file to Firebase Storage
  UploadTask uploadTask = storageRef.putFile(file);

  // Wait for upload to complete
  await uploadTask.whenComplete(() => null);

  // Get download URL
  String downloadURL = await storageRef.getDownloadURL();

  return downloadURL;
}