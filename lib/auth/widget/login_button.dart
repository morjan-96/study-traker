import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {},
      child: Text('Login'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.indigoAccent,
      textColor: Colors.white,
      height: 50,
      minWidth: double.infinity,
      elevation: 0,
    );
  }
}
