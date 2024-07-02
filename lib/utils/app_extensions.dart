import 'dart:ui';


extension FormatDate on String {


  String toDate() {
    return "";
  }
}
extension FormatString on DateTime {


  DateTime toDate(String text) {
    return DateTime.now();
  }
}
extension ColorExtension on String {
  toColor() {
    var hexColor = replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}

