import 'package:active_lamp_exam/features/domain/entity/url_entity.dart';
import 'package:meta/meta.dart';

class UrlModel extends UrlEntity {
  UrlModel({
    @required isSuccess,
    @required message,
    value,
  }) : super(isSuccess: isSuccess, message: message, value: value);
}
