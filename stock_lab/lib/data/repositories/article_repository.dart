import 'package:sqflite/sqflite.dart';
import '../datasource/datasource_helper.dart';
import '../models/article_model.dart';

class ArticleRepository {
  final DataSourceHelper _dataSource = DataSourceHelper.instance;

  Future<int> create(ArticleModel article) async {
    final db = await _dataSource.database;

    return await db.insert(
      'article',
      article.toMap(),
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }

  Future<ArticleModel?> getById(int id) async {
    final db = await _dataSource.database;

    final result = await db.query(
      'article',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isEmpty) {
      return null;
    }

    return ArticleModel.fromMap(result.first);
  }

  Future<List<ArticleModel>> getAll() async {
    final db = await _dataSource.database;

    final result = await db.query('article', orderBy: 'designation ASC');

    return result.map((map) => ArticleModel.fromMap(map)).toList();
  }

  Future<List<ArticleModel>> getByCategorie(int categorieId) async {
    final db = await _dataSource.database;

    final result = await db.query(
      'article',
      where: 'categorie_id = ?',
      whereArgs: [categorieId],
      orderBy: 'designation ASC',
    );

    return result.map((map) => ArticleModel.fromMap(map)).toList();
  }

  Future<List<ArticleModel>> search(String query) async {
    final db = await _dataSource.database;

    final result = await db.query(
      'article',
      where: 'designation LIKE ?',
      whereArgs: ['%$query%'],
      orderBy: 'designation ASC',
    );

    return result.map((map) => ArticleModel.fromMap(map)).toList();
  }

  Future<List<ArticleModel>> getStockFaible() async {
    final db = await _dataSource.database;
    int seuil = 10;

    final result = await db.query(
      'article',
      where: 'quantite <= ?',
      whereArgs: [seuil],
      orderBy: 'quantite ASC',
    );

    return result.map((map) => ArticleModel.fromMap(map)).toList();
  }

  Future<int> update(ArticleModel article) async {
    if (article.id == null) {
      throw ArgumentError('L\'id de l\'article est obligatoire.');
    }

    final db = await _dataSource.database;

    return await db.update(
      'article',
      article.toMap(),
      where: 'id = ?',
      whereArgs: [article.id],
    );
  }

  Future<int> addStock(int articleId, int quantite) async {
    if (quantite <= 0) {
      throw ArgumentError('La quantité ajoutée doit être supérieure à zéro.');
    }

    final db = await _dataSource.database;

    return await db.rawUpdate(
      '''
      UPDATE article
      SET quantite = quantite + ?
      WHERE id = ?
      ''',
      [quantite, articleId],
    );
  }

  Future<int> removeStock(int articleId, int quantite) async {
    if (quantite <= 0) {
      throw ArgumentError('La quantité retirée doit être supérieure à zéro.');
    }

    final db = await _dataSource.database;

    return await db.rawUpdate(
      '''
      UPDATE article
      SET quantite = quantite - ?
      WHERE id = ?
        AND quantite >= ?
      ''',
      [quantite, articleId, quantite],
    );
  }

  Future<int> delete(int id) async {
    final db = await _dataSource.database;

    return await db.delete('article', where: 'id = ?', whereArgs: [id]);
  }
}
