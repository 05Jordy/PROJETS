class CategorieModel {
  final int? id;
  final String libelle;
  final String? description;

  CategorieModel({this.id, required this.libelle, this.description});

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'libelle': libelle,
      'description': description,
    };
  }

  factory CategorieModel.fromMap(Map<String, dynamic> map) {
    return CategorieModel(
      id: map['id'] as int?,
      libelle: map['libelle'] as String,
      description: map['description'] as String?,
    );
  }

  CategorieModel copyWith({int? id, String? libelle, String? description}) {
    return CategorieModel(
      id: id ?? this.id,
      libelle: libelle ?? this.libelle,
      description: description ?? this.description,
    );
  }
}
