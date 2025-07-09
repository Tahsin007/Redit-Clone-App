import 'package:flutter/material.dart';

class AppErrorWidget extends StatelessWidget {
  final String message;
  const AppErrorWidget({ Key? key, required this.message }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Text(message);
  }
}