import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseUtils {
  // Upload a User Profile Picture
  static Future<String?> uploadUserProfilePicture(String userId) async {
    final ImagePicker _picker = ImagePicker();
    try {
      // Pick an image from the gallery
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image == null) return null;

      // Get the file
      File imageFile = File(image.path);

      // Define storage path
      Reference storageRef =
      FirebaseStorage.instance.ref().child('users/$userId.jpg');

      // Upload the file
      UploadTask uploadTask = storageRef.putFile(imageFile);

      // Wait for upload completion and get the download URL
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      // Update the Firestore user's document
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'profilePicture': downloadUrl,
      });

      print("Profile picture uploaded successfully: $downloadUrl");
      return downloadUrl;
    } catch (e) {
      print("Error uploading profile picture: $e");
      return null;
    }
  }

  // Upload Activity Photos
  static Future<List<String>?> uploadActivityPhotos(String activityId) async {
    final ImagePicker _picker = ImagePicker();
    try {
      // Pick multiple images
      final List<XFile>? images = await _picker.pickMultiImage();

      if (images == null || images.isEmpty) return null;

      List<String> photoUrls = [];

      for (var image in images) {
        // Get the file
        File imageFile = File(image.path);

        // Define a unique storage path for each image
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference storageRef =
        FirebaseStorage.instance.ref().child('activities/$activityId/$fileName.jpg');

        // Upload the file
        UploadTask uploadTask = storageRef.putFile(imageFile);

        // Wait for completion and get the download URL
        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();

        // Add the URL to the list
        photoUrls.add(downloadUrl);
      }

      // Save the URLs in Firestore
      await FirebaseFirestore.instance.collection('activities').doc(activityId).update({
        'photos': FieldValue.arrayUnion(photoUrls),
      });

      print("Activity photos uploaded successfully: $photoUrls");
      return photoUrls;
    } catch (e) {
      print("Error uploading activity photos: $e");
      return null;
    }
  }
}
