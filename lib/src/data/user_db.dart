import 'package:sqflite/sqflite.dart';
import 'package:tcc_ll/src/data/base_db.dart';
import 'package:tcc_ll/src/models/user_model.dart';

class UserDB {
  static const String tableSql = 'CREATE TABLE user $_tableName('
      'id INTEGER PRIMARY KEY, '
      'name TEXT, '
      'email TEXT, '
      'senha TEXT, '
      'telefone INTEGER, '
      'data DATETIME, '
      'responsavel BOOLEAN, )';

  static const String _tableName = 'user';

  Future<int> save(User user) async {
    final Database db = await createDatabase();
    Map<String, dynamic> contactMap = _toMap(user);
    return db.insert(_tableName, contactMap);
  }

  Future<List<User>> findAll() async {
    final Database db = await createDatabase();

    final List<Map<String, dynamic>> result = await db.query(_tableName);
    final List<User> users = [];
    for (Map<String, dynamic> row in result) {
      final User user =
          User(row['id'], row['name'], row['email'], row['senha'], row['telefone'], row['data'], row['responsavel']);
      users.add(user);
    }
    return users;
  }
}

Map<String, dynamic> _toMap(User user) {
  final Map<String, dynamic> userMap = Map();
  userMap['name'] = user.name;
  userMap['email'] = user.email;
  userMap['senha'] = user.senha;
  userMap['telefone'] = user.telefone;
  userMap['data'] = user.data;
  userMap['responsavel'] = user.responsavel;
  return userMap;
}
