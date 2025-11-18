import 'dart:async';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartController {
  final _cartItems = <CartItem>[];
  final _cartStream = StreamController<List<CartItem>>.broadcast();
  final _summaryStream = StreamController<CartSummary>.broadcast();

  Stream<List<CartItem>> get cartItemsStream => _cartStream.stream;
  Stream<CartSummary> get cartSummaryStream => _summaryStream.stream;

  void addToCart(Product product, int quantity) {
    final existing = _cartItems.where((e) => e.product.id == product.id).firstOrNull;
    if (existing != null) {
      existing.quantity += quantity;
    } else {
      _cartItems.add(CartItem(product: product, quantity: quantity));
    }
    _emit();
  }

  void removeFromCart(Product product) {
    _cartItems.removeWhere((e) => e.product.id == product.id);
    _emit();
  }

  void updateQuantity(Product product, int quantity) {
    final item = _cartItems.where((e) => e.product.id == product.id).firstOrNull;
    if (item != null) {
      item.quantity = quantity;
    }
    _emit();
  }

  void clear() {
    _cartItems.clear();
    _emit();
  }

  void _emit() {
    _cartStream.add(List.from(_cartItems));
    final subtotal = _cartItems.fold<double>(0, (p, e) => p + e.total);
    _summaryStream.add(CartSummary(subtotal: subtotal, delivery: subtotal > 0 ? 5 : 0));
  }

  void dispose() {
    _cartStream.close();
    _summaryStream.close();
  }
}

extension<E> on Iterable<E> {
  E? get firstOrNull => isEmpty ? null : first;
}
