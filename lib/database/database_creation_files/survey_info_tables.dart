import 'package:drift/drift.dart';

import 'reference_tables.dart';

class SurveyHeaders extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get nfiPlot => integer()
      .check(nfiPlot.isBetweenValues(1, 1600000) |
          nfiPlot.isBetweenValues(2000000, 2399999))
      .references(Plots, #nfiPlot)();
  DateTimeColumn get measDate => dateTime()();
  IntColumn get measNum => integer()();
  TextColumn get province =>
      text().withLength(min: 2, max: 2).references(Jurisdictions, #code)();
  BoolColumn get complete => boolean().withDefault(const Constant(false))();

  @override
  List<String> get customConstraints =>
      ['UNIQUE (nfi_plot, meas_num, province)'];
}
