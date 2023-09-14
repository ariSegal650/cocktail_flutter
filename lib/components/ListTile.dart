
import 'package:flutter/material.dart';

class ListTileApp extends StatefulWidget {
  final Map<String, dynamic> step;
  final int IndexP;
  const ListTileApp({Key? key, required this.step, required this.IndexP}) : super(key: key);

  @override
  _ListTileAppState createState() => _ListTileAppState();
}

class _ListTileAppState extends State<ListTileApp> {
  bool clicked = false;
  int viewd =0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          clicked = !clicked;
          viewd++;
        });
      },
      child: ListTile(
        leading: CircleAvatar(child: Text(String.fromCharCode((widget.IndexP)+65))),
        title: Text(widget.step.keys.first),
        subtitle: clicked ? Text(widget.step.values.first) : null,
        trailing:Icon( Icons.done_all_rounded ,
        color: viewd>0 ? Colors.green : Colors.grey,),
      ),
    );
  }
}
