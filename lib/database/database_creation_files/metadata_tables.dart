import 'package:drift/drift.dart';

import 'reference_tables.dart';
import 'survey_info_tables.dart';

class MetaComment extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get surveyId => integer().unique().references(SurveyHeaders, #id)();
  IntColumn get surveyCategory => integer()();
  TextColumn get commentText => text()();
}
