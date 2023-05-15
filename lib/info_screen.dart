import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'classes.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    _controller = VideoPlayerController.asset('images/filmulet.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<ListTileStrings> infoTiles = [
      ListTileStrings('Solar Panels Power', '', '12.3 KW'),
      ListTileStrings('', '', ''),
      ListTileStrings('Field incline', '', '3.1 degrees'),
      ListTileStrings('', '', ''),
      ListTileStrings('Throttle Setting', '', '70%'),
      ListTileStrings('', '', ''),
      ListTileStrings('Current speed', '', '12.7 km/h'),
    ];
    _controller.play();
    _controller.setLooping(true);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Realtime Info'),
      ),
      body: ListView(
        children: [
          ...infoTiles.map(
            (e) => e.title == ''
                ? const Divider(thickness: 1)
                : ListTile(
                    title: Text(e.title),
                    subtitle: e.subtitle != '' ? Text(e.subtitle) : null,
                    trailing: Text(e.trailing),
                  ),
          ),
          Divider(thickness: 1),
          _controller.value.isInitialized
              ? Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
