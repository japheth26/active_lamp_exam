part of 'convert_url_bloc.dart';

@immutable
abstract class ConvertUrlState extends Equatable {}

class ConvertUrlInitial extends ConvertUrlState {}

class ConvertUrlLoading extends ConvertUrlState {}

class ConvertUrlError extends ConvertUrlState {
  final String message;

  ConvertUrlError({@required this.message});
}

class ConvertUrlSuccess extends ConvertUrlState {
  final String link;

  ConvertUrlSuccess({@required this.link});
}
