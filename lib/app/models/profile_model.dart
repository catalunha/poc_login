import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_model.freezed.dart';
part 'profile_model.g.dart';

@freezed
abstract class ProfileModel with _$ProfileModel {
  @JsonKey(includeIfNull: false)
  factory ProfileModel({
    required int id,
    required int user,
    String? nickname,
    String? name,
    String? photo,
    String? phone,
  }) = _ProfileModel;
  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);
}
