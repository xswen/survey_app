import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../database/database.dart';
import 'providers.dart';

part 'shrub_plot_providers.g.dart';

@riverpod
Future<List<ShrubListEntryData>> shrubEntryList(
        ShrubEntryListRef ref, int shrubId) async =>
    ref.read(databaseProvider).shrubPlotTablesDao.getShrubEntryList(shrubId);
