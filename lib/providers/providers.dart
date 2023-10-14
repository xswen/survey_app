import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../barrels/page_imports_barrel.dart';
import '../database/database.dart';

part 'providers.g.dart';

@riverpod
Database database(DatabaseRef ref) => Database.instance;
