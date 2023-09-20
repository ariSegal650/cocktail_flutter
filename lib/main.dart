import 'package:flutter/material.dart';
import 'package:sushi/pages/card_parameters.dart';
import 'package:sushi/pages/page1.dart';
import 'package:sushi/pages/favoritePage.dart';
import 'package:sushi/pages/sidePage.dart';

void main() {
  runApp( MainApp());
}

class MainApp extends StatelessWidget with RouteAware{
   MainApp({super.key});

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      navigatorObservers: [routeObserver],
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) =>  MyHomePage(),
        '/secondPage': (context) => const CardParameters(),
        '/favorite': (context) => const favorite(page: "main",),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
   MyHomePage({super.key});

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My App'),
      ),
      drawer: const sidePage(),
      
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Page1(),
        ),
      ),
    );
  }
}

