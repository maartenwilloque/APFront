import 'package:ap_front/apis/album_api.dart';
import 'package:ap_front/apis/thumbnail_api.dart';
import 'package:ap_front/models/album.dart';
import 'package:ap_front/widgets/albumcover.dart';
import 'package:ap_front/widgets/banddisplay.dart';
import 'package:ap_front/widgets/ratingpopup.dart';
import 'package:ap_front/widgets/ratingstars.dart';
import 'package:ap_front/widgets/songlistdisplay.dart';
import 'package:flutter/material.dart';
import 'package:ap_front/pages/shared/bottomnav.dart';

class DetailPage extends StatefulWidget {
  final String id;
  const DetailPage({super.key, required this.id});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Album? album;
  String _imageUrl = '';
  bool _isLoading = true;

  Future<void> _getAlbum() async {
    int albumId = int.parse(widget.id);
    await AlbumApi.fetchAlbum(albumId).then((result) {
      setState(() {
        album = result;
      });
    });

    if (album == null) {
      return;
    } else {
      await ThumbnailApi.fetchThumbnail(album!.band.name, album!.title)
          .then((result) {
        setState(() {
          _imageUrl = result;
        });
      });
      _isLoading = false;
    }
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
    const double heightBetweenElements = 50;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: scheme.primary,
        title: Text(
          "Details",
          style: theme.displayLarge,
        ),
        toolbarHeight: 75,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.thumb_up),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return RatingPopup(
                    albumId: album?.albumId ?? "0",
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: heightBetweenElements,
            ),
            SizedBox(
              height: 180,
              width: 180,
              child: AlbumCoverWidget(
                imageUrl: _imageUrl,
                isLoading: _isLoading,
              ),
            ),
            const SizedBox(
              height: heightBetweenElements,
            ),
            Text(
              album?.title ?? "title not found",
              style: theme.headlineLarge,
            ),
            BandMembersList(
              bandName: album?.band.name ?? "None",
              members: album?.band.members ?? [],
            ),
            RatingStars(
              rating: album?.rating ?? 0,
              starSize: 50.0,
            ),
            SongList(songs: album?.songs ?? []),
          ],
        )),
      ),
      bottomNavigationBar: const MyBottomNavigation(),
    );
  }
}
