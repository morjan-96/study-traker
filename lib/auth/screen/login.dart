import 'package:flutter/material.dart';

import 'package:study_traker/auth/widget/login_button.dart';
import 'package:study_traker/auth/widget/logo.dart';
import 'package:study_traker/auth/widget/user_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 100, left: 25.0, right: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LogoImage(),
            Text(
              'Login',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 42),
            ),
            Text(
              'Login To Continue ',
              style: TextStyle(color: Colors.grey, fontSize: 20),
            ),
            SizedBox(height: 50),
            Text(
              'Email',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 10),
            TextForm(hinttext: 'Enter your Email', mycontroller: email),
            SizedBox(height: 10),
            Text(
              'Password',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            TextForm(mycontroller: email, hinttext: 'Enter your password'),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                alignment: Alignment.topRight,
                child: Text(
                  'forget Password ?',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            SizedBox(height: 10),
            LoginButton(),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
