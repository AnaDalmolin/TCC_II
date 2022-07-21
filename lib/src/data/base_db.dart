import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tcc_ll/src/data/user_db.dart';

Future<Database> createDatabase() async {
  final String path = join(await getDatabasesPath(), 'bytebank.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(UserDB.tableSql);
    },
    version: 1,
    // onDowngrade: onDatabaseDowngradeDelete toda vez que precisar limpar o banco de dados, é só subir uma versão
    // e depois desser a mesma para limpar o banco de dados
  );
}
