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
