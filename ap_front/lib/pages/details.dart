import 'package:ap_front/apis/album_api.dart';
import 'package:ap_front/models/album.dart';
import 'package:flutter/material.dart';
import 'package:ap_front/pages/shared/bottomnav.dart';

class DetailPage extends StatefulWidget {
  final String id;
  const DetailPage({super.key, required this.id});

  @override
  State<StatefulWidget> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Album? album;
  @override
  void initState() {
    super.initState();
    _getAlbum(widget.id);
  }

  Future<void> _getAlbum(String id) async {
    await AlbumApi.fetchAlbum(1).then((result) {
      setState(() {
        album = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(album!.title),
      ),
      bottomNavigationBar: const MyBottomNavigation(),
      // Add your widgets here
    );
  }
}
