// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, prefer_interpolation_to_compose_strings

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:subtract/components/eachMusicList.dart';
import 'package:subtract/routes/musicPlayerPage.dart';

class MusicListPage extends StatefulWidget {
  const MusicListPage({super.key});

  @override
  State<MusicListPage> createState() => _MusicListPageState();
}

class _MusicListPageState extends State<MusicListPage> {
  Color primaryYellow = Color(0xfff1d80b);
  AssetsAudioPlayer player = AssetsAudioPlayer();

  List albumSongs = [
    {
      "icon": Icons.sailing_outlined, //Ionicons.boat_outline,
      "title": "Boat",
      "artist": "Ed Sheeran",
      "liked": true,
    },
    {
      "icon": EvaIcons.eyeOff2Outline,
      "title": "Eyes Closed",
      "artist": "Ed Sheeran",
      "liked": true,
    },
    {
      "icon": Ionicons.water_outline,
      "title": "Salt Water",
      "artist": "Ed Sheeran",
      "liked": true,
    },
    {
      "icon": Ionicons.infinite_outline,
      "title": "Life Goes On",
      "artist": "Ed Sheeran",
      "liked": true,
    },
    {
      "icon": Icons.bubble_chart_outlined,
      "title": "Dusty",
      "artist": "Ed Sheeran",
      "liked": true,
    },
    {
      "icon": Ionicons.time_outline,
      "title": "End Of Youth",
      "artist": "Ed Sheeran",
      "liked": true,
    },
    {
      "icon": EvaIcons.colorPaletteOutline,
      "title": "Colourblind",
      "artist": "Ed Sheeran",
      "liked": true,
    },
    {
      "icon": Icons.wb_sunny_outlined, //LineIcons.windows,
      "title": "Curtains",
      "artist": "Ed Sheeran",
      "liked": true,
    },
    {
      "icon": LineIcons.circle,
      "title": "Borderline",
      "artist": "Ed Sheeran",
      "liked": true,
    },
    {
      "icon": Icons.star_border,
      "title": "Spark",
      "artist": "Ed Sheeran",
      "liked": true,
    },
    {
      "icon": Icons.grass_outlined,
      "title": "Vega",
      "artist": "Ed Sheeran",
      "liked": true,
    },
    {
      "icon": Icons.eco_outlined,
      "title": "Sycamore",
      "artist": "Ed Sheeran",
      "liked": true,
    },
    {
      "icon": LineIcons.guitar,
      "title": "No Strings",
      "artist": "Ed Sheeran",
      "liked": true,
    },
    {
      "icon": LineIcons.mountain,
      "title": "The Hills of Aberfeldy",
      "artist": "Ed Sheeran",
      "liked": true,
    },
    {
      "icon": Icons.local_florist,
      "title": "Wild Flowers (Bonus Track)",
      "artist": "Ed Sheeran",
      "liked": true,
    },
    {
      "icon": Icons.smoking_rooms_outlined,
      "title": "Stoned (Bonus Track)",
      "artist": "Ed Sheeran",
      "liked": true,
    },
    {
      "icon": Ionicons.fitness_outline,
      "title": "Toughest (Bonus Track)",
      "artist": "Ed Sheeran",
      "liked": true,
    },
    {
      "icon": Icons.directions_walk_outlined,
      "title": "Moving (Bonus Track)",
      "artist": "Ed Sheeran",
      "liked": true,
    },
  ];

  var currentSong = "";
  int currentIndex = 0;
  void loadPlaylist() async {
    List<Audio> playlist = [];
    for (var eachSong in albumSongs) {
      var filePath = "assets/music/" + eachSong["title"] + ".mp3";
      playlist.add(Audio(filePath));
    }
    await player.open(
      Playlist(
        audios: playlist,
      ),
      loopMode: LoopMode.playlist,
    );
    player.stop();
  }

  void play(String fileName) async {
    await player.stop();
    currentSong = fileName;
    for (var i = 0; i < albumSongs.length; i++) {
      if (albumSongs[i]["title"] == fileName) {
        player.playlistPlayAtIndex(i);
        currentIndex = i;
      }
    }
    setState(() {});
  }

  void playPause() async {
    await player.playOrPause();
  }

  void previous() async {
    currentIndex--;
    if (currentIndex < 0) {
      currentIndex = albumSongs.length - 1;
    }
    currentSong = albumSongs[currentIndex]["title"];
    await player.playlistPlayAtIndex(currentIndex);
    setState(() {});
  }

  void next() async {
    currentIndex++;
    if (currentIndex >= albumSongs.length) {
      currentIndex = 0;
    }
    currentSong = albumSongs[currentIndex]["title"];
    await player.playlistPlayAtIndex(currentIndex);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadPlaylist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryYellow,
      body: ListView(
        children: [
          // Album Art
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              GestureDetector(
                onTap: () {
                  playPause();
                  print(currentIndex);
                },
                child: Hero(
                  tag: "albumArt",
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 450.0,
                    child: Image.asset(
                      "assets/images/index.jpeg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Padding(
                padding: EdgeInsets.only(left: 20.0, bottom: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Subtract",
                      style: GoogleFonts.nunito(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Ed Sheeran",
                      style: GoogleFonts.nunito(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 30.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Color(0xff101010),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // SizedBox(height: 10.0),
          // Music List
          Container(
            color: Color(0xff101010),
            height: MediaQuery.of(context).size.height * 0.6,
            child: ListView(
              children: [
                for (var eachMusic in albumSongs)
                  GestureDetector(
                    onTap: () {
                      play(eachMusic["title"]);
                      // loadMusic();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MusicPlayerPage(
                            musicData: eachMusic,
                            player: player,
                            currentIndex: currentIndex,
                            playPause: playPause,
                            next: next,
                            previous: previous,
                          ),
                        ),
                      );
                    },
                    child: EachMusicList(
                      musicData: eachMusic,
                      isPlaying:
                          currentSong == eachMusic["title"] ? true : false,
                    ),
                  ),
                SizedBox(height: 280.0),
              ],
            ),
          )
        ],
      ),
    );
  }
}
