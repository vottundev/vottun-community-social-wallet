import 'dart:convert';

enum Flavor { prod, dev }

class AppConfiguration {

  String? localLanguage;

  AppConfiguration(this.localLanguage);

  factory AppConfiguration.fromJson(dynamic data) {
    var json = jsonEncode(data);
    var decode = jsonDecode(json);
    var map = decode as Map<String, dynamic>;

    return AppConfiguration(
      map["localLanguage"] ?? "en",
    );

  }
}