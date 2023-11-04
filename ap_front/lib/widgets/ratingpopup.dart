import 'package:ap_front/apis/rating_api.dart';
import 'package:ap_front/models/rating.dart';
import 'package:ap_front/widgets/titledisplay.dart';
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
    TextTheme theme = Theme.of(context).textTheme;
    ColorScheme scheme = Theme.of(context).colorScheme;

    return AlertDialog(
      title: const TitleDisplayWidget(
        title: "Rate this album",
      ),
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
              "Rating for:\u2002$username",
              style: theme.headlineSmall,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(290, 50),
            backgroundColor: scheme.primary,
          ),
          onPressed: () {
            saveRating(widget.albumId, guid, rating);
            // Perform the submission action with the rating and name
            Navigator.of(context).pop();
          },
          child: Text(
            "Send",
            style: theme.displaySmall,
          ),
        ),
      ],
    );
  }
}
