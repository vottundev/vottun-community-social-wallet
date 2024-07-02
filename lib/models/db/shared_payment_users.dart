import 'package:freezed_annotation/freezed_annotation.dart';

part 'shared_payment_users.freezed.dart';
part 'shared_payment_users.g.dart';

@freezed
class SharedPaymentUsers with _$SharedPaymentUsers {
  const factory SharedPaymentUsers({
    int? id,
    required int userId,
    required int sharedPaymentId,
    required String username,
    required String userAddress,
    required double userAmountToPay,
    required int hasPayed
  }) = _SharedPaymentUsers;

  factory SharedPaymentUsers.fromJson(Map<String, dynamic> json) =>
      _$SharedPaymentUsersFromJson(json);
}
