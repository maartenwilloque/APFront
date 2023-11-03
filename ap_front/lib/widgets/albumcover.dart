import 'package:flutter/material.dart';

class AlbumCoverWidget extends StatelessWidget {
  final String imageUrl;
  final bool isLoading;
  final bool isSmall;

  const AlbumCoverWidget({
    Key? key,
    required this.imageUrl,
    required this.isLoading,
    this.isSmall = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // large album cover
    double widthAndHeight = 290.0;
    double borderRadius = 40;
    double innerRadius = 32;
    double borderThickness = 8.0;

    // small album cover
    if (isSmall) {
      widthAndHeight = 50.0;
      borderRadius = 10;
      innerRadius = 8;
      borderThickness = 2;
    }

    Image image;
    if (isLoading) {
      image = Image.asset("assets/loading.gif");
    } else {
      image = Image.network(imageUrl);
    }

    return Container(
      width: widthAndHeight,
      height: widthAndHeight,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: Colors.black,
          width: borderThickness,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          innerRadius,
        ), // Adjust value to fit container's border
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
