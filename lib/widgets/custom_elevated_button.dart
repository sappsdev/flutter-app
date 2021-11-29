
import 'package:app/constants.dart';
import 'package:flutter/material.dart';

SizedBox customElevatedButton({
  required Function onPressed,
  Color? color,
  double? width,
  double? height,
  required String text,
}){
  return SizedBox(
    width: width ?? 300,
    height: height ?? 40,
    child: ElevatedButton(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(color ?? primaryColor),
      ),
      onPressed: () => onPressed(),
      child: Text(text)
    )
  );
}