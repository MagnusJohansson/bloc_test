import 'dart:async';

import 'package:bloc_test/bloc/searchpresets/bloc.dart';
import 'package:bloc_test/model/folder.dart';
import 'package:bloc_test/model/play_entry.dart';
import 'package:bloc_test/ui/search_presets_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../init.dart';
import 'about_page.dart';
import 'preference_page.dart';
import 'presets_list_widget.dart';

final playEntryStreamController = StreamController<PlayEntry>.broadcast();
final albumArtStreamController = StreamController<String>.broadcast();

final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

Future<void> getAndSetTheme(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text('Bloc Test');
  bool hasNavigatedToSearchResult = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    var init = Init();
    init.doInit();
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      getAndSetTheme(context);
    }
  }

  final tabBar = new TabBar(
    tabs: <Widget>[
      new Tab(
        //icon: Icon(Icons.list),
        text: "Presets",
      ),
      new Tab(
        //icon: Icon(Icons.favorite),
        text: "Favorites",
      )
    ],
  );

  final BorderRadiusGeometry radius = BorderRadius.only(
    topLeft: Radius.circular(16.0),
    topRight: Radius.circular(16.0),
  );

  void _searchPressed(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider<SearchPresetsBloc>(
                      create: (BuildContext context) => SearchPresetsBloc()),
                ], child: SearchPresetsPage())));
  }

  @override
  Widget build(BuildContext context) {
    double bottomPadding = 0;

    return SlidingUpPanel(
        backdropEnabled: true,
        panel: Text("Panel"),
        collapsed: Scaffold(body: Text("Collapsed")),
        color: Theme.of(context).dialogBackgroundColor,
        borderRadius: radius,
        body: DefaultTabController(
            length: 2,
            child: Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                title: _appBarTitle,
                leading: new IconButton(
                  icon: _searchIcon,
                  onPressed: () {
                    _searchPressed(context);
                  },
                ),
                actions: <Widget>[
                  PopupMenuButton(
                    onSelected: (value) async {
                      if (value == 1) {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PreferencePage()));
                      } else if (value == 2) {
                        // await Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => AddonsPage()));

                      } else if (value == 3) {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AboutPage()));
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem(
                          value: 1,
                          child: Text("Settings"),
                        ),
                        PopupMenuItem(
                          value: 2,
                          child: Text("Addons"),
                        ),
                        PopupMenuItem(
                          value: 3,
                          child: Text("About"),
                        )
                      ];
                    },
                  )
                ],
                bottom: tabBar,
              ),
              body: MultiBlocProvider(
                providers: [
                  BlocProvider<SearchPresetsBloc>(
                      create: (BuildContext context) => SearchPresetsBloc()),
                ],
                child: TabBarView(children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: bottomPadding),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: PresetsListView(),
                          flex: 3,
                        ),
                        Expanded(child: Text("Stations"), flex: 4),
                      ],
                    ),
                  ),
                  Text("Favorites"),
                ]),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  
                },
                tooltip: 'Reload',
                child: Icon(Icons.restore_page),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
            )));
  }
}

class FolderItem extends StatelessWidget {
  const FolderItem(this.entry);

  final Folder entry;

  Widget _buildTiles(Folder root) {
    if (root.children.isEmpty) return ListTile(title: Text(root.name));
    return ExpansionTile(
      key: PageStorageKey<Folder>(root),
      title: Text(root.name),
      children: root.children.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}
