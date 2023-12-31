import 'package:ap_front/apis/thumbnail_api.dart';
import 'package:ap_front/models/albumAndUrl.dart';
import 'package:ap_front/pages/details.dart';
import 'package:ap_front/pages/shared/bottomnav.dart';
import 'package:ap_front/textstyles/loadingstyles.dart';
import 'package:ap_front/widgets/albumcover.dart';
import 'package:ap_front/widgets/titledisplay.dart';
import 'package:flutter/material.dart';
import 'package:ap_front/apis/album_api.dart';
import 'package:ap_front/models/album.dart';

class AlbumCollection extends StatefulWidget {
  final String artistId;
  final String artistName;
  final Album album;

  const AlbumCollection({
    super.key,
    required this.artistId,
    required this.artistName,
    required this.album,
  });

  @override
  _AlbumCollectionState createState() => _AlbumCollectionState();
}

class _AlbumCollectionState extends State<AlbumCollection> {
  List<dynamic> albums = [];
  List<AlbumAndUrl> albumUrls = [];
  bool loadingAlbums = true;

  @override
  void initState() {
    super.initState();
    _fetchAlbums();
  }

  Future<void> _fetchAlbums() async {
    await AlbumApi.fetchAlbumsByBand(widget.artistId, widget.album)
        .then((result) {
      setState(() {
        albums = result;
        loadingAlbums = false;
      });
    });

    List<AlbumAndUrl> albumAndUrlList = [];
    for (Album album in albums) {
      String albumUrl = "";
      await ThumbnailApi.fetchThumbnail(
        album.band.name,
        album.title,
      ).then((result) {
        albumUrl = result;
      });

      AlbumAndUrl albumAndUrl = AlbumAndUrl(
        albumId: album.albumId,
        albumUrl: albumUrl,
      );

      albumAndUrlList.add(albumAndUrl);
    }

    setState(() {
      albumUrls = albumAndUrlList;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    ColorScheme scheme = Theme.of(context).colorScheme;
    const double heightBetweenElements = 15;

    return Scaffold(
      appBar: AppBar(
        title: Text("Albums", style: theme.displayLarge),
        backgroundColor: scheme.primary,
        leadingWidth: 100,
        toolbarHeight: 75,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: heightBetweenElements,
          ),
          Center(
            child: TitleDisplayWidget(
              title: "Other albums by ${widget.artistName}",
            ),
          ),
          const SizedBox(
            height: heightBetweenElements,
          ),
          albums.isEmpty
              ? loadingAlbums
                  ? const Center(
                      child: Text(
                        'loading albums...',
                        style: loadingHeadline,
                      ),
                    )
                  : Center(
                      child: Text(
                        'No other albums were found for this artist.',
                        style: theme.headlineSmall,
                      ),
                    )
              : Expanded(
                  child: SizedBox(
                  height: 200,
                  child: ListView.builder(
                    itemCount: albums.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 14.0),
                              child: albumUrls.isNotEmpty
                                  ? AlbumCoverWidget(
                                      imageUrl: albumUrls
                                          .firstWhere(
                                            (x) =>
                                                x.albumId ==
                                                albums[index].albumId,
                                            orElse: () => AlbumAndUrl(
                                              albumId: '',
                                              albumUrl: 'loading_url',
                                            ),
                                          )
                                          .albumUrl,
                                      isLoading: false,
                                      isSmall: true,
                                    )
                                  : const AlbumCoverWidget(
                                      imageUrl: '',
                                      isLoading: true,
                                      isSmall: true,
                                    ),
                            ),
                            Text(
                              albums[index].title,
                              style: theme.bodyLarge,
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DetailPage(
                                id: albums[index].albumId,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                )),
        ],
      ),
      bottomNavigationBar: const MyBottomNavigation(),
    );
  }
}
