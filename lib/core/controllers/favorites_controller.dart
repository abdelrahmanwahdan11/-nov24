import '../models/product.dart';

class FavoritesController {
  final List<Product> _favorites = [];
  final StreamController<List<Product>> _favoritesStream =
      StreamController<List<Product>>.broadcast();

  Stream<List<Product>> get favoritesStream => _favoritesStream.stream;

  void toggleFavorite(Product product) {
    if (_favorites.any((e) => e.id == product.id)) {
      _favorites.removeWhere((e) => e.id == product.id);
      product.isFavorite = false;
    } else {
      _favorites.add(product..isFavorite = true);
    }
    _favoritesStream.add(List.from(_favorites));
  }

  void dispose() {
    _favoritesStream.close();
  }
}
