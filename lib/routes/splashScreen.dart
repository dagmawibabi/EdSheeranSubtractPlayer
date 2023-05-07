// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:palette_generator/palette_generator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<Color> getImagePalette() async {
    ImageProvider imageProvider = AssetImage(
      "assets/images/index.jpeg",
    );
    PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(imageProvider);
    // print(paletteGenerator.dominantColor!.color);
    return paletteGenerator.dominantColor!.color;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getImagePalette(),
      builder: (context, snapshot) => Scaffold(
        backgroundColor: snapshot.data,
        // backgroundColor: Color.fromARGB(255, 20, 20, 20),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Text(
            //   "Ed Sheeran",
            //   style: GoogleFonts.nunito(
            //     fontSize: 22.0,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            SizedBox(height: 10.0),
            GestureDetector(
              onTap: () {
                Navigator.popAndPushNamed(context, "home");
              },
              child: Hero(
                tag: "albumArt",
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        10.0,
                      ),
                    ),
                  ),
                  child: Image.asset(
                    "assets/images/index.jpeg",
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            // Text(
            //   "Subtract",
            //   style: GoogleFonts.nunito(
            //     fontSize: 22.0,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
