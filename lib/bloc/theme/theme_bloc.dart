import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import './bloc.dart';
import 'app_themes.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  @override
  ThemeState get initialState => ThemeState(
      themeData: appThemeData[AppTheme.Green], brightness: Brightness.light);

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is ThemeChanged) {
      yield ThemeState(
          themeData: event.brightness == Brightness.dark
              ? appThemeDarkData[event.theme]
              : appThemeData[event.theme],
          brightness: event.brightness);
    }
  }
}
