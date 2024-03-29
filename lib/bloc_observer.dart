import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_finder_app/core/util/logger.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    Logger.info('MyBlocObserver', 'onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    Logger.info('MyBlocObserver', 'onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    Logger.info('MyBlocObserver', 'onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    Logger.info('MyBlocObserver', 'onClose -- ${bloc.runtimeType}');
  }
}
