import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/app_bar.dart';

class DeleteCheckPage extends StatelessWidget {
  const DeleteCheckPage(
      {super.key,
      required this.object,
      required this.content,
      required this.contOnPress});
  final String object;
  final String content;
  final VoidCallback contOnPress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OurAppBar("Delete $object"),
      body: Column(
        children: [
          Text(
            content,
            style: TextStyle(fontSize: 24),
          ),
          Container(
            child: ButtonBar(
              alignment: MainAxisAlignment.center,
              buttonPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              children: [
                ElevatedButton(
                    onPressed: () => Get.back(), child: const Text("Cancel")),
                ElevatedButton(
                    onPressed: contOnPress, child: const Text("Continue")),
              ],
            ),
          )
        ],
      ),
    );
  }
}
