import 'dart:async';
import 'package:ap_front/apis/rating_api.dart';
import 'package:ap_front/models/ratingWithAlbum.dart';
import 'package:ap_front/textstyles/loadingstyles.dart';
import 'package:ap_front/widgets/titledisplay.dart';
import 'package:flutter/material.dart';

class DeleteRatingPopup extends StatefulWidget {
  final int ratingId;
  final List<RatingWithAlbum> ratingList;
  final String albumName;

  const DeleteRatingPopup(
      {Key? key,
      required this.ratingId,
      required this.ratingList,
      required this.albumName,
      rewq})
      : super(key: key);

  @override
  _DeleteRatingPopupState createState() => _DeleteRatingPopupState();
}

class _DeleteRatingPopupState extends State<DeleteRatingPopup> {
  int rating = 0;
  bool deleteConfirmed = false;
  bool deletingRating = false;
  bool ratingDeleted = false;
  String message = "";

  @override
  void initState() {
    super.initState();
    message =
        "Are you sure you wish to delete your rating for '${widget.albumName}'";
  }

  Future<void> deleteRating() async {
    try {
      setState(() {
        deleteConfirmed = true;
        deletingRating = true;
        message = "deleting rating...";
      });

      final result = await RatingApi.deleteRating(widget.ratingId);

      if (result == "deleted") {
        widget.ratingList.removeWhere((rating) => rating.id == widget.ratingId);
        setState(() {
          deletingRating = false;
          ratingDeleted = true;
          message = 'Rating Deleted!';
        });
      } else {
        setState(() {
          deletingRating = false;
          ratingDeleted = false;
          message = 'Something went wrong.';
        });
      }
    } catch (e) {
      setState(() {
        deletingRating = false;
        ratingDeleted = false;
        message = 'Something went wrong.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    ColorScheme scheme = Theme.of(context).colorScheme;

    return AlertDialog(
      title: const TitleDisplayWidget(
        title: "Delete Rating",
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            message,
            style: !deletingRating ? theme.bodyLarge : loadingBody,
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(290, 50),
            backgroundColor: scheme.primary,
          ),
          onPressed: () async {
            if (!deletingRating) {
              await deleteRating()
                  .then((value) => Navigator.of(context).pushNamed('/review'));
            }
          },
          child: Text(
            "Confirm",
            style: theme.displaySmall,
          ),
        ),
      ],
    );
  }
}
