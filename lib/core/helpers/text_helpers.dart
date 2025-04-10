import 'package:diacritic/diacritic.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:intl/intl.dart';

class TextHelpers {
  String formatUserLogin(String text) {
    return removeDiacritics(text.toLowerCase());
  }

  String formatUserNicename(String text) {
    String nicename = removeDiacritics(text.toLowerCase());
    nicename = nicename.replaceAll(RegExp(r'\s+'), '-');
    return nicename;
  }

  String formatDisplayName(String text) {
    return text.trim().split(' ').last.toUpperCase();
  }

  bool validateEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  bool validatePassword(String password) {
    return password.length >= 8;
  }

  bool validatePhoneNumber(String phoneNumber) {
    return phoneNumber.length == 10;
  }

  String formatHTML(String text) {
    final document = html_parser.parse(text);
    return document.body?.text.trim() ?? '';
  }

  String formatVNCurrency(dynamic price) {
    final numberFormat = NumberFormat.decimalPattern('vi_VN');
    final value = double.tryParse(price.toString()) ?? 0;
    return '${numberFormat.format(value)}₫';
  }
}
