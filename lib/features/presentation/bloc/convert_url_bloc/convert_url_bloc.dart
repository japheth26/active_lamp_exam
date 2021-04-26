import 'dart:async';

import 'package:active_lamp_exam/features/domain/usecases/get_short_url.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'convert_url_event.dart';
part 'convert_url_state.dart';

class ConvertUrlBloc extends Bloc<ConvertUrlEvent, ConvertUrlState> {
  final GetShortUrl getShortUrl;
  ConvertUrlBloc({@required GetShortUrl shortUrl})
      : assert(shortUrl != null),
        getShortUrl = shortUrl,
        super(ConvertUrlInitial());

  @override
  Stream<ConvertUrlState> mapEventToState(
    ConvertUrlEvent event,
  ) async* {
    if (event is GetConvertUrlEvent) {
      yield ConvertUrlLoading();
      final result = await getShortUrl.call(event.url);

      yield* result.fold((failure) async* {
        yield ConvertUrlError(message: failure);
      }, (urlEntity) async* {
        if (urlEntity.isSuccess) {
          yield ConvertUrlSuccess(inputUrl: event.url, link: urlEntity.value);
        } else {
          yield ConvertUrlError(message: urlEntity.message);
        }
      });
    } else if (event is ClearFieldsForConvertUrlEvent) {
      yield ConvertUrlLoading();
      yield ConvertUrlInitial();
    }
  }
}
