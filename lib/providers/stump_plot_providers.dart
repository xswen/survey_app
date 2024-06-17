import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../database/database.dart';
import 'providers.dart';

part 'stump_plot_providers.g.dart';

@riverpod
Future<List<StumpEntryData>> stumpEntryList(
        StumpEntryListRef ref, int stumpId) async =>
    ref.read(databaseProvider).stumpPlotTablesDao.getStumpEntryList(stumpId);
