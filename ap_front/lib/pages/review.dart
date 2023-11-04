import 'package:ap_front/models/ratingWithAlbum.dart';
import 'package:flutter/material.dart';
import 'package:ap_front/pages/shared/bottomnav.dart';
import 'package:ap_front/apis/rating_api.dart';
import 'package:localstorage/localstorage.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  List<RatingWithAlbum> result = [];
  bool loading = true;
  final userId = LocalStorage('user_storage').getItem('guid');
  _getRating(String userId) async {
    loading = true;
    await RatingApi.getRatingsWithAlbum(userId).then((result) {
      setState(() {
        result = result;
        loading = false;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
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
            SizedBox(height: 30),
            if (loading)
              CircularProgressIndicator()
            else if (result.isEmpty)
              const Text("No ratings found")
            else
              Expanded(
                child: ListView.builder(
                  itemCount: result.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(result[index].album.title),
                      subtitle: Text(result[index].score.toString()),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavigation(),
    );
  }
}
