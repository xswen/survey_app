import 'package:survey_app/barrels/page_imports_barrel.dart';

part 'ecological_plot_providers.g.dart';

@riverpod
Future<EcpSummaryData> ecpData(EcpDataRef ref, int ecpId) =>
    ref.read(databaseProvider).ecologicalPlotTablesDao.getSummary(ecpId);

@riverpod
Future<List<EcpHeaderData>> ecpTransList(EcpTransListRef ref, int ecpId) => ref
    .read(databaseProvider)
    .ecologicalPlotTablesDao
    .getHeaderWithEcpSummryId(ecpId);
