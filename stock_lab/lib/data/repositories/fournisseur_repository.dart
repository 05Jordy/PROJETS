import 'package:sqflite/sqflite.dart';
import '../datasource/datasource_helper.dart';
import '../models/fournisseur_model.dart';

class FournisseurRepository {
  final DataSourceHelper _dataSource = DataSourceHelper.instance;

  Future<int> create(FournisseurModel fournisseur) async {
    final db = await _dataSource.database;

    return await db.insert(
      'fournisseur',
      fournisseur.toMap(),
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }

  Future<FournisseurModel?> getById(int id) async {
    final db = await _dataSource.database;

    final result = await db.query(
      'fournisseur',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isEmpty) {
      return null;
    }

    return FournisseurModel.fromMap(result.first);
  }

  Future<List<FournisseurModel>> getAll() async {
    final db = await _dataSource.database;

    final result = await db.query(
      'fournisseur',
      orderBy: 'nom ASC, prenom ASC',
    );

    return result.map((map) => FournisseurModel.fromMap(map)).toList();
  }

  Future<List<FournisseurModel>> search(String query) async {
    final db = await _dataSource.database;

    final result = await db.query(
      'fournisseur',
      where: '''
        nom LIKE ?
        OR prenom LIKE ?
      ''',
      whereArgs: ['%$query%', '%$query%'],
      orderBy: 'nom ASC',
    );

    return result.map((map) => FournisseurModel.fromMap(map)).toList();
  }

  Future<int> update(FournisseurModel fournisseur) async {
    if (fournisseur.id == null) {
      throw ArgumentError('L\'id du fournisseur est obligatoire.');
    }

    final db = await _dataSource.database;

    return await db.update(
      'fournisseur',
      fournisseur.toMap(),
      where: 'id = ?',
      whereArgs: [fournisseur.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await _dataSource.database;

    return await db.delete('fournisseur', where: 'id = ?', whereArgs: [id]);
  }
}
