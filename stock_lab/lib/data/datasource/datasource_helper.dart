import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataSourceHelper {
  static final DataSourceHelper instance = DataSourceHelper._internal();

  static Database? _database;

  DataSourceHelper._internal();

  factory DataSourceHelper() {
    return instance;
  }

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  static const String _databaseName = 'gestion_stock.db';
  static const int _databaseVersion = 1;

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE type_utilisateur (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        libelle TEXT NOT NULL UNIQUE
      )
    ''');

    await db.execute('''
      CREATE TABLE utilisateur (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nom TEXT NOT NULL,
        prenom TEXT NOT NULL,
        contact TEXT,
        email TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL,
        type_utilisateur_id INTEGER NOT NULL,

        FOREIGN KEY (type_utilisateur_id)
          REFERENCES type_utilisateur(id)
          ON UPDATE CASCADE
          ON DELETE RESTRICT
      )
    ''');

    await db.execute('''
      CREATE TABLE categorie (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        libelle TEXT NOT NULL,
        description TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE fournisseur (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nom TEXT NOT NULL,
        prenom TEXT,
        contact TEXT,
        email TEXT,
        adresse TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE article (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        designation TEXT NOT NULL,
        quantite INTEGER NOT NULL DEFAULT 0,
        prix_unitaire REAL NOT NULL DEFAULT 0,
        description TEXT,
        categorie_id INTEGER NOT NULL,

        FOREIGN KEY (categorie_id)
          REFERENCES categorie(id)
          ON UPDATE CASCADE
          ON DELETE RESTRICT
      )
    ''');

    await db.execute('''
      CREATE TABLE commande (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT NOT NULL,
        fournisseur_id INTEGER NOT NULL,

        FOREIGN KEY (fournisseur_id)
          REFERENCES fournisseur(id)
          ON UPDATE CASCADE
          ON DELETE RESTRICT
      )
    ''');

    await db.execute('''
      CREATE TABLE ligne_commande (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        commande_id INTEGER NOT NULL,
        article_id INTEGER NOT NULL,
        quantite INTEGER NOT NULL,
        prix_unitaire REAL NOT NULL,

        FOREIGN KEY (commande_id)
          REFERENCES commande(id)
          ON UPDATE CASCADE
          ON DELETE CASCADE,

        FOREIGN KEY (article_id)
          REFERENCES article(id)
          ON UPDATE CASCADE
          ON DELETE RESTRICT
      )
    ''');

    // INDEX

    await db.execute('''
      CREATE INDEX idx_utilisateur_type
      ON utilisateur(type_utilisateur_id)
    ''');

    await db.execute('''
      CREATE INDEX idx_article_categorie
      ON article(categorie_id)
    ''');

    await db.execute('''
      CREATE INDEX idx_commande_fournisseur
      ON commande(fournisseur_id)
    ''');

    await db.execute('''
      CREATE INDEX idx_ligne_commande
      ON ligne_commande(commande_id)
    ''');

    await db.execute('''
      CREATE INDEX idx_ligne_article
      ON ligne_commande(article_id)
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Les futures migrations seront ajoutées ici.
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null;
  }
}
