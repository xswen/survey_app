import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/database.dart';

final databaseProvider = Provider<Database>((ref) => Database.instance);

final rebuildDashboardProvider = StateProvider<bool>((ref) => false);
final rebuildSurveyInfoProvider = StateProvider<bool>((ref) => false);
final rebuildSurveyCardsProvider = StateProvider<bool>((ref) => false);
