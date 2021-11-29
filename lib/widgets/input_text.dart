import 'package:app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputText extends StatelessWidget {
  final bool? dark;
  final double? width;
  final double? height;
  final bool? password;
  final Widget? prefix;
  final Widget? suffix;
  final String? label;
  final String? placeholder;
  final TextEditingController? controller;
  final Function? onValidate;
  final Function? onChange;
  final TextInputType? keyboard;
  final TextInputFormatter? formatter;

  const InputText({
    Key? key,
    this.dark,
    this.width,
    this.height,
    this.password,
    this.prefix,
    this.suffix,
    this.label,
    this.placeholder,
    this.controller,
    this.onValidate,
    this.onChange,
    this.keyboard,
    this.formatter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _colorText = (dark == true ? Colors.white : primaryColor);
    var _defaultColor = (dark == true ? Colors.white : Colors.black87);
    var _focusColor = (dark == true ? secondaryColor : primaryColor);
    return SizedBox(
      width: width ?? 300,
      height: height ?? 40,
      child: Focus(
        onFocusChange: (hasFocus) {
          _colorText = hasFocus ? _focusColor : _defaultColor;
        },
        child: TextFormField(
          keyboardType: keyboard ?? TextInputType.text,
          obscureText: password ?? false,
          textInputAction: TextInputAction.next,
          cursorColor: dark == true ? Colors.white : Colors.black26,
          controller: controller,
          validator: (value) => onValidate!(value),
          onChanged: (value) {
            onChange != null ? onChange!(value) : null;
          },
          style: TextStyle(color: _colorText),
          inputFormatters: [if (formatter != null) formatter!],
          decoration: InputDecoration(
            prefixIcon: prefix,
            suffix: suffix,
            isDense: true,
            labelText: label,
            labelStyle: TextStyle(color: _colorText),
            hintText: placeholder,
            hintStyle: TextStyle(color: _defaultColor),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: _focusColor, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: _colorText, width: 1),
            ),
            border: const OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
