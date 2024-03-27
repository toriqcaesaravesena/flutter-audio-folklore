import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/bg.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    EdgeInsets.only(bottom: 20.0), // Atur bottom margin di sini
                child: PlayAudio(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlayAudio extends StatefulWidget {
  const PlayAudio({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PlayAudioState createState() => _PlayAudioState();
}

class _PlayAudioState extends State<PlayAudio> {
  final AudioPlayer player = AudioPlayer();
  bool isPlaying = false;

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                if (isPlaying) {
                  pauseSound();
                } else {
                  playSound();
                }
              },
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(80, 40)),
              ),
              child: Text(isPlaying ? "Pause" : "Play"),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: resetSound,
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(80, 40)),
              ),
              child: const Text("Reset"),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setPlaybackSpeed(2.0);
              },
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(50, 30)),
              ),
              child: const Text("2x"),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                setPlaybackSpeed(3.0);
              },
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(50, 30)),
              ),
              child: const Text("3x"),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                setPlaybackSpeed(4.0);
              },
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(50, 30)),
              ),
              child: const Text("4x"),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> playSound() async {
    String audioPath = "audio.m4a";
    await player.play(AssetSource(audioPath));
    setState(() {
      isPlaying = true;
    });
  }

  Future<void> pauseSound() async {
    await player.pause();
    setState(() {
      isPlaying = false;
    });
  }

  Future<void> resetSound() async {
    await player.stop();
    await player.seek(Duration.zero);
    await player.setPlaybackRate(1.0);
    await player.resume();
    setState(() {
      isPlaying = true;
    });
  }

  Future<void> setPlaybackSpeed(double speed) async {
    await player.setPlaybackRate(speed);
  }
}
