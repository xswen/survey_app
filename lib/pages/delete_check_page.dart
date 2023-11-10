import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/app_bar.dart';
import '../widgets/drawer_menu.dart';

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
      endDrawer: const DrawerMenu(),
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
                    onPressed: () => context.pop(),
                    child: const Text("Cancel")),
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
