class ArticleModel {
  final int? id;
  final String designation;
  final int quantite;
  final double prixUnitaire;
  final String? description;
  final int categorieId;

  ArticleModel({
    this.id,
    required this.designation,
    required this.quantite,
    required this.prixUnitaire,
    this.description,
    required this.categorieId,
  });

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'designation': designation,
      'quantite': quantite,
      'prix_unitaire': prixUnitaire,
      'description': description,
      'categorie_id': categorieId,
    };
  }

  factory ArticleModel.fromMap(Map<String, dynamic> map) {
    return ArticleModel(
      id: map['id'] as int?,
      designation: map['designation'] as String,
      quantite: map['quantite'] as int,
      prixUnitaire: (map['prix_unitaire'] as num).toDouble(),
      description: map['description'] as String?,
      categorieId: map['categorie_id'] as int,
    );
  }

  ArticleModel copyWith({
    int? id,
    String? designation,
    int? quantite,
    double? prixUnitaire,
    String? description,
    int? categorieId,
  }) {
    return ArticleModel(
      id: id ?? this.id,
      designation: designation ?? this.designation,
      quantite: quantite ?? this.quantite,
      prixUnitaire: prixUnitaire ?? this.prixUnitaire,
      description: description ?? this.description,
      categorieId: categorieId ?? this.categorieId,
    );
  }
}
