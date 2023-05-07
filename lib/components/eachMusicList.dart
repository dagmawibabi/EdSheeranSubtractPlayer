// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, unnecessary_this

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

class EachMusicList extends StatelessWidget {
  const EachMusicList({
    super.key,
    required this.musicData,
    required this.isPlaying,
  });

  final Map musicData;
  final bool isPlaying;

  @override
  Widget build(BuildContext context) {
    Color primaryYellow = Color(0xfff1d80b);
    return Container(
      color: this.isPlaying == true ? Color(0xff15) : Color(0xff101010),
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Icon and Title
          Row(
            children: [
              Icon(
                this.musicData["icon"],
                color:
                    this.isPlaying == true ? Colors.greenAccent : primaryYellow,
              ),
              SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    this.musicData["title"],
                    style: GoogleFonts.nunito(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: this.isPlaying == true
                          ? Colors.greenAccent
                          : primaryYellow,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    this.musicData["artist"],
                    style: GoogleFonts.nunito(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: this.isPlaying == true
                          ? Colors.greenAccent.withOpacity(0.4)
                          : primaryYellow.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Heart adn options
          Row(
            children: [
              this.musicData["liked"] == true
                  ? IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Ionicons.heart,
                        size: 20.0,
                        color: this.isPlaying == true
                            ? Colors.greenAccent
                            : primaryYellow,
                      ),
                    )
                  : Container(),
              Icon(
                Icons.more_vert,
                color:
                    this.isPlaying == true ? Colors.greenAccent : primaryYellow,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
