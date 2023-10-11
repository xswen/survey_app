import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/database.dart';
import 'change_notifiers.dart';

final databaseProvider = Provider<Database>((ref) => Database.instance);
final updateNotifierSurveyInfoProvider =
    ChangeNotifierProvider<UpdateNotifierSurveyInfo>(
        (ref) => UpdateNotifierSurveyInfo());

final updateSurveyHeaderListFutureProvider = FutureProvider<List<SurveyHeader>>(
    (ref) => ref.read(databaseProvider).surveyInfoTablesDao.allSurveys);
