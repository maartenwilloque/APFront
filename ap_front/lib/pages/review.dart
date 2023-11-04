import 'package:ap_front/models/ratingWithAlbum.dart';
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

  String getID() {
    userId = LocalStorage('user_storage').getItem('guid');
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
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 30),
            if (loading)
              const CircularProgressIndicator()
            else if (_ratingList.isEmpty)
              const Text("No ratings found")
            else
              Expanded(
                child: ListView.builder(
                  itemCount: _ratingList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_ratingList[index].album.title),
                      subtitle: Text(_ratingList[index].score.toString()),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: const MyBottomNavigation(),
    );
  }
}
