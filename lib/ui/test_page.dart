import 'package:bloc_test/bloc/searchpresets/bloc.dart';
import 'package:bloc_test/model/station.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TestPageState();
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

class _TestPageState extends State<TestPage> {
  final TextEditingController _filter = new TextEditingController();
  List<Station> stations = [];

  _textInputValue() {
    if (_filter.text.length >= 2) {
      BlocProvider.of<SearchPresetsBloc>(context)
          .add(SearchPresets(_filter.text));
    }
  }

  @override
  void initState() {
    _filter.addListener(_textInputValue);
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
                        scaffoldKey2.currentState.showSnackBar(snackBar);
                      },
                    ),
                    trailing: PopupMenuButton(
                      onSelected: (value) {
                        scaffoldKey2.currentState.showSnackBar(snackBar);
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
    stations = [Station(id: 1, name: "test", source: "")];

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
          return _buildListView();
        }),
      ),
    );
  }
}
