import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bindings.dart';
import '../routes/get_pages.dart';
import 'database/database.dart';
import 'error_page.dart';
import 'routes/route_names.dart';
import 'widgets/app_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
    supportedLocales: const [
      Locale('en', 'CA'),
      Locale('fr', 'CA'),
    ],
    path: 'assets/l10n',
    child: MyApp(),
    // fallbackLocale: Locale('en', 'US'),
    // startLocale: Locale('de', 'DE'),
    // saveLocale: false,
    // useOnlyLangCode: true,

    // optional assetLoader default used is RootBundleAssetLoader which uses flutter's assetloader
    // install easy_localization_loader for enable custom loaders
    // assetLoader: RootBundleAssetLoader()
    // assetLoader: HttpAssetLoader()
    // assetLoader: FileAssetLoader()
    // assetLoader: CsvAssetLoader()
    // assetLoader: YamlAssetLoader() //multiple files
    // assetLoader: YamlSingleAssetLoader() //single file
    // assetLoader: XmlAssetLoader() //multiple files
    // assetLoader: XmlSingleAssetLoader() //single file
    // assetLoader: CodegenLoader()
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'NFI Ground Plot Survey',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialBinding: DbBinding(),
      initialRoute: Routes.main,
      unknownRoute: GetPage(name: Routes.error, page: () => const ErrorPage()),
      getPages: pages,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _db = Get.find<Database>();

  @override
  Widget build(BuildContext context) {
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
                widget.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ).tr(),
              Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          Get.toNamed(Routes.surveySelect,
                              arguments:
                                  (await _db.surveyInfoTablesDao.allSurveys));
                        },
                        child: const Text("Start")),
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
