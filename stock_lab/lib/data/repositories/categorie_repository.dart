import 'package:sqflite/sqflite.dart';
import '../datasource/datasource_helper.dart';
import '../models/categorie_model.dart';

class CategorieRepository {
  final DataSourceHelper _dataSource = DataSourceHelper.instance;

  Future<int> create(CategorieModel categorie) async {
    final db = await _dataSource.database;

    return await db.insert(
      'categorie',
      categorie.toMap(),
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }

  Future<CategorieModel?> getById(int id) async {
    final db = await _dataSource.database;

    final result = await db.query(
      'categorie',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isEmpty) {
      return null;
    }

    return CategorieModel.fromMap(result.first);
  }

  Future<List<CategorieModel>> getAll() async {
    final db = await _dataSource.database;

    final result = await db.query('categorie', orderBy: 'libelle ASC');

    return result.map((map) => CategorieModel.fromMap(map)).toList();
  }

  Future<int> update(CategorieModel categorie) async {
    if (categorie.id == null) {
      throw ArgumentError('L\'id de la catégorie est obligatoire.');
    }

    final db = await _dataSource.database;

    return await db.update(
      'categorie',
      categorie.toMap(),
      where: 'id = ?',
      whereArgs: [categorie.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await _dataSource.database;

    return await db.delete('categorie', where: 'id = ?', whereArgs: [id]);
  }

  Future<bool> exists(int id) async {
    final db = await _dataSource.database;

    final result = await db.query(
      'categorie',
      columns: ['id'],
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    return result.isNotEmpty;
  }
}
