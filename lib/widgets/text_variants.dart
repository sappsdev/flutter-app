import 'package:app/config/responsive.dart';
import 'package:flutter/material.dart';

class TextVariant extends StatelessWidget {
  const TextVariant({Key? key}) : super(key: key);

  static Text h1({text, color, context}) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? Colors.black,
        fontSize: isMobile(context) ? 34 : 48,
        fontWeight: FontWeight.w800,
      )
    );
  }
  static Text h2({text, color, context}) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? Colors.black,
        fontSize: isMobile(context) ? 24 : 34,
        fontWeight: FontWeight.w700,
      )
    );
  }
  static Text h3({text, color, context}) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? Colors.black,
        fontSize: isMobile(context) ? 20 : 24,
        fontWeight: FontWeight.w700,
      )
    );
  }
  static Text h4({text, color, context}) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? Colors.black,
        fontSize: isMobile(context) ? 16 : 20,
        fontWeight: FontWeight.w700,
      )
    );
  }
  static Text h5({text, color, context}) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? Colors.black,
        fontSize: isMobile(context) ? 14 : 16,
        fontWeight: FontWeight.w700,
      )
    );
  }
  static Text h6({text, color, context}) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? Colors.black,
        fontSize: isMobile(context) ? 12 : 14,
        fontWeight: FontWeight.w700,
      )
    );
  }
  static Text body({text, color, context}) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? Colors.black,
        fontSize: isMobile(context) ? 14 : 16,
        fontWeight: FontWeight.w400,
        height: 1.618
      )
    );
  }
  static Text bodyMedium({text, color, context}) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? Colors.black,
        fontSize: isMobile(context) ? 14 : 16,
        fontWeight: FontWeight.w500,
        height: 1.618
      )
    );
  }
  static Text caption({text, color, context}) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? Colors.black,
        fontSize: isMobile(context) ? 11 : 12,
        fontWeight: FontWeight.w400,
      )
    );
  }
  static Text captionMedium({text, color, context}) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? Colors.black,
        fontSize: isMobile(context) ? 11 : 12,
        fontWeight: FontWeight.w500,
      )
    );
  }
  static Text footer({text, color, context}) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? Colors.black,
        fontSize: 10,
        fontWeight: FontWeight.w400,
      )
    );
  }
  static Text footerMedium({text, color, context}) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? Colors.black,
        fontSize: 10,
        fontWeight: FontWeight.w500,
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}

bool isMobile(context){
  return Responsive.isMobile(context);
}
