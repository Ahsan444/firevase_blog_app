import 'package:blog_app/AppModule/Login/Controller/loginInProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../ForgotPassword/forgot_password_screen.dart';
import '../Utils/round_btn.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Account'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Login',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Consumer<LoginInProvider>(builder: (context, provider, _) {
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
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Colors.deepOrange,
                                fontSize: 16,
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ForgotPasswordScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RoundBtn(title: 'LogIn', onPressed: (){
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
