// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, prefer_interpolation_to_compose_strings

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';

class MusicPlayerPage extends StatefulWidget {
  const MusicPlayerPage({
    super.key,
    required this.musicData,
    required this.player,
    required this.currentIndex,
    required this.playPause,
    required this.next,
    required this.previous,
  });

  final Map musicData;
  final AssetsAudioPlayer player;
  final int currentIndex;
  final Function playPause;
  final Function next;
  final Function previous;

  @override
  State<MusicPlayerPage> createState() => _MusicPlayerPageState();
}

class _MusicPlayerPageState extends State<MusicPlayerPage> {
  Color primaryYellow = Color(0xfff1d80b);
  bool isPlaying = true;
  late int currentIndex;
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
  bool isFav = true;

  void findIndex() async {
    for (var i = 0; i < albumSongs.length; i++) {
      if (albumSongs[i]["title"] == widget.musicData["title"]) {
        currentIndex = i;
      }
    }
  }

  void playPause() async {
    await widget.player.playOrPause();
    isPlaying = !isPlaying;
    setState(() {});
  }

  void previous() async {
    currentIndex--;
    if (currentIndex < 0) {
      currentIndex = albumSongs.length - 1;
    }
    await widget.previous();
    setState(() {});
    // widget.player.playlistPlayAtIndex(currentIndex);
  }

  void next() async {
    currentIndex++;
    if (currentIndex >= albumSongs.length) {
      currentIndex = 0;
    }
    await widget.next();
    setState(() {});
    // widget.player.playlistPlayAtIndex(currentIndex);
  }

  int repeatMode = 0;
  List loopModes = [LoopMode.none, LoopMode.playlist, LoopMode.single];
  void repeat() async {
    repeatMode++;
    if (repeatMode > 2) {
      repeatMode = 0;
    }
    await widget.player.setLoopMode(loopModes[repeatMode]);
    setState(() {});
  }

  bool isShuffling = false;
  void shuffle() async {
    widget.player.toggleShuffle();
    isShuffling = !isShuffling;
    setState(() {});
  }

  bool isDarkMode = false;
  void darkMode() {
    isDarkMode = !isDarkMode;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findIndex();
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //   SystemUiOverlayStyle(
    //     statusBarColor: isDarkMode == true ? Colors.black : Color(0xfff1d80b),
    //     statusBarIconBrightness: Brightness.light,
    //   ),
    // );
    return Scaffold(
      backgroundColor: primaryYellow,
      appBar: AppBar(
        backgroundColor: isDarkMode == true ? Color(0xff101010) : primaryYellow,
        elevation: 0.0,
        foregroundColor: isDarkMode == true ? primaryYellow : Colors.black,
        title: Text(
          "Subtract",
          style: GoogleFonts.nunito(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            // color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              darkMode();
            },
            icon: Icon(
              Icons.dark_mode_outlined,
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          // Album Art
          Stack(
            // alignment: Alignment.bottomLeft,
            children: [
              Hero(
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
              isDarkMode == true
                  ? Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 450.0,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xff101010),
                              Color(0x22101010),
                              Color(0xff101010),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container()
            ],
          ),
          Container(
            color: isDarkMode == true ? Color(0xff101010) : primaryYellow,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Column(
              children: [
                SizedBox(height: 20.0),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 25.0, right: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            albumSongs[currentIndex]["title"],
                            style: GoogleFonts.nunito(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode == true
                                  ? primaryYellow
                                  : Colors.black,
                            ),
                          ),
                          Text(
                            albumSongs[currentIndex]["artist"],
                            style: GoogleFonts.nunito(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode == true
                                  ? primaryYellow.withOpacity(0.5)
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                      isFav == true
                          ? IconButton(
                              onPressed: () {
                                isFav = !isFav;
                                setState(() {});
                              },
                              icon: Icon(
                                Ionicons.heart,
                                size: 25.0,
                                color: isDarkMode == true
                                    ? primaryYellow
                                    : Colors.black,
                              ),
                            )
                          : IconButton(
                              onPressed: () {
                                isFav = !isFav;
                                setState(() {});
                              },
                              icon: Icon(
                                Ionicons.heart_outline,
                                size: 25.0,
                                color: isDarkMode == true
                                    ? primaryYellow
                                    : Colors.black,
                              ),
                            ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                // Seeker
                widget.player.builderCurrentPosition(
                  builder: (context, duration) => Container(
                    width: double.infinity,
                    height: 32.0,
                    child: Slider(
                      value: widget.player.currentPosition.value.inSeconds
                          .toDouble(),
                      min: 0,
                      max: widget.player.current.valueOrNull == null
                          ? 100.0
                          : widget
                              .player.current.value!.audio.duration.inSeconds
                              .toDouble(),
                      activeColor: isDarkMode == true
                          ? primaryYellow
                          : Color(0xff101010),
                      inactiveColor: isDarkMode == true
                          ? primaryYellow.withOpacity(0.2)
                          : Color(0x44101010),
                      onChanged: (change) => {
                        widget.player.seek(
                          Duration(seconds: change.toInt()),
                        ),
                      },
                    ),
                  ),
                ),
                // Current Postion and Duration
                widget.player.builderCurrentPosition(
                  builder: (context, duration) => Container(
                    width: double.infinity,
                    height: 20.0,
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          (duration.inSeconds ~/ 60)
                                  .toString()
                                  .padLeft(2, '0') +
                              ":" +
                              ((duration.inSeconds % 60).toInt())
                                  .toString()
                                  .padLeft(2, "0"),
                          style: TextStyle(
                            fontSize: 11.0,
                            color: isDarkMode == true
                                ? primaryYellow
                                : Colors.black,
                          ),
                        ),
                        Text(
                          widget.player.current.valueOrNull == null
                              ? "00:00"
                              : (widget.player.current.value!.audio.duration
                                              .inSeconds ~/
                                          60)
                                      .toString()
                                      .padLeft(2, '0') +
                                  ":" +
                                  ((widget.player.current.value!.audio.duration
                                                  .inSeconds %
                                              60)
                                          .toInt())
                                      .toString()
                                      .padLeft(2, "0"),
                          style: TextStyle(
                            fontSize: 11.0,
                            color: isDarkMode == true
                                ? primaryYellow
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.0),

                // Controlls
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          shuffle();
                        },
                        child: Icon(
                          Ionicons.shuffle_outline,
                          size: 30.0,
                          color: isShuffling == true
                              ? Colors.green
                              : (isDarkMode == true
                                  ? primaryYellow
                                  : Colors.black),
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              previous();
                            },
                            child: Icon(
                              Icons.skip_previous_rounded,
                              size: 60.0,
                              color: isDarkMode == true
                                  ? primaryYellow
                                  : Colors.black,
                            ),
                          ),
                          SizedBox(width: 10.0),
                          GestureDetector(
                            onTap: () {
                              playPause();
                            },
                            child: Icon(
                              isPlaying == true
                                  ? Icons.pause_circle_filled_outlined
                                  : Icons.play_circle_fill_outlined,
                              size: 70.0,
                              color: isDarkMode == true
                                  ? primaryYellow
                                  : Colors.black,
                            ),
                          ),
                          SizedBox(width: 10.0),
                          GestureDetector(
                            onTap: () {
                              next();
                            },
                            child: Icon(
                              Icons.skip_next_rounded,
                              size: 60.0,
                              color: isDarkMode == true
                                  ? primaryYellow
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () async {
                          repeat();
                        },
                        child: Icon(
                          repeatMode == 0
                              ? Ionicons.repeat_outline
                              : repeatMode == 1
                                  ? Ionicons.repeat_outline
                                  : Icons.repeat_one,
                          size: 30.0,
                          color: repeatMode == 0
                              ? (isDarkMode == true
                                  ? primaryYellow
                                  : Colors.black)
                              : Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
