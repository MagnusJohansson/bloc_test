import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bloc/searchpresets/search_presets_bloc.dart';
import 'bloc/theme/bloc.dart';
import 'ui/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  Widget _buildWithTheme(BuildContext context, ThemeState state) {
    Future<String> future = SharedPreferences.getInstance().then((prefs) {
      return prefs.getString("themeMode") ?? "Device default";
    });

    return FutureBuilder<String>(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<String> shapshot) {
        return MaterialApp(
            title: 'Bloc Test',
            theme: state.themeData,
            darkTheme: shapshot.data == "Device default"
                ? ThemeData(
                    brightness: Brightness.dark,
                    primaryColor: state.themeData.primaryColor)
                : null,
            home: MultiBlocProvider(
              providers: [
                BlocProvider<SearchPresetsBloc>(
                    create: (BuildContext context) => SearchPresetsBloc()),
              ],
              child: MyHomePage(title: 'Bloc Test'),
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: _buildWithTheme,
      ),
    );
  }
}
