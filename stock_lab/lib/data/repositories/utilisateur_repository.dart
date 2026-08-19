import 'package:sqflite/sqflite.dart';
import '../datasource/datasource_helper.dart';
import '../models/utilisateur_model.dart';

class UtilisateurRepository {
  final DataSourceHelper _dataSource = DataSourceHelper.instance;

  Future<int> create(UtilisateurModel utilisateur) async {
    final db = await _dataSource.database;

    return await db.insert(
      'utilisateur',
      utilisateur.toMap(),
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }

  Future<UtilisateurModel?> getById(int id) async {
    final db = await _dataSource.database;

    final result = await db.query(
      'utilisateur',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isEmpty) {
      return null;
    }

    return UtilisateurModel.fromMap(result.first);
  }

  Future<List<UtilisateurModel>> getAll() async {
    final db = await _dataSource.database;

    final result = await db.query(
      'utilisateur',
      orderBy: 'nom ASC, prenom ASC',
    );

    return result.map((map) => UtilisateurModel.fromMap(map)).toList();
  }

  Future<List<UtilisateurModel>> getByType(int typeUtilisateurId) async {
    final db = await _dataSource.database;

    final result = await db.query(
      'utilisateur',
      where: 'type_utilisateur_id = ?',
      whereArgs: [typeUtilisateurId],
      orderBy: 'nom ASC, prenom ASC',
    );

    return result.map((map) => UtilisateurModel.fromMap(map)).toList();
  }

  Future<UtilisateurModel?> getByEmail(String email) async {
    final db = await _dataSource.database;

    final result = await db.query(
      'utilisateur',
      where: 'email = ?',
      whereArgs: [email],
      limit: 1,
    );

    if (result.isEmpty) {
      return null;
    }

    return UtilisateurModel.fromMap(result.first);
  }

  Future<UtilisateurModel?> authenticate(String email, String password) async {
    final db = await _dataSource.database;

    final result = await db.query(
      'utilisateur',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
      limit: 1,
    );

    if (result.isEmpty) {
      return throw ArgumentError('Utilisateur non trouvé');
    }

    return UtilisateurModel.fromMap(result.first);
  }

  Future<int> update(UtilisateurModel utilisateur) async {
    if (utilisateur.id == null) {
      throw ArgumentError('L\'id de l\'utilisateur est obligatoire.');
    }

    final db = await _dataSource.database;

    return await db.update(
      'utilisateur',
      utilisateur.toMap(),
      where: 'id = ?',
      whereArgs: [utilisateur.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await _dataSource.database;

    return await db.delete('utilisateur', where: 'id = ?', whereArgs: [id]);
  }
}
