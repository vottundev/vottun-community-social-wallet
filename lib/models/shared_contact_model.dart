import 'package:freezed_annotation/freezed_annotation.dart';

part 'shared_contact_model.freezed.dart';
part 'shared_contact_model.g.dart';

@freezed
class SharedContactModel with _$SharedContactModel {
  const factory SharedContactModel({
    required int userId,
    required String contactName,
    required String userAddress,
    required String imagePath,
    String? paymentCurrency,
    required double amountToPay,
}) = _SharedContactModel;

  factory SharedContactModel.fromJson(Map<String, dynamic> json) =>
      _$SharedContactModelFromJson(json);
}
