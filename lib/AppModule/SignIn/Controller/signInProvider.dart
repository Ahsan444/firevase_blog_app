import 'package:blog_app/AppModule/HomeScreen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../Utils/app_loader.dart';

class SignInProvider extends ChangeNotifier {

  var userEmail = TextEditingController();
  var userPassword = TextEditingController();
  String? email, password;
  bool show = false;
  final formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;

  void signIn() {
    email = userEmail.text;
    password = userPassword.text;
    notifyListeners();
  }

  void showMethod(var value) {
    show = !show;
    notifyListeners();
  }

  Future<void> signInWithEmailAndPassword(BuildContext context) async {
    appLoader(context, Colors.orangeAccent);
    try {

      final user = await auth.createUserWithEmailAndPassword(
          email: email.toString().trim(), password: password.toString().trim());


      if (user != null) {
        _pop(context);
        userEmail.clear();
        userPassword.clear();

        toastMessage('User successfully created');
      }
    } catch (e) {
      toastMessage(e.toString());
      Navigator.pop(context);
      debugPrint('Error: $e');
    }

  }
  _pop(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
  }


  void toastMessage(var message){
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
