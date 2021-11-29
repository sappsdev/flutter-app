import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashLayout extends StatelessWidget {

  const SplashLayout({ 
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset('assets/lottie/splash.json', width: 200),
      ),
    );
  }
}