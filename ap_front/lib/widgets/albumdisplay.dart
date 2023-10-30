import 'package:ap_front/models/album.dart';
import 'package:flutter/material.dart';

class AlbumDisplayWidget extends StatelessWidget {
  final Album? album;

  const AlbumDisplayWidget({
    Key? key,
    required this.album,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    ColorScheme scheme = Theme.of(context).colorScheme;

    // Text Style for Loading (maybe need to be moved so it can used everywhere)
    const TextStyle loadingHeadline = TextStyle(
      fontSize: 19,
      fontFamily: "Gill Sans MT Bold",
      color: Colors.grey,
    );

    const TextStyle loadingBody = TextStyle(
      fontSize: 17,
      fontFamily: "Gill Sans MT",
      color: Colors.grey,
    );

    late Text albumName;
    late Text bandName;

    if (album != null) {
      albumName = Text(
        album!.title,
        style: theme.headlineSmall,
      );

      bandName = Text(
        album!.band.name,
        style: theme.bodyLarge,
      );
    } else {
      albumName = const Text(
        'loading album...',
        style: loadingHeadline,
      );

      bandName = const Text(
        'loading band...',
        style: loadingBody,
      );
    }

    return Container(
      width: 290.0,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          color: scheme.primary,
          width: 0.5,
        ),
        color: scheme.background,
      ),
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          Center(
            child: albumName,
          ),
          Center(
            child: bandName,
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
