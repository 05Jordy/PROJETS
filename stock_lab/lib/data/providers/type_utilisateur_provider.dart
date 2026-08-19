import 'package:flutter/cupertino.dart';
import 'package:stock_lab/data/models/type_utilisateur_model.dart';
import 'package:stock_lab/data/repositories/type_utilisateur_repository.dart';

class TypeUtilisateurProvider extends ChangeNotifier {
  final TypeUtilisateurRepository repository = TypeUtilisateurRepository();

  void create(TypeUtilisateurModel type) {
    repository.create(type);

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

  void update(TypeUtilisateurModel type) {
    repository.update(type);

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
