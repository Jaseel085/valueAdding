
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void positiveshowSnackBar(BuildContext context,String text){
  ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(SnackBar(
      backgroundColor: Colors.green,
      content: Text(text)),);
}
void negetiveshowSnackBar(BuildContext context,String text){
  ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Text(text)),);
}