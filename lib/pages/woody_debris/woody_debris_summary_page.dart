import 'package:drift/drift.dart' as d;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:survey_app/database/database.dart';

import '../../widgets/app_bar.dart';
import '../../widgets/buttons/floating_complete_button.dart';

class WoodyDebrisSummaryPage extends StatefulWidget {
  WoodyDebrisSummaryPage({Key? key, required this.wd, required this.transList})
      : super(key: key);

  WoodyDebrisSummaryCompanion wd;
  List<WoodyDebrisHeaderData> transList;

  @override
  State<WoodyDebrisSummaryPage> createState() => _WoodyDebrisSummaryPageState();
}

class _WoodyDebrisSummaryPageState extends State<WoodyDebrisSummaryPage> {
  late WoodyDebrisSummaryCompanion wd;
  late List<WoodyDebrisHeaderData> transList;

  @override
  void initState() {
    wd = widget.wd;
    transList = widget.transList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    final db = Provider.of<Database>(context);

    return Scaffold(
      appBar: OurAppBar("Woody Debris"),
      floatingActionButton: FloatingCompleteButton(
        title: "",
        complete: false,
        onPressed: () async {
          (db.update(db.woodyDebrisSummary)
                ..where((t) => t.id.equals(wd.id.value)))
              .write(WoodyDebrisSummaryCompanion(
                  complete: d.Value(!wd.complete.value)));
          wd = (await db.woodyDebrisTablesDao.getWdSummary(wd.surveyId.value))
              .toCompanion(true);
          print(wd);
        },
      ),
      body: Center(
        child: Text(widget.wd.toString()),
      ),
    );
  }
}
