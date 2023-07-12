import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:westminster_confession/utils/constants.dart';

// Bookmarks database helper

class BMProvider {
  final String _dbName = Constants.BM_DBNAME;
  final String _dbTable = Constants.BM_TBNAME;

  static final BMProvider _instance = BMProvider.internal();

  factory BMProvider() {
    return _instance;
  }

  static dynamic _database;

  Future<Database> get db async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  BMProvider.internal();

  Future close() async {
    return _database.close();
  }

  Future<Database> initDB() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, _dbName);

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) async {},
      onCreate: (Database db, int version) async {
        // Create the note table
        await db.execute('''
                CREATE TABLE IF NOT EXISTS $_dbTable (
                    id INTEGER PRIMARY KEY,
                    title TEXT DEFAULT '',
                    subtitle TEXT DEFAULT '',
                    detail TEXT DEFAULT '',
                    page TEXT DEFAULT ''
                )
            ''');
      },
    );
  }
}
