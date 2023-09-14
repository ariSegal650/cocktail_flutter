import 'package:flutter/material.dart';
import 'package:sushi/pages/card_parameters.dart';
import 'package:sushi/pages/page1.dart';

void main() {
  runApp( const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(),
        '/secondPage': (context) =>  CardParameters(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
  
      
      body: SafeArea(
        child: SingleChildScrollView(
          child: 
            Page1(),
          
        ),
      ),
    );
  }
}
