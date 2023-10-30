import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:survey_app/constants/margins_padding.dart';
import 'package:survey_app/widgets/buttons/delete_button.dart';

import '../widgets/app_bar.dart';
import '../widgets/drawer_menu.dart';

class DeletePage extends StatelessWidget {
  static const String routeName = "delete";
  static const String keyObjectName = "objectName";
  static const String keyDeleteFn = "deleteFn";
  static const String keyAfterDeleteFn = "afterDeleteFn";

  const DeletePage(
      {super.key,
      required this.objectName,
      required this.deleteFn,
      required this.afterDeleteFn});
  final String objectName;
  final void Function() deleteFn;
  //How to handle behaviour after deletion. Default context.pop;
  //Mostly deprecated
  final void Function()? afterDeleteFn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OurAppBar("Delete $objectName"),
      endDrawer: const DrawerMenu(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(kPaddingH),
          child: Column(
            children: [
              Text(
                "You are about to delete $objectName. "
                "This cannot be undone. "
                "Are you sure you want to delete?",
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: kPaddingH),
              ElevatedButton(
                onPressed: () => context.pop(),
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50)),
                child: const Text("Back"),
              ),
              DeleteButton(delete: () {
                deleteFn();
                context.pop();
              })
            ],
          ),
        ),
      ),
    );
  }
}
