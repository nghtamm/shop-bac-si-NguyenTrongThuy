import 'package:diacritic/diacritic.dart';
import 'package:html/parser.dart' as html_parser;

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

  String formatHTML(String text) {
    final document = html_parser.parse(text);
    return document.body?.text.trim() ?? '';
  }
}
