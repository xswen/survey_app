import 'package:survey_app/barrels/page_imports_barrel.dart';

part 'small_tree_plot_providers.g.dart';

@riverpod
Future<List<StpSpeciesData>> stpSpeciesList(
        StpSpeciesListRef ref, int stpId) async =>
    ref.read(databaseProvider).smallTreePlotTablesDao.getSpeciesList(stpId);
