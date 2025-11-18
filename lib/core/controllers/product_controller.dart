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
  List<Product> _catalogSource = List.from(mockProducts);
  final List<Product> _comparison = [];
  double? _minPrice;
  double? _maxPrice;
  List<String> _selectedCategories = [];
  bool _hasMore = true;
  bool _isPaginating = false;

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
    _hasMore = true;
    _catalogSource = _applyCurrentFilters();
    await loadNextCatalogPage(reset: true);
  }

  Future<void> loadNextCatalogPage({bool reset = false}) async {
    if (_isPaginating || !_hasMore) return;
    _isPaginating = true;
    _paginatingController.add(true);
    await Future.delayed(const Duration(milliseconds: 400));
    if (reset) {
      _catalogBuffer.clear();
      _page = 0;
    }
    final start = _page * _pageSize;
    final next = _catalogSource.skip(start).take(_pageSize).toList();
    _catalogBuffer.addAll(next);
    _catalogController.add(List.from(_catalogBuffer));
    _page++;
    if (next.length < _pageSize || _catalogBuffer.length >= _catalogSource.length) {
      _hasMore = false;
    }
    _paginatingController.add(false);
    _isPaginating = false;
  }

  void applyFilters({double? minPrice, double? maxPrice, List<String>? categories}) {
    _minPrice = minPrice;
    _maxPrice = maxPrice;
    _selectedCategories = categories ?? [];
    _catalogSource = _applyCurrentFilters();
    _hasMore = true;
    loadNextCatalogPage(reset: true);
  }

  List<Product> _applyCurrentFilters() {
    return mockProducts.where((product) {
      final matchesPrice = (_minPrice == null || product.price >= _minPrice!) &&
          (_maxPrice == null || product.price <= _maxPrice!);
      final matchesCategory = _selectedCategories.isEmpty ||
          _selectedCategories.contains(product.category);
      return matchesPrice && matchesCategory;
    }).toList();
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
