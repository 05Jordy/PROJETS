import 'package:flutter/cupertino.dart';
import 'package:stock_lab/data/models/article_model.dart';
import 'package:stock_lab/data/repositories/article_repository.dart';

class ArticleProvider extends ChangeNotifier {
  final ArticleRepository repository = ArticleRepository();

  void createArticle(ArticleModel article) {
    repository.create(article);

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

  void getByCategorie(int categorieId) {
    repository.getByCategorie(categorieId);

    notifyListeners();
  }

  void serachArticles(String designation) {
    repository.search(designation);

    notifyListeners();
  }

  void getStockFaible() {
    repository.getStockFaible();

    notifyListeners();
  }

  void update(ArticleModel article) {
    repository.update(article);

    notifyListeners();
  }

  void addStock(int articleId, int quantite) {
    repository.addStock(articleId, quantite);

    notifyListeners();
  }

  void removeStock(int articleId, int quantite) {
    repository.removeStock(articleId, quantite);

    notifyListeners();
  }

  void deleteArticle(int id) {
    repository.delete(id);

    notifyListeners();
  }
}
