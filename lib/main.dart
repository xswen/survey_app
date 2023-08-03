import 'package:drift_db_viewer/drift_db_viewer.dart';
import 'package:easy_localization/easy_localization.dart';
//import 'package:easy_localization_loader/easy_localization_loader.dart'; // import custom loaders
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:survey_app/bindings.dart';
import 'package:survey_app/constants/constant_values.dart';
import 'package:survey_app/routes/router_routes.dart';
import 'package:survey_app/widgets/app_bar.dart';

import 'database/database.dart';
import 'l10n/locale_keys.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await DbBinding();

  runApp(EasyLocalization(
    supportedLocales: const [
      kLocaleEn,
      kLocaleFr,
    ],
    path: 'assets/l10n',
    child: Provider<Database>(create: (context) => Database(), child: MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: router,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final db = Provider.of<Database>(context);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: Menu(),
              ),
              Text(
                LocaleKeys.appTitle,
                //widget.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ).tr(),
              Text("test"),
              Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          // Get.toNamed(Routes.surveySelect,
                          //     arguments:
                          //     (await _db.surveyInfoTablesDao.allSurveys));
                        },
                        child: Text(LocaleKeys.start).tr()),
                    ElevatedButton(
                        onPressed: () async {
                          print(context.locale.toString());
                          context.locale == kLocaleEn
                              ? await context.setLocale(kLocaleFr)
                              : await context.setLocale(kLocaleEn);
                        },
                        child: Text(
                            "Change to ${context.locale == kLocaleFr ? "French" : "English"}")),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DriftDbViewer(db)));
                        },
                        child: const Text("View Database")),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
