class FournisseurModel {
  final int? id;
  final String nom;
  final String? prenom;
  final String? contact;
  final String? email;
  final String? adresse;

  FournisseurModel({
    this.id,
    required this.nom,
    this.prenom,
    this.contact,
    this.email,
    this.adresse,
  });

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'nom': nom,
      'prenom': prenom,
      'contact': contact,
      'email': email,
      'adresse': adresse,
    };
  }

  factory FournisseurModel.fromMap(Map<String, dynamic> map) {
    return FournisseurModel(
      id: map['id'] as int?,
      nom: map['nom'] as String,
      prenom: map['prenom'] as String?,
      contact: map['contact'] as String?,
      email: map['email'] as String?,
      adresse: map['adresse'] as String?,
    );
  }

  FournisseurModel copyWith({
    int? id,
    String? nom,
    String? prenom,
    String? contact,
    String? email,
    String? adresse,
  }) {
    return FournisseurModel(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      prenom: prenom ?? this.prenom,
      contact: contact ?? this.contact,
      email: email ?? this.email,
      adresse: adresse ?? this.adresse,
    );
  }
}
