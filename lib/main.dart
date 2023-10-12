import 'package:drift_db_viewer/drift_db_viewer.dart';
import 'package:easy_localization/easy_localization.dart';
//import 'package:easy_localization_loader/easy_localization_loader.dart'; // import custom loaders
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:survey_app/constants/constant_values.dart';
import 'package:survey_app/pages/survey_info/dashboard.dart';
import 'package:survey_app/providers/providers.dart';
import 'package:survey_app/routes/go_route_main.dart';

import 'l10n/locale_keys.g.dart';

String _versionCode = "Version 2";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(ProviderScope(
    child: EasyLocalization(
      supportedLocales: const [
        kLocaleEn,
        kLocaleFr,
      ],
      path: 'assets/l10n',
      child: const MyApp(),
    ),
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

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(FontAwesomeIcons.globe),
                  onPressed: () {
                    context.locale == kLocaleEn
                        ? context.setLocale(kLocaleFr)
                        : context.setLocale(kLocaleEn);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            'Language has been changed to ${context.locale == kLocaleFr ? "French" : "English"}')));
                  },
                  tooltip: 'Menu',
                ),
              ),
              Text(
                LocaleKeys.appTitle,
                //widget.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ).tr(),
              Text(_versionCode),
              Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          context.goNamed(DashboardPage.routeName);
                        },
                        child: const Text(LocaleKeys.start).tr()),
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
