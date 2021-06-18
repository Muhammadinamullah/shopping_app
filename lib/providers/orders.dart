import 'package:flutter_complete_guide/providers/cart.dart';
import 'package:http/http.dart' as http;

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dataTime;

  OrderItem(
      {@required this.id,
      @required this.amount,
      @required this.products,
      @required this.dataTime});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartProduct, double total) async {
    final url = Uri.parse(
        'https://products-items-default-rtdb.firebaseio.com/products.json');
    _orders.insert(
        0,
        OrderItem(
            id: DateTime.now().toString(),
            amount: total,
            products: cartProduct,
            dataTime: DateTime.now()));
    notifyListeners();
  }
}
