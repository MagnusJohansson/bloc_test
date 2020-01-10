import 'package:bloc_test/model/station.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SearchPresetsState extends Equatable {
  const SearchPresetsState();
}

class InitialSearchPresetsState extends SearchPresetsState {
  InitialSearchPresetsState() : super();

  @override
  List<Object> get props => [];
}

class SearchPresetsLoading extends SearchPresetsState {
  SearchPresetsLoading() : super();
  @override
  List<Object> get props => [];
}

class SearchPresetsLoaded extends SearchPresetsState {
  final List<Station> stations;

  SearchPresetsLoaded(this.stations) : super();
  @override
  List<Object> get props => [stations];
}

class SearchPresetsError extends SearchPresetsState {
  final Exception exception;
  SearchPresetsError(this.exception) : super();
  @override
  List<Object> get props => [exception];
}
