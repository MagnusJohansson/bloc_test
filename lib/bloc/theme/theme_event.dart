import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'app_themes.dart';

@immutable
abstract class ThemeEvent extends Equatable {
  const ThemeEvent([List props = const <dynamic>[]]);
}

class ThemeChanged extends ThemeEvent {
  final AppTheme theme;
  final Brightness brightness;

  ThemeChanged({@required this.theme, @required this.brightness})
      : super([theme]);

  @override
  List<Object> get props => [];
}
