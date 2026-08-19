class UtilisateurModel {
  final int? id;
  final String nom;
  final String prenom;
  final String? contact;
  final String email;
  final String password;
  final int typeUtilisateurId;

  UtilisateurModel({
    this.id,
    required this.nom,
    required this.prenom,
    this.contact,
    required this.email,
    required this.password,
    required this.typeUtilisateurId,
  });

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'nom': nom,
      'prenom': prenom,
      'contact': contact,
      'email': email,
      'password': password,
      'type_utilisateur_id': typeUtilisateurId,
    };
  }

  factory UtilisateurModel.fromMap(Map<String, dynamic> map) {
    return UtilisateurModel(
      id: map['id'] as int?,
      nom: map['nom'] as String,
      prenom: map['prenom'] as String,
      contact: map['contact'] as String?,
      email: map['email'] as String,
      password: map['password'] as String,
      typeUtilisateurId: map['type_utilisateur_id'] as int,
    );
  }

  UtilisateurModel copyWith({
    int? id,
    String? nom,
    String? prenom,
    String? contact,
    String? email,
    String? password,
    int? typeUtilisateurId,
  }) {
    return UtilisateurModel(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      prenom: prenom ?? this.prenom,
      contact: contact ?? this.contact,
      email: email ?? this.email,
      password: password ?? this.password,
      typeUtilisateurId: typeUtilisateurId ?? this.typeUtilisateurId,
    );
  }
}
