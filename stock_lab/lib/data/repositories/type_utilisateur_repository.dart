import 'package:sqflite/sqflite.dart';
import '../datasource/datasource_helper.dart';
import '../models/type_utilisateur_model.dart';

class TypeUtilisateurRepository {
  final DataSourceHelper _dataSource = DataSourceHelper.instance;

  Future<int> create(TypeUtilisateurModel type) async {
    final db = await _dataSource.database;

    return await db.insert(
      'type_utilisateur',
      type.toMap(),
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }

  Future<TypeUtilisateurModel?> getById(int id) async {
    final db = await _dataSource.database;

    final result = await db.query(
      'type_utilisateur',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isEmpty) {
      return null;
    }

    return TypeUtilisateurModel.fromMap(result.first);
  }

  Future<List<TypeUtilisateurModel>> getAll() async {
    final db = await _dataSource.database;

    final result = await db.query('type_utilisateur', orderBy: 'libelle ASC');

    return result.map((map) => TypeUtilisateurModel.fromMap(map)).toList();
  }

  Future<int> update(TypeUtilisateurModel type) async {
    if (type.id == null) {
      throw ArgumentError('L\'id du type utilisateur est obligatoire.');
    }

    final db = await _dataSource.database;

    return await db.update(
      'type_utilisateur',
      type.toMap(),
      where: 'id = ?',
      whereArgs: [type.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await _dataSource.database;

    return await db.delete(
      'type_utilisateur',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<bool> exists(int id) async {
    final db = await _dataSource.database;

    final result = await db.rawQuery(
      'SELECT 1 FROM type_utilisateur WHERE id = ? LIMIT 1',
      [id],
    );

    return result.isNotEmpty;
  }
}
