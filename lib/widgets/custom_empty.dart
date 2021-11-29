import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Center customEmpty(){
  return Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
      child: Lottie.asset('assets/lottie/empty.json', width: 200),
    ),
  );
}