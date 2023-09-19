import 'package:flutter/material.dart';

class sidePage extends StatelessWidget {
  const sidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.only(top: 30),
          children: <Widget>[
            ListTile(
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/'); 
              },
            ),
            ListTile(
              title: const Text('Favorite'),
              onTap: () {
                Navigator.pop(context); 
                Navigator.pushNamed(context, '/favorite'); 
              },
            ),
          ],
        ),
   );
  }
}