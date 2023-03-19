// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset(
      'assets/Final.mp4',
    );
    _controller.value.isPlaying;

    _initializeVideoPlayerFuture = _controller.initialize();

    _controller.setLooping(true);
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 30, top: 20),
                  child: SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: VideoPlayer(_controller),
                  ),
                ),
                Column(
                  children: [
                    Center(
                      child: Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ))),
                        child: const Text(
                          'Welcome to Pocket Pharma',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: const Text(
                          "An online pharmacy app is a software that ensures fast search, selection, and order of medicines and subsequently safe and timely delivery that drastically maximizes the convenience and better customer experience and saves time along with effort. This electronic service is available through a pharmacy marketplace or branded online pharmacy app The first option is an easy-to-use platform, which connects healthcare providers and pharmacies allowing them to sell the medicines. With the marketplace, users have a choice and can compare prices offered by different pharmacies that have registered on the platform and then order from the most favorable one. "),
                    )
                  ],
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
