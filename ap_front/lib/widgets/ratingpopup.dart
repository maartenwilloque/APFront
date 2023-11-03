import 'package:ap_front/apis/rating_api.dart';
import 'package:ap_front/models/rating.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class RatingPopup extends StatefulWidget {
  final String albumId;
  const RatingPopup({
    Key? key,
    required this.albumId,
  }) : super(key: key);

  @override
  State<RatingPopup> createState() => _RatingPopupState();
}

class _RatingPopupState extends State<RatingPopup> {
  int rating = 0;
  String username = LocalStorage('user_storage').getItem('username') ?? '';
  String guid = LocalStorage('user_storage').getItem('guid') ?? '';

  void saveRating(String newalbumId, String newname, int newscore) {
    Rating rating = Rating(albumId: newalbumId, score: newscore, name: newname);
    RatingApi.createRating(rating);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Rate this album"),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return Expanded(
                    child: IconButton(
                  icon: Icon(
                    index < rating ? Icons.star : Icons.star_border,
                    size: 40,
                    color: Colors.yellow,
                    shadows: const [
                      Shadow(color: Colors.black, blurRadius: 10.0)
                    ],
                  ),
                  onPressed: () {
                    setState(() {
                      rating = index + 1;
                    });
                  },
                ));
              }),
            ),
            const SizedBox(height: 10),
            Text(
              "Rating for: $username",
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            saveRating(widget.albumId, guid, rating);
            // Perform the submission action with the rating and name
            Navigator.of(context).pop();
          },
          child: const Text("Send"),
        ),
      ],
    );
  }
}
