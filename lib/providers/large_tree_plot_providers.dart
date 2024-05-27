import 'package:survey_app/barrels/page_imports_barrel.dart';

part 'large_tree_plot_providers.g.dart';

@riverpod
Future<LtpSummaryData> ltpData(LtpDataRef ref, int ltpId) =>
    ref.read(databaseProvider).largeTreePlotTablesDao.getLtpSummary(ltpId);
