part of 'inflate_url_bloc.dart';

@immutable
abstract class InflateUrlState extends Equatable {}

class InflateUrlInitial extends InflateUrlState {}

class InflateUrlLoading extends InflateUrlState {}

class InflateUrlError extends InflateUrlState {
  final String message;

  InflateUrlError({@required this.message});
}

class InflateUrlSuccess extends InflateUrlState {
  final String link;

  InflateUrlSuccess({@required this.link});
}
