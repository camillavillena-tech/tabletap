import 'order_item.dart';

class Order {
  final String id;
  final String queueNumber;
  final String tableNumber;
  final List<OrderItem> items;
  final String customerNotes;
  final double total;
  final String status;
  final DateTime createdAt;

  Order({
    required this.id,
    required this.queueNumber,
    required this.tableNumber,
    required this.items,
    required this.customerNotes,
    required this.total,
    required this.status,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'queueNumber': queueNumber,
      'tableNumber': tableNumber,
      'items': items.map((item) => item.toJson()).toList(),
      'customerNotes': customerNotes,
      'total': total,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      queueNumber: json['queueNumber'],
      tableNumber: json['tableNumber'],
      items: (json['items'] as List)
          .map((item) => OrderItem.fromJson(item))
          .toList(),
      customerNotes: json['customerNotes'],
      total: (json['total'] as num).toDouble(),
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Order copyWith({
    String? id,
    String? queueNumber,
    String? tableNumber,
    List<OrderItem>? items,
    String? customerNotes,
    double? total,
    String? status,
    DateTime? createdAt,
  }) {
    return Order(
      id: id ?? this.id,
      queueNumber: queueNumber ?? this.queueNumber,
      tableNumber: tableNumber ?? this.tableNumber,
      items: items ?? this.items,
      customerNotes: customerNotes ?? this.customerNotes,
      total: total ?? this.total,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}