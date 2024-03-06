import 'package:freezed_annotation/freezed_annotation.dart';
part 'contactmodel.freezed.dart';

@freezed
class ContactModel with _$ContactModel {
  factory ContactModel({
    required String name,
    required String phone,
  }) = _ContactModel;
}
