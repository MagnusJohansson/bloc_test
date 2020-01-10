import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SearchPresetsEvent extends Equatable {
  const SearchPresetsEvent();
}

class SearchPresets extends SearchPresetsEvent {
  final String filter;

  SearchPresets(String this.filter) : super();

  @override
  List<Object> get props => [];
}

class ClearSearch extends SearchPresetsEvent {
  ClearSearch() : super();
  
  @override
  List<Object> get props => [];
}
