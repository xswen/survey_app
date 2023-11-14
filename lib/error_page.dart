import 'package:flutter/material.dart';

import 'widgets/app_bar.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: OurAppBar("ERROR"),
      body: Center(
        child: Text("Page not found"),
      ),
    );
  }
}
