import 'package:flutter/material.dart';
import 'students.dart';

void main() {runApp(MyApp());}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CSCI410 PROJECT',
      home: StudentsPage(),
    );
  }
}