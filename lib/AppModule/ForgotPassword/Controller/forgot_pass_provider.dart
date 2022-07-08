import 'package:blog_app/AppModule/DashBoard/dashboard_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Utils/app_loader.dart';

class ForgotPassProvider extends ChangeNotifier{
  var userEmail = TextEditingController();
  String? email;
  final formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;

  void signIn() {
    email = userEmail.text;
    notifyListeners();
  }



  Future<void> forgotPassword(BuildContext context) async {
    appLoader(context, Colors.orangeAccent);
    try {
      auth.sendPasswordResetEmail(email: email.toString().trim()).then((value) => {
        debugPrint('email send hugaai '),
        toastMessage('Password reset link has been sent to your email'),
      Navigator.pop(context),
      }).onError((error, stackTrace) => {

        toastMessage(error.toString()),
        Navigator.pop(context),
      });



    } catch (e) {
      toastMessage(e.toString());
      Navigator.pop(context);
      debugPrint('Error: $e');
    }

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