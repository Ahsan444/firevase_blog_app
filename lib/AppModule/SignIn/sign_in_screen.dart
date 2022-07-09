import 'package:blog_app/AppModule/SignIn/Controller/signInProvider.dart';
import 'package:blog_app/AppModule/Utils/round_btn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Create Account'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Register',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Consumer<SignInProvider>(builder: (context, provider, _) {
                return Form(
                  key: provider.formKey,
                    child: Column(
                  children: [
                    TextFormField(
                      controller: provider.userEmail,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Colors.deepOrange,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter your email',
                        labelStyle: TextStyle(color: Colors.deepOrange),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.deepOrange,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepOrange),
                        ),
                      ),
                      onChanged: (value) {
                        provider.email = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    TextFormField(
                      controller: provider.userPassword,
                      obscureText: provider.show ? false : true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: const TextStyle(color: Colors.deepOrange),
                        hintText: 'Enter your password',
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.deepOrange,
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.deepOrange,
                          ),
                        ),
                        suffixIcon: provider.show
                            ? InkWell(
                                child: const Icon(Icons.remove_red_eye,color: Colors.deepOrange,),
                                onTap: () {
                                  provider.showMethod(true);
                                },
                              )
                            : InkWell(
                                child: const Icon(Icons.visibility_off,color: Colors.deepOrange,),
                                onTap: () {
                                  provider.showMethod(false);
                                },
                              ),
                      ),
                      onChanged: (value) {
                        provider.password = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RoundBtn(title: 'SignUp', onPressed: (){
                        if (provider.formKey.currentState!.validate()) {
                          // appLoader(context, AppColors.PRIMARY_COLOR);
                          provider.signInWithEmailAndPassword(context);
                        }else{
                         debugPrint('sai info dyyy');
                        }
                      }),
                    )
                  ],
                ));
              }),
            ),
          ],
        ),
      ),
    );
  }
}
