import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class UrlEntity extends Equatable {
  final bool isSuccess;
  final String message;
  final String value;

  UrlEntity({
    @required this.isSuccess,
    @required this.message,
    this.value,
  });
}
