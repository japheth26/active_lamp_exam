part of 'convert_url_bloc.dart';

@immutable
abstract class ConvertUrlEvent extends Equatable {}

class GetConvertUrlEvent implements ConvertUrlEvent {
  final String url;

  GetConvertUrlEvent({@required this.url});

  @override
  List get props => [];
}

class ClearFieldsForConvertUrlEvent implements ConvertUrlEvent {
  @override
  List get props => [];
}
