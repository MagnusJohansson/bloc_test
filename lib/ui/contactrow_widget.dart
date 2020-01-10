import 'package:bloc_test/model/station.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactRowWidget extends StatelessWidget {
  final Station preset;

  ContactRowWidget({this.preset});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: IconButton(
            icon: Icon(FontAwesomeIcons.globe),
            onPressed: () {},
          ),
        ),
        Expanded(
          child: IconButton(
            icon: Icon(FontAwesomeIcons.facebook),
            onPressed: () {},
          ),
        ),
        Expanded(
          child: IconButton(
            icon: Icon(FontAwesomeIcons.twitter),
            onPressed: () {},
          ),
        ),
        Expanded(
          child: IconButton(
            icon: Icon(FontAwesomeIcons.instagram),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
