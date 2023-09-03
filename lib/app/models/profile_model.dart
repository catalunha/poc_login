import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_model.freezed.dart';
part 'profile_model.g.dart';

@freezed
abstract class ProfileModel with _$ProfileModel {
  @JsonKey(includeIfNull: false)
  factory ProfileModel({
    required int id,
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'username') required String userName,
    String? name,
  }) = _ProfileModel;
  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);
}
