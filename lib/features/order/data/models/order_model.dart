class OrderModel {
  final int orderID;
  final String status;
  final String date;
  final String total;
  final String shippingTotal;
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
      'billing': billing.toJson(),
      'shipping': shipping.toJson(),
      'payment_method': paymentMethod,
      'line_items': lineItems.map((item) => item.toJson()).toList(),
    };
  }
}

class BillingModel {
  final String firstName;
  final String lastName;
  final String address1;
  final String address2;
  final String city;
  final String state;
  final String country;
  final String email;
  final String phone;

  BillingModel({
    required this.firstName,
    required this.lastName,
    required this.address1,
    required this.address2,
    required this.city,
    required this.state,
    required this.country,
    required this.email,
    required this.phone,
  });

  factory BillingModel.fromJson(Map<String, dynamic> json) {
    return BillingModel(
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      address1: json['address_1'] ?? '',
      address2: json['address_2'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? 'Việt Nam',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'address_1': address1,
      'address_2': address2,
      'city': city,
      'state': state,
      'country': country,
      'email': email,
      'phone': phone,
    };
  }

  static BillingModel empty() {
    return BillingModel(
      firstName: '',
      lastName: '',
      address1: '',
      address2: '',
      city: '',
      state: '',
      country: 'Việt Nam',
      email: '',
      phone: '',
    );
  }
}

class ShippingModel {
  final String firstName;
  final String lastName;
  final String address1;
  final String address2;
  final String city;
  final String state;
  final String country;
  final String email;
  final String phone;

  ShippingModel({
    required this.firstName,
    required this.lastName,
    required this.address1,
    required this.address2,
    required this.city,
    required this.state,
    required this.country,
    required this.email,
    required this.phone,
  });

  factory ShippingModel.fromJson(Map<String, dynamic> json) {
    return ShippingModel(
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      address1: json['address_1'] ?? '',
      address2: json['address_2'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? 'Việt Nam',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'address_1': address1,
      'address_2': address2,
      'city': city,
      'state': state,
      'country': country,
      'email': email,
      'phone': phone,
    };
  }

  static ShippingModel empty() {
    return ShippingModel(
      firstName: '',
      lastName: '',
      address1: '',
      address2: '',
      city: '',
      state: '',
      country: 'Việt Nam',
      email: '',
      phone: '',
    );
  }
}

class LineItemModel {
  final int id;
  final String name;
  final int productID;
  final int variationID;
  final String subtotal;
  final String total;
  final double price;
  final String image;

  LineItemModel({
    required this.id,
    required this.name,
    required this.productID,
    required this.variationID,
    required this.subtotal,
    required this.total,
    required this.price,
    required this.image,
  });

  factory LineItemModel.fromJson(Map<String, dynamic> json) {
    return LineItemModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      productID: json['product_id'] ?? 0,
      variationID: json['variation_id'] ?? 0,
      subtotal: json['subtotal'] ?? '0',
      total: json['total'] ?? '0',
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      image: (json['image'] != null && json['image'] is Map<String, dynamic>)
          ? (json['image']['src'] ?? '')
          : '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'product_id': productID,
      'variation_id': variationID,
      'subtotal': subtotal,
      'total': total,
      'price': price,
      'image': image,
    };
  }
}
