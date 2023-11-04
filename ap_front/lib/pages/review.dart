import 'package:ap_front/apis/album_api.dart';
import 'package:ap_front/apis/thumbnail_api.dart';
import 'package:ap_front/models/album.dart';
import 'package:ap_front/models/albumAndUrl.dart';
import 'package:ap_front/models/ratingWithAlbum.dart';
import 'package:ap_front/textstyles/loadingstyles.dart';
import 'package:ap_front/widgets/albumcover.dart';
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

  String getID() {
    userId = LocalStorage('user_storage').getItem('guid');
    userName = LocalStorage('user_storage').getItem('username');
    return userId;
  }

  //final userId = LocalStorage('user_storage').getItem('guid');
  _getRating(String userId) async {
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
  }

  @override
  void initState() {
    // TODO: implement initState
    getID();
    _getRating(userId);
    super.initState();
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
                  ? const Text("No ratings found")
                  : Expanded(
                      child: ListView.builder(
                        itemCount: _ratingList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Row(children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 14.0),
                                child: _albumAndUrlList.isNotEmpty
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
                              ),
                              Column(children: <Widget>[
                                Text(
                                  _ratingList[index].album.title,
                                  style: theme.headlineSmall,
                                ),
                                //Text(_ratingList[index].album), //TODO
                                RatingStars(
                                  rating: _ratingList[index].score.toDouble(),
                                  starSize: 25.0,
                                ),
                              ]),
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
