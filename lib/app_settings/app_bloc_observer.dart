import 'dart:developer';

import 'package:flutter/foundation.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waterbucketsolver/app_settings/app_config.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    if (kDebugMode && AppConfig.blocLogging) {
      log('\x1B[34mType: \x1B[33m${bloc.runtimeType} \x1B[36m$event');
    }
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (kDebugMode && AppConfig.blocLogging) {
      log('\x1B[34mType: \x1B[33m${bloc.runtimeType} \x1B[36m$change');
    }
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (kDebugMode && AppConfig.blocLogging) {
      log('\x1B[34mType: \x1B[33m${bloc.runtimeType} \x1B[36m$transition');
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    if (kDebugMode && AppConfig.blocLogging) {
      log('\x1B[34mType: \x1B[33m${bloc.runtimeType} \x1B[36m$stackTrace');
    }
    super.onError(bloc, error, stackTrace);
  }
}
