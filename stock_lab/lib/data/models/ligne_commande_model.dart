class LigneCommandeModel {
  final int? id;
  final int commandeId;
  final int articleId;
  final int quantite;
  final double prixUnitaire;

  LigneCommandeModel({
    this.id,
    required this.commandeId,
    required this.articleId,
    required this.quantite,
    required this.prixUnitaire,
  });

  double get montantTotal {
    return quantite * prixUnitaire;
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'commande_id': commandeId,
      'article_id': articleId,
      'quantite': quantite,
      'prix_unitaire': prixUnitaire,
    };
  }

  factory LigneCommandeModel.fromMap(Map<String, dynamic> map) {
    return LigneCommandeModel(
      id: map['id'] as int?,
      commandeId: map['commande_id'] as int,
      articleId: map['article_id'] as int,
      quantite: map['quantite'] as int,
      prixUnitaire: (map['prix_unitaire'] as num).toDouble(),
    );
  }

  LigneCommandeModel copyWith({
    int? id,
    int? commandeId,
    int? articleId,
    int? quantite,
    double? prixUnitaire,
  }) {
    return LigneCommandeModel(
      id: id ?? this.id,
      commandeId: commandeId ?? this.commandeId,
      articleId: articleId ?? this.articleId,
      quantite: quantite ?? this.quantite,
      prixUnitaire: prixUnitaire ?? this.prixUnitaire,
    );
  }
}
