import 'dart:async';
import '../data/mock_products.dart';
import '../models/product.dart';

class ProductController {
  final _homeBestController = StreamController<List<Product>>.broadcast();
  final _homeRecommendedController =
      StreamController<List<Product>>.broadcast();
  final _catalogController = StreamController<List<Product>>.broadcast();
  final _loadingController = StreamController<bool>.broadcast();
  final _paginatingController = StreamController<bool>.broadcast();
  final _comparisonController = StreamController<List<Product>>.broadcast();
  final _searchController = StreamController<List<Product>>.broadcast();

  int _page = 0;
  final int _pageSize = 6;
  final List<Product> _catalogBuffer = [];
  final List<Product> _comparison = [];

  Stream<List<Product>> get homeBestProductsStream => _homeBestController.stream;
  Stream<List<Product>> get homeRecommendedStream =>
      _homeRecommendedController.stream;
  Stream<List<Product>> get catalogProductsStream => _catalogController.stream;
  Stream<bool> get isLoadingStream => _loadingController.stream;
  Stream<bool> get isPaginatingStream => _paginatingController.stream;
  Stream<List<Product>> get comparisonSelectionStream =>
      _comparisonController.stream;
  Stream<List<Product>> get searchStream => _searchController.stream;

  Future<void> loadInitialHomeData() async {
    _loadingController.add(true);
    await Future.delayed(const Duration(milliseconds: 500));
    _homeBestController.add(mockProducts.where((e) => e.isBestSeller).toList());
    _homeRecommendedController.add(mockProducts.take(3).toList());
    _loadingController.add(false);
  }

  Future<void> refreshHomeData() => loadInitialHomeData();

  Future<void> refreshCatalog() async {
    _catalogBuffer.clear();
    _page = 0;
    await loadCatalogPage(0);
  }

  Future<void> loadCatalogPage(int pageIndex) async {
    if (pageIndex != _page && pageIndex != 0) return;
    _paginatingController.add(true);
    await Future.delayed(const Duration(milliseconds: 400));
    final start = _page * _pageSize;
    final next = mockProducts.skip(start).take(_pageSize).toList();
    _catalogBuffer.addAll(next);
    _catalogController.add(List.from(_catalogBuffer));
    _page++;
    _paginatingController.add(false);
  }

  void toggleFavorite(Product product) {
    product.isFavorite = !product.isFavorite;
    _homeBestController.add(mockProducts.where((e) => e.isBestSeller).toList());
    _catalogController.add(List.from(_catalogBuffer));
  }

  void toggleCompareSelection(Product product) {
    if (_comparison.any((p) => p.id == product.id)) {
      _comparison.removeWhere((p) => p.id == product.id);
    } else if (_comparison.length < 3) {
      _comparison.add(product);
    }
    _comparisonController.add(List.from(_comparison));
  }

  void clearComparison() {
    _comparison.clear();
    _comparisonController.add(List.from(_comparison));
  }

  void searchProducts(String query) {
    final lower = query.toLowerCase();
    final results = mockProducts.where((product) {
      return product.nameEn.toLowerCase().contains(lower) ||
          product.descriptionShortEn.toLowerCase().contains(lower) ||
          product.descriptionLongEn.toLowerCase().contains(lower) ||
          product.nameAr.contains(query) ||
          product.descriptionShortAr.contains(query) ||
          product.descriptionLongAr.contains(query) ||
          product.category.toLowerCase().contains(lower) ||
          product.tags.any((tag) => tag.toLowerCase().contains(lower));
    }).toList();
    _searchController.add(results);
  }

  void dispose() {
    _homeBestController.close();
    _homeRecommendedController.close();
    _catalogController.close();
    _loadingController.close();
    _paginatingController.close();
    _comparisonController.close();
    _searchController.close();
  }
}
