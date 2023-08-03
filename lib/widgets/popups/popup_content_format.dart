import 'package:flutter/material.dart';

class PopupContentFormat extends StatelessWidget {
  const PopupContentFormat(
      {super.key, required this.titles, required this.details});

  final List<String> titles;
  final List<String> details;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: generateChildren(),
    );
  }

  List<Widget> generateChildren() {
    List<Widget> result = [];
    for (int i = 0; i < titles.length; i++) {
      List<String> lines = details[i].split('\n');
      Widget title = titles[i].isEmpty
          ? Container()
          : Text("${titles[i]}:",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ));
      result.addAll([
        title,
        ...lines
            .map((line) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: line.isEmpty
                      ? Container()
                      : Text(
                          '• $line',
                          style: const TextStyle(color: Colors.black),
                          textAlign: TextAlign.left,
                        ),
                ))
            .toList(),
      ]);
    }
    return result;
  }
}
