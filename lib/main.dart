import 'package:blog_app/AppModule/HomeScreen/home_screen.dart';
import 'package:blog_app/AppModule/Login/Controller/loginInProvider.dart';
import 'package:blog_app/AppModule/Posts/Controller/posts_provider.dart';
import 'package:blog_app/AppModule/SignIn/Controller/signInProvider.dart';
import 'package:blog_app/AppModule/Splash_Screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'AppModule/DashBoard/Controller/data_list_provider.dart';
import 'AppModule/ForgotPassword/Controller/forgot_pass_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        ChangeNotifierProvider(create: (_)=> SignInProvider()),
        ChangeNotifierProvider(create: (_)=> LoginInProvider()),
        ChangeNotifierProvider(create: (_)=> PostProvider()),
        ChangeNotifierProvider(create: (_)=> DataListProvider()),
        ChangeNotifierProvider(create: (_)=> ForgotPassProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}

