import 'dart:async';
import '../models/product.dart';
import 'product_controller.dart';

class SearchController {
  final ProductController productController;
  final StreamController<List<Product>> _resultsStream =
      StreamController.broadcast();

  SearchController(this.productController) {
    productController.searchStream.listen((event) {
      _resultsStream.add(event);
    });
  }

  Stream<List<Product>> get resultsStream => _resultsStream.stream;

  void search(String query) => productController.searchProducts(query);

  void dispose() {
    _resultsStream.close();
  }
}
