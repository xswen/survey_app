import 'package:survey_app/barrels/page_imports_barrel.dart';

import '../database/daos/large_tree_plot_tables_dao.dart';

part 'large_tree_plot_providers.g.dart';

@riverpod
Future<LtpSummaryData> ltpData(LtpDataRef ref, int ltpId) =>
    ref.read(databaseProvider).largeTreePlotTablesDao.getLtpSummary(ltpId);

@riverpod
Future<List<LtpMergedTreeEntry>> ltpMergedTreeEntryList(
        LtpMergedTreeEntryListRef ref, int ltpSummaryId) =>
    ref
        .read(databaseProvider)
        .largeTreePlotTablesDao
        .getMergedLtpTreeEntries(ltpSummaryId);
