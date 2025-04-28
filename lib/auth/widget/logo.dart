import 'package:flutter/material.dart';

class LogoImage extends StatelessWidget {
  const LogoImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 150,
        width: 150,
        color: Colors.grey,
        child: Image.asset(
          '/Users/morjan/apps/study_traker/lib/assest/icon1.jpg',
        ),
      ),
    );
  }
}
