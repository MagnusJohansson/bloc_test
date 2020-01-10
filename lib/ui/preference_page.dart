import 'package:bloc_test/bloc/theme/app_themes.dart';
import 'package:bloc_test/bloc/theme/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PreferencePageState();
  }
}

class _PreferencePageState extends State<PreferencePage> {
  String _themeMode = "Device default";
  String _currentTheme = "";
  Brightness _currentBrightness;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        _themeMode = prefs.getString("themeMode") ?? "Device default";
        _currentTheme = prefs.getString("theme") ?? "AppTheme.Green";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _currentBrightness = MediaQuery.of(context).platformBrightness;
    if (_currentBrightness == Brightness.dark)
      print("----THEME: Dark mode");
    else
      print("----THEME: Normal mode");

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Preferences',
          //style: Theme.of(context).textTheme.title,
        ),
      ),
      body: Column(
        children: <Widget>[
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: EdgeInsets.all(8),
            itemCount: AppTheme.values.length,
            itemBuilder: (context, index) {
              final itemAppTheme = AppTheme.values[index];
              return Card(
                color: appThemeData[itemAppTheme].primaryColor,
                child: ListTile(
                  title: Text(
                    itemAppTheme.toString(),
                    style: appThemeData[itemAppTheme].textTheme.body1,
                  ),
                  onTap: () async {
                    BlocProvider.of<ThemeBloc>(context).add(
                      ThemeChanged(
                          theme: itemAppTheme, brightness: _currentBrightness),
                    );
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString("theme", itemAppTheme.toString());
                  },
                ),
              );
            },
          ),
          Row(
            children: <Widget>[
              Container(
                width: 50.0,
              ),
              Text("Theme:"),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 20.0),
                  child: DropdownButton<String>(
                    value: _themeMode,
                    items: <String>["Device default", "Light", "Dark"]
                        .map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String value) async {
                      var prefs = await SharedPreferences.getInstance();
                      prefs.setString("themeMode", value);

                      if (_currentTheme.isNotEmpty) {
                        AppTheme appTheme = AppTheme.values
                            .firstWhere((e) => e.toString() == _currentTheme);
                        if (appTheme != null) {
                          switch (value) {
                            case "Light":
                              //var themeData = appThemeData[appTheme];
                              BlocProvider.of<ThemeBloc>(context).add(
                                ThemeChanged(
                                    theme: appTheme,
                                    brightness: Brightness.light),
                              );
                              break;
                            case "Dark":
                              BlocProvider.of<ThemeBloc>(context).add(
                                ThemeChanged(
                                    theme: appTheme,
                                    brightness: Brightness.dark),
                              );
                              break;
                            default:
                              BlocProvider.of<ThemeBloc>(context).add(
                                ThemeChanged(
                                    theme: appTheme,
                                    brightness: _currentBrightness),
                              );
                          }
                          // BlocProvider.of<ThemeBloc>(context).dispatch(
                          //   ThemeChanged(
                          //       theme: appTheme,
                          //       brightness: _currentBrightness),
                          // );
                        }
                      }

                      setState(() {
                        _themeMode = value;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
