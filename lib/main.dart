import 'package:drift_db_viewer/drift_db_viewer.dart';
import 'package:easy_localization/easy_localization.dart';
//import 'package:easy_localization_loader/easy_localization_loader.dart'; // import custom loaders
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:survey_app/constants/constant_values.dart';
import 'package:survey_app/routes/router_routes.dart';
import 'package:survey_app/widgets/app_bar.dart';

import 'database/database.dart';
import 'l10n/locale_keys.g.dart';
import 'routes/route_names.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(EasyLocalization(
    supportedLocales: const [
      kLocaleEn,
      kLocaleFr,
    ],
    path: 'assets/l10n',
    child: Provider<Database>(
        create: (context) => Database(), child: const MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final db = Provider.of<Database>(context);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Align(
                alignment: Alignment.topRight,
                child: Menu(),
              ),
              Text(
                LocaleKeys.appTitle,
                //widget.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ).tr(),
              Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          context.goNamed(Routes.dashboard,
                              extra: await db.surveyInfoTablesDao.allSurveys);
                        },
                        child: const Text(LocaleKeys.start).tr()),
                    ElevatedButton(
                        onPressed: () async {
                          context.locale == kLocaleEn
                              ? await context.setLocale(kLocaleFr)
                              : await context.setLocale(kLocaleEn);
                        },
                        child: Text(
                            "Change to ${context.locale == kLocaleEn ? "French" : "English"}")),
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
