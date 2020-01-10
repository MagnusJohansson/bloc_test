import 'package:bloc_test/model/station.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:bloc/bloc.dart';

import 'search_presets_event.dart';
import 'search_presets_state.dart';

class SearchPresetsBloc extends Bloc<SearchPresetsEvent, SearchPresetsState> {
  Future<Database> getDatabase() async {
    final String path = join(await getDatabasesPath(), "presets.db");
    return await openDatabase(path);
  }

  @override
  SearchPresetsState get initialState => InitialSearchPresetsState();

  @override
  Stream<SearchPresetsState> mapEventToState(
    SearchPresetsEvent event,
  ) async* {
    if (event is SearchPresets) {
      yield* _mapSearchPresetsToState(event.filter);
    }
    if (event is ClearSearch) {
      yield InitialSearchPresetsState();
    }
  }

  Stream<SearchPresetsState> _mapSearchPresetsToState(String filter) async* {
    yield SearchPresetsLoading();
    try {
      final stations = await searchStations(filter);
      yield SearchPresetsLoaded(stations);
    } catch (ex) {
      print("{$ex}");
      yield SearchPresetsError(ex);
    }
  }

  Future<List<Station>> searchStations(String filter) async {
    final db = await getDatabase();

    final List<Map<String, dynamic>> maps = await db.rawQuery(
        """SELECT Station.ID, Station.Name, Station.Source FROM Station
WHERE Station.Name LIKE '%""" +
            filter +
            """%' ORDER BY Station.Name COLLATE NOCASE ASC""");

    List<Station> list = List.generate(maps.length, (i) {
      return Station(
          id: maps[i]["ID"], name: maps[i]["Name"], source: maps[i]["Source"]);
    });

    // Works if returning a static list instead of a db query
    // List<Station> list = [
    //   Station(id: 1, name: "Test", source: ""),
    //   Station(id: 2, name: "Test 2", source: "")
    // ];

    return list;
  }
}
