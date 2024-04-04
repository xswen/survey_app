import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../database/database.dart';
import 'providers.dart';

part 'small_tree_plot_providers.g.dart';

@riverpod
Future<List<StpSpeciesData>> stpSpeciesList(
        StpSpeciesListRef ref, int stpId) async =>
    ref.read(databaseProvider).smallTreePlotTablesDao.getSpeciesList(stpId);
