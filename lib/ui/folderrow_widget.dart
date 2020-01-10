import 'package:bloc_test/model/folder.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FolderRowWidget extends StatelessWidget {
  final Folder preset;

  FolderRowWidget({this.preset});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: IconButton(
            icon: Icon(FontAwesomeIcons.globe),
            onPressed: () {},
            // onPressed: preset.homePageUrl == null
            //     ? null
            //     : () async {
            //         await launch(preset.homePageUrl);
            //       },
          ),
        ),
        Expanded(
          child: IconButton(
            icon: Icon(FontAwesomeIcons.facebook),
            onPressed: () {},
            // onPressed: preset.facebookUrl == null
            //     ? null
            //     : () async {
            //         await launch(preset.facebookUrl);
            //       },
          ),
        ),
        Expanded(
          child: IconButton(
            icon: Icon(FontAwesomeIcons.twitter),
            onPressed: () {},
            // onPressed: preset.twitterUrl == null
            //     ? null
            //     : () async {
            //         await launch(preset.twitterUrl);
            //       },
          ),
        ),
        Expanded(
          child: IconButton(
            icon: Icon(FontAwesomeIcons.instagram),
            onPressed: () {},
            // onPressed: preset.instagramUrl == null
            //     ? null
            //     : () async {
            //         await launch(preset.instagramUrl);
            //       },
          ),
        ),
      ],
    );
  }
}
