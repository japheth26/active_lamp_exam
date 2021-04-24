import 'package:active_lamp_exam/features/domain/entity/url_entity.dart';
import 'package:meta/meta.dart';

class UrlModel extends UrlEntity {
  UrlModel({
    @required isSuccess,
    @required message,
    value,
  }) : super(isSuccess: isSuccess, message: message, value: value);

  factory UrlModel.fromJson(Map<String, dynamic> json) {
    return UrlModel(
        isSuccess: json['isSuccess'],
        message: json['message'],
        value: json['value']);
  }

  Map<String, dynamic> toJson() {
    return {
      'isSuccess': isSuccess,
      'message': message,
      'value': value,
    };
  }
}
