import 'package:ap_front/apis/album_api.dart';
import 'package:ap_front/apis/thumbnail_api.dart';
import 'package:ap_front/models/album.dart';
import 'package:ap_front/models/albumAndUrl.dart';
import 'package:ap_front/models/ratingWithAlbum.dart';
import 'package:ap_front/textstyles/loadingstyles.dart';
import 'package:ap_front/widgets/albumcover.dart';
import 'package:ap_front/widgets/deleteratingpopup.dart';
import 'package:ap_front/widgets/ratingstars.dart';
import 'package:ap_front/widgets/titledisplay.dart';
import 'package:flutter/material.dart';
import 'package:ap_front/pages/shared/bottomnav.dart';
import 'package:ap_front/apis/rating_api.dart';
import 'package:localstorage/localstorage.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  List<RatingWithAlbum> _ratingList = [];
  List<Album> _albumList = [];
  List<AlbumAndUrl> _albumAndUrlList = [];
  bool loading = true;
  String userId = "";
  String userName = "";
  bool ratingWasDeleted = false;

  Future<void> getIDAndRating() async {
    LocalStorage userStorage = LocalStorage('user_storage');
    await userStorage.ready;
    userId = userStorage.getItem('guid');
    userName = userStorage.getItem('username');

    loading = true;
    await RatingApi.getRatingsWithAlbum(userId).then((result) {
      setState(() {
        _ratingList = result;
        //loading = false;
      });
    });

    for (RatingWithAlbum ratingWithAlbum in _ratingList) {
      await AlbumApi.fetchAlbum(int.parse(ratingWithAlbum.album.albumId))
          .then((result) {
        setState(() {
          _albumList.add(result);
        });
      });
    }

    for (Album album in _albumList) {
      String albumUrl = "";
      await ThumbnailApi.fetchThumbnail(
        album.band.name,
        album.title,
      ).then((result) {
        albumUrl = result;

        AlbumAndUrl albumAndUrl = AlbumAndUrl(
          albumId: album.albumId,
          albumUrl: albumUrl,
        );

        setState(() {
          _albumAndUrlList.add(albumAndUrl);
        });

        if (album == _albumList[_albumList.length - 1]) {
          loading = false;
        }
      });
    }

    if (_albumList.isEmpty) {
      loading = false;
    }
  }

  @override
  void initState() {
    getIDAndRating();
    super.initState();
  }

  _handleOutput() {
    ratingWasDeleted = true;
  }

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    ColorScheme scheme = Theme.of(context).colorScheme;
    const double heightBetweenElements = 15;

    return Scaffold(
      appBar: AppBar(
        title: Text("Review Page", style: theme.displayLarge),
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: heightBetweenElements,
          ),
          TitleDisplayWidget(
            title: "Reviews by $userName",
          ),
          const SizedBox(
            height: heightBetweenElements,
          ),
          loading
              ? const Center(
                  child: Text(
                    "loading ratings...",
                    style: loadingHeadline,
                  ),
                )
              : _ratingList.isEmpty
                  ? Center(
                      child: Text(
                        "No ratings found!",
                        style: theme.headlineSmall,
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: _ratingList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  _albumAndUrlList.isNotEmpty
                                      ? AlbumCoverWidget(
                                          imageUrl: _albumAndUrlList
                                              .firstWhere(
                                                (x) =>
                                                    x.albumId ==
                                                    _albumList[index].albumId,
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
                                  Column(children: <Widget>[
                                    Text(
                                      _ratingList[index].album.title,
                                      style: theme.headlineSmall,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      _albumList
                                          .firstWhere((x) =>
                                              x.albumId ==
                                              _ratingList[index].album.albumId)
                                          .band
                                          .name,
                                      style: theme.bodySmall,
                                    ),
                                    RatingStars(
                                      rating:
                                          _ratingList[index].score.toDouble(),
                                      starSize: 25.0,
                                    ),
                                  ]),
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: scheme.primary,
                                      size: 30.0,
                                    ),
                                    onPressed: () async {
                                      await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return DeleteRatingPopup(
                                            ratingId: _ratingList[index].id,
                                            ratingList: _ratingList,
                                            albumName:
                                                _ratingList[index].album.title,
                                            onDeleted: (bool deleted) {
                                              _handleOutput();
                                            },
                                          );
                                        },
                                      ).then((result) async {
                                        if (ratingWasDeleted) {
                                          setState(() {
                                            _ratingList.removeWhere((x) =>
                                                x.id == _ratingList[index].id);
                                          });

                                          ratingWasDeleted = false;
                                        }
                                      });
                                    },
                                  ),
                                ]),
                          );
                        },
                      ),
                    ),
        ],
      ),
      bottomNavigationBar: const MyBottomNavigation(),
    );
  }
}
