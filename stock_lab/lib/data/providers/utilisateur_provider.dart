import 'package:flutter/material.dart';
import 'package:stock_lab/data/models/utilisateur_model.dart';
import 'package:stock_lab/data/repositories/utilisateur_repository.dart';

class UtilisateurProvider extends ChangeNotifier {
  final UtilisateurRepository repository = UtilisateurRepository();

  void createUtilisateur(UtilisateurModel utilisateur) {
    repository.create(utilisateur);
    notifyListeners();
  }

  void getById(int id) {
    repository.getById(id);

    notifyListeners();
  }

  void getAll() {
    repository.getAll();

    notifyListeners();
  }

  void getByType(int typeUtilisateurId) {
    repository.getByType(typeUtilisateurId);

    notifyListeners();
  }

  void geyByEmail(String email) {
    repository.getByEmail(email);

    notifyListeners();
  }

  void authenticate(String email, String password) {
    repository.authenticate(email, password);

    notifyListeners();
  }

  void updateUtilisateur(UtilisateurModel utilisateur) {
    repository.update(utilisateur);

    notifyListeners();
  }

  void deleteUtilisateur(int id) {
    repository.delete(id);

    notifyListeners();
  }
}
