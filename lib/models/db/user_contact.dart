import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_contact.freezed.dart';
part 'user_contact.g.dart';

@freezed
class UserContact with _$UserContact {
  const factory UserContact({
    int? id,
    String? vottunId,
    int? userId,
    required String email,
    required String username,
    String? address
  }) = _UserContact;

  factory UserContact.fromJson(Map<String, dynamic> json) =>
      _$UserContactFromJson(json);
}
