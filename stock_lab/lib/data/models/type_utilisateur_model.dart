class TypeUtilisateurModel {
  final int? id;
  final String libelle;

  TypeUtilisateurModel({this.id, required this.libelle});

  Map<String, dynamic> toMap() {
    return {if (id != null) 'id': id, 'libelle': libelle};
  }

  factory TypeUtilisateurModel.fromMap(Map<String, dynamic> map) {
    return TypeUtilisateurModel(
      id: map['id'] as int?,
      libelle: map['libelle'] as String,
    );
  }

  TypeUtilisateurModel copyWith({int? id, String? libelle}) {
    return TypeUtilisateurModel(
      id: id ?? this.id,
      libelle: libelle ?? this.libelle,
    );
  }
}
