import 'package:flutter/cupertino.dart';
import 'package:stock_lab/data/models/fournisseur_model.dart';
import 'package:stock_lab/data/repositories/fournisseur_repository.dart';

class FournisseurProvider extends ChangeNotifier {
  final FournisseurRepository repository = FournisseurRepository();

  void createFournisseur(FournisseurModel fournisseur) {
    repository.create(fournisseur);

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

  void search(String query) {
    repository.search(query);

    notifyListeners();
  }

  void update(FournisseurModel fournisseur) {
    repository.update(fournisseur);

    notifyListeners();
  }

  void delete(int id) {
    repository.delete(id);

    notifyListeners();
  }
}
