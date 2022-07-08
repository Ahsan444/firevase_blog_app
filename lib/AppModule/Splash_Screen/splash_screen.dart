import 'package:blog_app/AppModule/DashBoard/dashboard_screen.dart';
import 'package:blog_app/AppModule/HomeScreen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  void splashScreen() {
    final user = auth.currentUser;
    Future.delayed(const Duration(seconds: 3), () {
     if (user != null) {
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const DashboardScreen()));
     }  else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
     }
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    splashScreen();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Splash Screen'),
      ),
    );
  }
}
