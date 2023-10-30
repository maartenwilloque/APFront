import 'package:ap_front/models/song.dart';
import 'package:flutter/material.dart';

class SongList extends StatelessWidget {
  final List<Song> songs;

  const SongList({super.key, required this.songs});

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: songs.length,
          itemBuilder: (context, index) {
            final song = songs[index];
            return ListTile(
              leading: Text((index + 1).toString()),
              title: Text(song.title),
              subtitle: Text(
                convertTime(song.duration),
                style: theme.labelMedium,
              ),
              trailing: IconButton(
                icon: const Icon(
                  Icons.play_arrow,
                  color: Colors.green,
                ),
                onPressed: () {
                  // Add your play function here or link to a function.
                  // You can call a function to play the selected song.
                  playSong(song);
                },
              ),
            );
          },
        ));
  }

  void playSong(Song song) {
    // Implement your play functionality here
    // You can start playing the selected song.
  }

  String convertTime(int duration) {
    int minutes = duration ~/ 60;
    int seconds = duration % 60;
    String time = "$minutes:$seconds".toString().padLeft(2, "0");

    return time;
  }
}
