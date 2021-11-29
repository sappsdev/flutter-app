
import 'package:app/constants.dart';
import 'package:flutter/material.dart';

RoundedRectangleBorder shapeAll(){
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(shapeRadius),
    side: BorderSide(
      color: Colors.grey.withOpacity(0.2),
      width: 1,
    ),
  );
}
RoundedRectangleBorder shapeTop(){
  return RoundedRectangleBorder(
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(shapeRadius), 
      topRight: Radius.circular(shapeRadius)
    ),
    side: BorderSide(
      color: Colors.grey.withOpacity(0.2),
      width: 1,
    ),
  );
}
RoundedRectangleBorder shapeButtom(){
  return RoundedRectangleBorder(
    borderRadius: const BorderRadius.only(
      bottomLeft: Radius.circular(shapeRadius), 
      bottomRight: Radius.circular(shapeRadius)
    ),
    side: BorderSide(
      color: Colors.grey.withOpacity(0.2),
      width: 1,
    ),
  );
}