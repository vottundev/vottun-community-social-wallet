import 'package:freezed_annotation/freezed_annotation.dart';

part 'problem_details_model.freezed.dart';
part 'problem_details_model.g.dart';

@freezed
class ProblemDetails with _$ProblemDetails {
  const factory ProblemDetails({
    Map<String, List<String>>? errors,
    required String type,
    required String title,
    required int status,
}) = _ProblemDetails;

  factory ProblemDetails.fromJson(Map<String, dynamic> json) =>
      _$ProblemDetailsFromJson(json);
}
