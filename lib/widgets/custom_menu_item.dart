import 'package:app/constants.dart';
import 'package:app/widgets/text_variants.dart';
import 'package:flutter/material.dart';

class CustomMenuitem extends StatefulWidget {

  final bool isActive;
  final Function onPressed;
  final String text;
  final IconData? icon; 

  const CustomMenuitem({ 
    this.isActive = false,
    required this.onPressed,
    required this.text,
    this.icon,
    Key? key 
  }) : super(key: key);

  @override
  _CustomMenuitemState createState() => _CustomMenuitemState();
}

class _CustomMenuitemState extends State<CustomMenuitem> {

  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      color: isHovered
          ? Colors.black.withOpacity(0.1)
          : widget.isActive
              ? Colors.black.withOpacity(0.1)
              : Colors.transparent,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.isActive ? null : () => widget.onPressed(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: MouseRegion(
              onEnter: (_) {
                setState(() {
                  isHovered = true;
                });
              },
              onExit: (_) {
                setState(() {
                  isHovered = false;
                });
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if(widget.icon != null) ...[
                    CircleAvatar(
                      backgroundColor : primaryColor,
                      child: Icon(widget.icon, color: Colors.white, size: 30),
                      radius: 24,
                    ),
                    const SizedBox(width: 10),
                  ],
                  TextVariant.h4(
                    text: widget.text,
                    context: context, 
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}