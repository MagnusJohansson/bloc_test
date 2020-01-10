import 'package:bloc_test/model/folder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PresetsListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PresetsListViewState();
}

final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
    new GlobalKey<RefreshIndicatorState>();

class _PresetsListViewState extends State<PresetsListView> {
  Widget buildInitialInput(BuildContext context, String message) {
    return Column(children: <Widget>[
      Text(message),
      RaisedButton(
        child: Text("Load"),
        onPressed: () {},
      )
    ]);
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  List<bool> isSelected = [false];
  Widget buildPresetsListView(BuildContext context, List<Folder> presets) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      child: ListView.builder(
        itemCount: presets.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            key: PageStorageKey<Folder>(presets[index]),
            onExpansionChanged: (something) {
              print("changed");
            },
            title: Text(presets[index].name),
            children: [
              Text("Something"),
            ],
          );
        },
      ),
      onRefresh: () async {
        // BlocProvider.of<PresetsBloc>(context).add(GetFolders(-1));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text("Placeholder");
  }
}
