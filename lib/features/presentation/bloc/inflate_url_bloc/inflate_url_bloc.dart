import 'dart:async';

import 'package:active_lamp_exam/features/domain/entity/url_entity.dart';
import 'package:active_lamp_exam/features/domain/usecases/get_original_url.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'inflate_url_event.dart';
part 'inflate_url_state.dart';

class InflateUrlBloc extends Bloc<InflateUrlEvent, InflateUrlState> {
  final GetOriginalUrl getOriginalUrl;
  InflateUrlBloc({@required GetOriginalUrl inflateUrl})
      : assert(inflateUrl != null),
        getOriginalUrl = inflateUrl,
        super(InflateUrlInitial());

  @override
  Stream<InflateUrlState> mapEventToState(
    InflateUrlEvent event,
  ) async* {
    if (event is GetOriginalUrlEvent) {
      yield InflateUrlLoading();
      final result = await getOriginalUrl.call(event.url);

      yield* result.fold((failure) async* {
        yield InflateUrlError(message: failure);
      }, (urlEntity) async* {
        if (urlEntity.isSuccess) {
          yield InflateUrlSuccess(link: urlEntity.value);
        } else {
          yield InflateUrlError(message: urlEntity.message);
        }
      });
    } else if (event is ClearFieldsForInflateUrlEvent) {
      yield InflateUrlLoading();
      yield InflateUrlInitial();
    }
  }
}
