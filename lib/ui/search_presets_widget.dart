import 'package:bloc_test/bloc/searchpresets/bloc.dart';
import 'package:bloc_test/model/play_entry.dart';
import 'package:bloc_test/model/station.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';

class SearchPresetsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchPresetsPageState();
}

final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey2 =
    new GlobalKey<RefreshIndicatorState>();

final GlobalKey<ScaffoldState> scaffoldKey2 = new GlobalKey<ScaffoldState>();

final snackBar = SnackBar(
  content: Text('Added as a favorite'),
  action: SnackBarAction(
    label: 'Undo',
    onPressed: () {},
  ),
);

class _SearchPresetsPageState extends State<SearchPresetsPage> {
  final TextEditingController _filter = new TextEditingController();
  List<Station> stations = [];

  _textInputSearch() {
    if (_filter.text.length >= 2) {
      BlocProvider.of<SearchPresetsBloc>(context)
          .add(SearchPresets(_filter.text));
    }
  }

  @override
  void initState() {
    _filter.addListener(_textInputSearch);
    super.initState();
  }

  Widget buildInitialStationsInput(BuildContext context, String message) {
    return Column(children: <Widget>[
      Center(child: Text(message)),
    ]);
  }

  Widget buildLoading() {
    return Center(
      child: LinearProgressIndicator(
        value: null,
      ),
    );
  }

  Widget _buildListView() {
    return RefreshIndicator(
      key: _refreshIndicatorKey2,
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.grey[300],
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                "${stations.length} Stations:",
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: stations != null ? stations.length : 0,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    dense: true,
                    title: Text(stations[index].name),
                    leading: IconButton(
                      alignment: Alignment.center,
                      icon: Icon(Icons.play_arrow),
                      onPressed: () async {
                        playEntryStreamController.sink.add(PlayEntry(
                            url: stations[index].source, stationName: stations[index].name));

                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setString(
                            "latestUrl", stations[index].source);
                      },
                    ),
                    trailing: PopupMenuButton(
                      onSelected: (value) async {

                        // BlocProvider.of<FavoritesBloc>(context).add(
                        //     AddAsFavorite(Station(
                        //         id: stations[index].id,
                        //         name: stations[index].name,
                        //         source: stations[index].source)));

                        // scaffoldKey2.currentState.showSnackBar(snackBar);
                      },
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            value: 1,
                            child: Text("Add to favorites"),
                          ),
                        ];
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      onRefresh: () async {
        BlocProvider.of<SearchPresetsBloc>(context)
            .add(SearchPresets(_filter.text));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchPresetsBloc, SearchPresetsState>(
      listener: (BuildContext context, SearchPresetsState state) {},
      child: Scaffold(
        key: scaffoldKey2,
        appBar: AppBar(
          actions: <Widget>[],
          title: Container(
            color: Colors.white,
            child: TextField(
              controller: _filter,
              decoration: new InputDecoration(
                  filled: true,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _filter.clear();
                      setState(() {
                        stations = [];
                        BlocProvider.of<SearchPresetsBloc>(context)
                            .add(ClearSearch());
                      });
                    },
                  ),
                  prefixIcon: new Icon(Icons.search),
                  hintText: 'Search...'),
            ),
          ),
        ),
        body: BlocBuilder<SearchPresetsBloc, SearchPresetsState>(
            builder: (BuildContext context, SearchPresetsState state) {
          if (state is InitialSearchPresetsState) {
            return buildInitialStationsInput(context,
                "Search for stations in the search box above (at least 2 characters)");
          }
          if (state is SearchPresetsLoading) {
            return buildLoading();
          }
          if (state is SearchPresetsLoaded) {
            stations = state.stations;
            return _buildListView();
          }
          if (state is SearchPresetsError) {
            return buildInitialStationsInput(
                context, state.exception.toString());
          }
          return Container();
        }),
      ),
    );
  }
}
