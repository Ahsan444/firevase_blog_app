import 'package:blog_app/AppModule/DashBoard/dashboard_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Utils/app_loader.dart';

class LoginInProvider extends ChangeNotifier {

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

      final user = await auth.signInWithEmailAndPassword(
          email: email.toString().trim(), password: password.toString().trim());


      if (user != null) {

        userEmail.clear();
        userPassword.clear();
        toastMessage('Login successfully');
        _pop(context);
      }
    } catch (e) {
      toastMessage(e.toString());
      Navigator.pop(context);
      debugPrint('Error: $e');
    }

  }

  _pop(BuildContext context) {
    Navigator.pop(context);
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const DashboardScreen()), (route) => false);
    //Navigator.push(context, MaterialPageRoute(builder: (context) => const DashboardScreen()));
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
