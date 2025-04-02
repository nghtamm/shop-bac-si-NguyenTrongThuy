import 'package:diacritic/diacritic.dart';

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
}
