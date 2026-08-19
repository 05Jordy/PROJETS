import '../datasource/datasource_helper.dart';
import '../models/commande_model.dart';
import '../models/ligne_commande_model.dart';

class CommandeRepository {
  final DataSourceHelper _dataSource = DataSourceHelper.instance;

  // CREER UNE COMMANDE AVEC SES LIGNES
  Future<int> createCommande({
    required CommandeModel commande,
    required List<LigneCommandeModel> lignes,
  }) async {
    if (lignes.isEmpty) {
      throw ArgumentError('Une commande doit contenir au moins une ligne.');
    }

    final db = await _dataSource.database;

    return await db.transaction<int>((txn) async {
      // Création de la commande
      final commandeId = await txn.insert('commande', commande.toMap());

      // Création des lignes
      for (final ligne in lignes) {
        if (ligne.quantite <= 0) {
          throw ArgumentError('La quantité doit être supérieure à zéro.');
        }

        if (ligne.prixUnitaire < 0) {
          throw ArgumentError('Le prix unitaire ne peut pas être négatif.');
        }

        await txn.insert('ligne_commande', {
          'commande_id': commandeId,
          'article_id': ligne.articleId,
          'quantite': ligne.quantite,
          'prix_unitaire': ligne.prixUnitaire,
        });

        // Une commande fournisseur augmente le stock.
        await txn.rawUpdate(
          '''
          UPDATE article
          SET quantite = quantite + ?
          WHERE id = ?
          ''',
          [ligne.quantite, ligne.articleId],
        );
      }

      return commandeId;
    });
  }

  // RECUPERER UNE COMMANDE

  Future<CommandeModel?> getById(int id) async {
    final db = await _dataSource.database;

    final result = await db.query(
      'commande',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isEmpty) {
      return null;
    }

    return CommandeModel.fromMap(result.first);
  }

  // RECUPERER LES LIGNES D'UNE COMMANDE

  Future<List<LigneCommandeModel>> getLignes(int commandeId) async {
    final db = await _dataSource.database;

    final result = await db.query(
      'ligne_commande',
      where: 'commande_id = ?',
      whereArgs: [commandeId],
      orderBy: 'id ASC',
    );

    return result.map((map) => LigneCommandeModel.fromMap(map)).toList();
  }

  // RECUPERER UNE COMMANDE AVEC SES LIGNES

  Future<Map<String, dynamic>?> getCommandeComplete(int commandeId) async {
    final commande = await getById(commandeId);

    if (commande == null) {
      return null;
    }

    final lignes = await getLignes(commandeId);

    return {'commande': commande, 'lignes': lignes};
  }

  // RECUPERER TOUTES LES COMMANDES
  Future<List<CommandeModel>> getAll() async {
    final db = await _dataSource.database;

    final result = await db.query('commande', orderBy: 'date DESC');

    return result.map((map) => CommandeModel.fromMap(map)).toList();
  }

  // RECUPERER LES COMMANDES D'UN FOURNISSEUR
  Future<List<CommandeModel>> getByFournisseur(int fournisseurId) async {
    final db = await _dataSource.database;

    final result = await db.query(
      'commande',
      where: 'fournisseur_id = ?',
      whereArgs: [fournisseurId],
      orderBy: 'date DESC',
    );

    return result.map((map) => CommandeModel.fromMap(map)).toList();
  }

  // CALCULER LE TOTAL D'UNE COMMANDE
  Future<double> getTotal(int commandeId) async {
    final db = await _dataSource.database;

    final result = await db.rawQuery(
      '''
      SELECT COALESCE(
        SUM(quantite * prix_unitaire),
        0
      ) AS total
      FROM ligne_commande
      WHERE commande_id = ?
      ''',
      [commandeId],
    );

    return (result.first['total'] as num).toDouble();
  }

  // SUPPRIMER UNE COMMANDE
  Future<void> delete(int commandeId) async {
    final db = await _dataSource.database;

    await db.transaction((txn) async {
      final lignes = await txn.query(
        'ligne_commande',
        where: 'commande_id = ?',
        whereArgs: [commandeId],
      );

      // On retire du stock les quantités précédemment ajoutées.
      for (final ligne in lignes) {
        final articleId = ligne['article_id'] as int;
        final quantite = ligne['quantite'] as int;

        final result = await txn.rawUpdate(
          '''
          UPDATE article
          SET quantite = quantite - ?
          WHERE id = ?
            AND quantite >= ?
          ''',
          [quantite, articleId, quantite],
        );

        if (result == 0) {
          throw Exception(
            'Impossible de supprimer la commande : '
            'stock insuffisant pour annuler une ligne.',
          );
        }
      }

      await txn.delete('commande', where: 'id = ?', whereArgs: [commandeId]);
    });
  }
}
