import 'package:flutter/cupertino.dart';
import 'package:stock_lab/data/models/commande_model.dart';
import 'package:stock_lab/data/models/ligne_commande_model.dart';
import 'package:stock_lab/data/repositories/commande_repository.dart';

class CommandeProvider extends ChangeNotifier {
  final CommandeRepository repository = CommandeRepository();

  void create(CommandeModel commande, List<LigneCommandeModel> lignes) {
    repository.createCommande(commande: commande, lignes: lignes);

    notifyListeners();
  }

  void getById(int id) {
    repository.getById(id);

    notifyListeners();
  }

  void getLignes(int commandeId) {
    repository.getLignes(commandeId);

    notifyListeners();
  }

  void getCommandeComplete(int commandeId) {
    repository.getCommandeComplete(commandeId);

    notifyListeners();
  }

  void getByFournisseur(int fournisseurId) {
    repository.getByFournisseur(fournisseurId);

    notifyListeners();
  }

  void getTotal(int commandeId) {
    repository.getTotal(commandeId);

    notifyListeners();
  }

  void delete(int commandeId) {
    repository.delete(commandeId);

    notifyListeners();
  }
}
