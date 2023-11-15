
import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget {
  final String id; 
  final String name;
  final String image;
  final String difficulty;

  const CustomCard({
    super.key,
    required this.id,
    required this.name,
    required this.image,
    required this.difficulty,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  bool isCardClicked = false;
  Color color = Colors.white;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: GestureDetector(
        onTap: () {
          setState(() {
            // Toggle the isCardClicked state to change the color
            isCardClicked = !isCardClicked;

            Navigator.pushNamed(context, '/secondPage', arguments: widget.id);
          });
        },
        child: Card(
          margin: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ClipRect(
                child: Image.network(
                  widget.image,
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                ),
              ),
              ListTile(
                title: Text(
                  widget.name,
                ),
              ),
              Text(
                widget.difficulty,
                style: TextStyle(
                  color: widget.difficulty == 'Easy'
                      ? Colors.green
                      : (widget.difficulty == 'Hard'
                          ? Colors.red
                          : Colors.black),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
