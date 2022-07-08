import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../DashBoard/dashboard_screen.dart';
import '../../Utils/app_loader.dart';

class PostProvider extends ChangeNotifier {
  File? image;
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final picker = ImagePicker();
  FirebaseAuth auth = FirebaseAuth.instance;

  //initialize firebase storage
  final postRef = FirebaseDatabase.instance.ref().child('Posts');
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future getImageGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      notifyListeners();
    } else {
      debugPrint('No image selected');
    }
  }

  Future getImageCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      notifyListeners();
    } else {
      debugPrint('No image selected');
    }
  }

  Future<void> uploadPost(BuildContext context) async {
    appLoader(context, Colors.orangeAccent);
    try {
      //upload image to firebase storage

      int date = DateTime.now().millisecondsSinceEpoch;
      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref('/blogApp$date');
      UploadTask uploadTask = ref.putFile(image!.absolute);
      //waiting for upload to complete
      await Future.value(uploadTask);
      var newUrl = await ref.getDownloadURL();
    final User? user = auth.currentUser;
    postRef.child('Post List').child(date.toString()).set({
      'pId': date.toString(),
      'pImage': newUrl.toString(),
      'pTime': date.toString(),
      'pTitle': titleController.text.toString(),
      'pDescription': descriptionController.text.toString(),
      'pEmail': user?.email.toString(),
      'pUserId': user?.uid.toString(),

      }).then(
        (value) {
          toastMessage('Post uploaded successfully');
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const DashboardScreen()));

          Navigator.pop(context);
        },
      ).onError(
        (error, stackTrace) {
          toastMessage(
            error.toString(),
          );
          Navigator.pop(context);
        },
      );
    } catch (e) {
      toastMessage(e.toString());
      Navigator.pop(context);
      debugPrint('Error: $e');
    }
  }

  void toastMessage(var message) {
    Fluttertoast.showToast(
        msg: message.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
