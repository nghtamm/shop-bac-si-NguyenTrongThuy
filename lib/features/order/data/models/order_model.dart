import 'package:shop_bacsi_nguyentrongthuy/features/order/data/models/billing_model.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/data/models/line_item_model.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/data/models/shipping_model.dart';

class OrderModel {
  final int orderID;
  final String status;
  final String date;
  final String total;
  final String shippingTotal;
  final String orderKey;
  final BillingModel billing;
  final ShippingModel shipping;
  final String paymentMethod;
  final List<LineItemModel> lineItems;

  OrderModel({
    required this.orderID,
    required this.status,
    required this.date,
    required this.total,
    required this.shippingTotal,
    required this.orderKey,
    required this.billing,
    required this.shipping,
    required this.paymentMethod,
    required this.lineItems,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderID: json['id'] ?? 0,
      status: json['status'] ?? '',
      date: json['date_created'] ?? '',
      total: json['total'] ?? '0',
      shippingTotal: json['shipping_total'] ?? '0',
      orderKey: json['order_key'] ?? '',
      billing:
          json['billing'] != null && json['billing'] is Map<String, dynamic>
              ? BillingModel.fromJson(json['billing'])
              : BillingModel.empty(),
      shipping:
          json['shipping'] != null && json['shipping'] is Map<String, dynamic>
              ? ShippingModel.fromJson(json['shipping'])
              : ShippingModel.empty(),
      paymentMethod: json['payment_method'] ?? '',
      lineItems: json['line_items'] != null && json['line_items'] is List
          ? (json['line_items'] as List)
              .map((item) =>
                  LineItemModel.fromJson(item as Map<String, dynamic>))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': orderID,
      'status': status,
      'date_created': date,
      'total': total,
      'shipping_total': shippingTotal,
      'order_key': orderKey,
      'billing': billing.toJson(),
      'shipping': shipping.toJson(),
      'payment_method': paymentMethod,
      'line_items': lineItems.map((item) => item.toJson()).toList(),
    };
  }
}
