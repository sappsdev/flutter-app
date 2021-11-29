import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GuestLayout extends StatelessWidget {
  final Widget child;
  const GuestLayout({ 
    Key? key,
    required this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {   
    return Scaffold(
      body: Stack(
        children: [
          Container(
            constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: child,
          ),
          Positioned(
            top: 40,
            left: 40,
            child: SvgPicture.asset(
              'assets/images/logo.svg',
              width: 80,
              semanticsLabel: 'logo'
            ),
          )         
        ],
      ),
    );
  }
}