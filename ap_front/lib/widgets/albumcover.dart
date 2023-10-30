import 'package:flutter/material.dart';

class AlbumCoverWidget extends StatelessWidget {
  final String imageUrl;
  final bool isLoading;

  const AlbumCoverWidget({
    Key? key,
    required this.imageUrl,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Image image;
    if (isLoading) {
      image = Image.asset("assets/loading.gif");
    } else {
      image = Image.network(imageUrl);
    }

    return Container(
      width: 290.0,
      height: 290.0,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(
          color: Colors.black,
          width: 8.0,
        ),
      ),
      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(32), // Adjust value to fit container's border
        child: AspectRatio(
          aspectRatio: 1,
          child: FittedBox(
            fit: BoxFit.cover,
            child: image,
          ),
        ),
      ),
    );
  }
}
