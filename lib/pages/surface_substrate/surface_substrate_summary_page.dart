import 'package:flutter/material.dart';

import '../../widgets/app_bar.dart';
import '../../widgets/buttons/floating_complete_button.dart';

class SurfaceSubstrateSummaryPage extends StatefulWidget {
  const SurfaceSubstrateSummaryPage({Key? key}) : super(key: key);

  @override
  State<SurfaceSubstrateSummaryPage> createState() =>
      _SurfaceSubstrateSummaryPageState();
}

class _SurfaceSubstrateSummaryPageState
    extends State<SurfaceSubstrateSummaryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const OurAppBar(""),
      floatingActionButton: FloatingCompleteButton(
        title: "",
        complete: false,
        onPressed: () {},
      ),
      body: Center(
        child: Container(),
      ),
    );
  }
}
