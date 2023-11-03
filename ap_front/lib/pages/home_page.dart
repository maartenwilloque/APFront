import 'dart:math';

import 'package:ap_front/apis/album_api.dart';
import 'package:ap_front/apis/thumbnail_api.dart';
import 'package:ap_front/models/album.dart';
import 'package:ap_front/pages/details.dart';
import 'package:ap_front/pages/shared/bottomnav.dart';
import 'package:ap_front/widgets/albumcover.dart';
import 'package:ap_front/widgets/albumdisplay.dart';
import 'package:ap_front/widgets/titledisplay.dart';
import 'package:flutter/material.dart';
import 'package:ap_front/widgets/profilePopup.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _imageUrl = '';
  bool _isLoading = true;
  Album? album;

  Random random = Random();

  Future<void> _getAlbum() async {
    int count = 1;
    await AlbumApi.countAlbums().then((result) {
      setState(() {
        count = result;
      });
    });

    int randomNumber = random.nextInt(count) + 1;

    await AlbumApi.fetchAlbum(randomNumber).then((result) {
      setState(() {
        album = result;
      });
    });

    await ThumbnailApi.fetchThumbnail(album!.band.name, album!.title)
        .then((result) {
      setState(() {
        _imageUrl = result;
      });
    });
    _isLoading = false;
  }

  void _goToDetailPage(BuildContext context, String id) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => DetailPage(id: id)));
  }

  @override
  void initState() {
    super.initState();
    _getAlbum();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    ColorScheme scheme = Theme.of(context).colorScheme;
    const double heightBetweenElements = 15;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: scheme.primary,
        leading: IconButton(
          icon: const Icon(Icons.person_2_outlined),
          onPressed: () {
            showDialog(context: context, builder: (context) => ProfilePopup());
          },
        ),
        title: Text(
          widget.title,
          style: theme.displayLarge,
        ),
        toolbarHeight: 75,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const TitleDisplayWidget(
              title: 'Album of the Day',
            ),
            const SizedBox(
              height: heightBetweenElements,
            ),
            AlbumCoverWidget(
              imageUrl: _imageUrl,
              isLoading: _isLoading,
            ),
            const SizedBox(
              height: heightBetweenElements,
            ),
            AlbumDisplayWidget(
              album: album,
            ),
            const SizedBox(
              height: heightBetweenElements,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(290, 50),
                backgroundColor: scheme.primary,
              ),
              onPressed: () {
                if (album != null) {
                  _goToDetailPage(context, album!.albumId);
                }
              },
              child: Text(
                'Details',
                style: theme.displaySmall,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const MyBottomNavigation(),
    );
  }
}
