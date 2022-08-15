import 'package:flutter/material.dart';
import 'package:gif_fromapi/Src/Home.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GIF API',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const Homepage(title: 'GIF FROM API',),
    );
  }
}
