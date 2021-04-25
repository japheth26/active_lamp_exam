part of 'inflate_url_bloc.dart';

@immutable
abstract class InflateUrlEvent extends Equatable {}

class GetOriginalUrlEvent implements InflateUrlEvent {
  final String url;

  GetOriginalUrlEvent({@required this.url});
  @override
  List get props => [];
}

class ClearFieldsForInflateUrlEvent implements InflateUrlEvent {
  @override
  List get props => [];
}
