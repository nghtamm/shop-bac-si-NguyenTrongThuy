import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/entities/billing_entity.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/entities/line_item_entity.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/entities/shipping_entity.dart';

class OrderEntity {
  final int orderID;
  final String status;
  final String date;
  final String total;
  final String shippingTotal;
  final BillingEntity billing;
  final ShippingEntity shipping;
  final String paymentMethod;
  final List<LineItemEntity> lineItems;

  OrderEntity({
    required this.orderID,
    required this.status,
    required this.date,
    required this.total,
    required this.shippingTotal,
    required this.billing,
    required this.shipping,
    required this.paymentMethod,
    required this.lineItems,
  });
}
