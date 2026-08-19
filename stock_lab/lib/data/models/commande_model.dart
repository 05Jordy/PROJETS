class CommandeModel {
  final int? id;
  final DateTime date;
  final int fournisseurId;

  CommandeModel({this.id, required this.date, required this.fournisseurId});

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'date': date.toIso8601String(),
      'fournisseur_id': fournisseurId,
    };
  }

  factory CommandeModel.fromMap(Map<String, dynamic> map) {
    return CommandeModel(
      id: map['id'] as int?,
      date: DateTime.parse(map['date'] as String),
      fournisseurId: map['fournisseur_id'] as int,
    );
  }

  CommandeModel copyWith({int? id, DateTime? date, int? fournisseurId}) {
    return CommandeModel(
      id: id ?? this.id,
      date: date ?? this.date,
      fournisseurId: fournisseurId ?? this.fournisseurId,
    );
  }
}
