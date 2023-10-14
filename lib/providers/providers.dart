import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../database/database.dart';

part 'providers.g.dart';

@riverpod
Database database(DatabaseRef ref) => Database.instance;
