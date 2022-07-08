import 'package:flutter/material.dart';

import '../Login/login_screen.dart';
import '../SignIn/sign_in_screen.dart';
import '../Utils/round_btn.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Image(image: AssetImage('images/firebase_logo.png')),
              SizedBox(
                height: height * 0.02,
              ),
              RoundBtn(
                title: 'Login',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>const LoginScreen(),
                    ),
                  );
                },
              ),
              SizedBox(
                height: height * 0.02,
              ),
              RoundBtn(
                title: 'Register',
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
