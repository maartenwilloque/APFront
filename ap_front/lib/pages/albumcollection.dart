import 'package:ap_front/pages/details.dart';
import 'package:ap_front/pages/shared/bottomnav.dart';
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
    TextTheme theme = Theme.of(context).textTheme;
    ColorScheme scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text("Albums", style: theme.displayLarge),
        backgroundColor: scheme.primary,
        leadingWidth: 100,
        toolbarHeight: 75,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
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
      bottomNavigationBar: const MyBottomNavigation(),
    );
  }
}
