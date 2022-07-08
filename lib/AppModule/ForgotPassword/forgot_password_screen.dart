import 'package:blog_app/AppModule/ForgotPassword/Controller/forgot_pass_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Utils/round_btn.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Consumer<ForgotPassProvider>(builder: (__, provider, _) {
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RoundBtn(title: 'Recover Password', onPressed: (){
                            if (provider.formKey.currentState!.validate()) {

                              provider.forgotPassword(context);
                            }else{
                              debugPrint('wrong email');
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
