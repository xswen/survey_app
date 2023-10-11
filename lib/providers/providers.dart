import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/database.dart';

final databaseProvider = Provider<Database>((ref) => Database.instance);

final rebuildDashboardProvider = StateProvider<bool>((ref) => false);
