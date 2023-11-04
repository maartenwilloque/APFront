import 'package:ap_front/models/ratingWithAlbum.dart';
import 'package:ap_front/textstyles/loadingstyles.dart';
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
        loading = false;
      });
    });
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
                            title: Column(children: <Widget>[
                              Text(
                                _ratingList[index].album.title,
                                style: theme.headlineSmall,
                              ),
                              RatingStars(
                                rating: _ratingList[index].score.toDouble(),
                                starSize: 25.0,
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
