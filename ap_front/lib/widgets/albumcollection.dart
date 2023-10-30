import 'package:ap_front/pages/details.dart';
import 'package:flutter/material.dart';
import 'package:ap_front/apis/album_api.dart';

class AlbumCollection extends StatefulWidget {
  final String artistId;

  AlbumCollection({required this.artistId});

  @override
  _AlbumCollectionState createState() => _AlbumCollectionState();
}

class _AlbumCollectionState extends State<AlbumCollection> {
  List<dynamic> albums = [];

  @override
  void initState() {
    super.initState();
    _fetchAlbums();
  }

  Future<void> _fetchAlbums() async {
    await AlbumApi.fetchAlbumsByBand(widget.artistId).then((result) {
      setState(() {
        albums = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Albums"),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
              child: SizedBox(
            height: 200,
            child: ListView.builder(
              itemCount: albums.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(albums[index].title),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            DetailPage(id: albums[index].albumId)));
                  },
                );
              },
            ),
          )),
        ],
      ),
    );
  }
}
