import 'package:flutter/services.dart';

TextInputFormatter passwordFormatter() {
  return FilteringTextInputFormatter.allow(
    RegExp(r'[a-zA-Z0-9!@#$%^&*()\-_=+<>?]'),
  );
}
