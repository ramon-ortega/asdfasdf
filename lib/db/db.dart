import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class DB {

  DB._internal();
  static final DB _instance = DB._internal();
  static DB get instance => _instance;

  DatabaseClient? _database;
  DatabaseClient? get database => _database;

  Future<void> init() async {
    const String dbName = "flutter_avanzado.db";

    final dir = await getApplicationDocumentsDirectory();

    await dir.create(recursive: true);

    final String dbPath = join(dir.path, dbName);

    _database = await databaseFactoryIo.openDatabase(dbPath);
  }
}
