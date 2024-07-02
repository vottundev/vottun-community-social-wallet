import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:social_wallet/models/db/shared_payment.dart';
import 'package:social_wallet/models/db/shared_payment_users.dart';

part 'shared_payment_response_model.freezed.dart';
part 'shared_payment_response_model.g.dart';

@freezed
class SharedPaymentResponseModel with _$SharedPaymentResponseModel {
  const factory SharedPaymentResponseModel({
    required SharedPayment sharedPayment,
    List<SharedPaymentUsers>? sharedPaymentUser
  }) = _SharedPaymentResponseModel;

  factory SharedPaymentResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SharedPaymentResponseModelFromJson(json);
}
