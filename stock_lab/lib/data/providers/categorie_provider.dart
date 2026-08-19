import 'package:flutter/material.dart';
import 'package:stock_lab/data/models/categorie_model.dart';
import 'package:stock_lab/data/repositories/categorie_repository.dart';

class CategorieProvider extends ChangeNotifier {
  final CategorieRepository repository = CategorieRepository();

  void createCategorie(CategorieModel categorie) {
    repository.create(categorie);

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

  void update(CategorieModel categorie) {
    repository.update(categorie);

    notifyListeners();
  }

  void delete(int id) {
    repository.delete(id);

    notifyListeners();
  }

  void exists(int id) {
    repository.exists(id);

    notifyListeners();
  }
}
