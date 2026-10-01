import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/order.dart';

class OrderStorage {
  static const String _ordersKey = 'orders';

  static Future<List<Order>> getOrders() async {
    final prefs = await SharedPreferences.getInstance();

    final List<String> savedOrders =
        prefs.getStringList(_ordersKey) ?? [];

    return savedOrders.map((orderJson) {
      final Map<String, dynamic> decoded =
          jsonDecode(orderJson);

      return Order.fromJson(decoded);
    }).toList();
  }

  static Future<void> saveOrder(Order order) async {
    final prefs = await SharedPreferences.getInstance();

    final List<String> savedOrders =
        prefs.getStringList(_ordersKey) ?? [];

    savedOrders.add(
      jsonEncode(order.toJson()),
    );

    await prefs.setStringList(
      _ordersKey,
      savedOrders,
    );
  }

  static Future<void> updateOrder(Order updatedOrder) async {
    final prefs = await SharedPreferences.getInstance();

    final List<Order> orders = await getOrders();

    final int index = orders.indexWhere(
      (order) => order.id == updatedOrder.id,
    );

    if (index == -1) {
      return;
    }

    orders[index] = updatedOrder;

    final List<String> encodedOrders = orders
        .map(
          (order) => jsonEncode(
            order.toJson(),
          ),
        )
        .toList();

    await prefs.setStringList(
      _ordersKey,
      encodedOrders,
    );
  }

  static Future<Order?> getOrderById(String id) async {
    final List<Order> orders = await getOrders();

    try {
      return orders.firstWhere(
        (order) => order.id == id,
      );
    } catch (_) {
      return null;
    }
  }

  static Future<void> clearOrders() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_ordersKey);
  }
}