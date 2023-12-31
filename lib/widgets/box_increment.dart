import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BoxIncrement extends StatelessWidget {
  const BoxIncrement(
      {super.key,
      required this.title,
      this.subtitle = "",
      required this.boxVal,
      required this.minusOnPress,
      required this.addOnPress});

  final String title;
  final String subtitle;
  final String boxVal;
  final VoidCallback minusOnPress;
  final VoidCallback addOnPress;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title),
        Text(subtitle),
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent, width: 1),
          ),
          child: Center(
            child: Text(
              boxVal,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: minusOnPress,
                icon: const Icon(
                  FontAwesomeIcons.circleMinus,
                  size: 30,
                  color: Colors.blue,
                )),
            IconButton(
                onPressed: addOnPress,
                icon: const Icon(
                  FontAwesomeIcons.circlePlus,
                  size: 30,
                  color: Colors.blue,
                )),
          ],
        ),
      ],
    );
  }
}
