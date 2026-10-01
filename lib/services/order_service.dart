import '../models/order.dart';
import '../models/order_item.dart';
import 'order_storage.dart';

class OrderService {
  static Future<Order> createOrder({
    required List<Map<String, dynamic>> menuItems,
    required Map<String, int> cart,
    required String customerNotes,
    required String tableNumber,
  }) async {
    final selectedItems = menuItems.where((item) {
      final String name = item['name'];
      return (cart[name] ?? 0) > 0;
    }).toList();

    final orderItems = selectedItems.map((item) {
      final String name = item['name'];
      final double price = (item['price'] as num).toDouble();
      final int quantity = cart[name] ?? 0;

      return OrderItem(
        name: name.replaceAll('\n', ' '),
        price: price,
        quantity: quantity,
      );
    }).toList();

    final savedOrders = await OrderStorage.getOrders();

    final queueNumber = (savedOrders.length + 1)
        .toString()
        .padLeft(3, '0');

    final now = DateTime.now();

    final total = orderItems.fold<double>(
      0,
      (sum, item) => sum + item.subtotal,
    );

    final order = Order(
      id: now.millisecondsSinceEpoch.toString(),
      queueNumber: queueNumber,
      tableNumber: tableNumber,
      items: orderItems,
      customerNotes: customerNotes,
      total: total,
      status: 'Received',
      createdAt: now,
    );

    await OrderStorage.saveOrder(order);

    return order;
  }
}