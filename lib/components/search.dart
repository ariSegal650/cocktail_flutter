import 'package:flutter/material.dart';

class search extends StatefulWidget {
  final Function(String) onTextSubmitted;
  const search({super.key, required this.onTextSubmitted});

  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      // controller: editingController,
      decoration: const InputDecoration(
        labelText: "Search",
        hintText: "Search",
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      onChanged: (value1) {
        setState(() {
          widget.onTextSubmitted(value1.toString());
        });
      },
    );
  }
}
