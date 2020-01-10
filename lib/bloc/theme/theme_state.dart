import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
class ThemeState extends Equatable {
  final ThemeData themeData;
  final Brightness brightness;

  ThemeState({@required this.themeData, @required this.brightness})
      //:  super([themeData, brightness]);
      :  super();

  @override
  List<Object> get props => [];
}
