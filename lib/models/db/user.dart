import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    int? id,
    String? vottunId,
    int? strategy,
    required String userEmail,
    String? username,
    String? password,
    required String accountHash,
    required int creationTimestamp,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);
}
