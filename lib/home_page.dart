import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';


class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;


  @override
  void initState() {

    super.initState();
    _controller = VideoPlayerController.network(
      'https://videodl.djmazadownload.xyz/storage/0817/Bandook%20Meri%20Laila%20-%20%20A%20Gentleman%20DJMaza.Life.mp4',
    );
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);

  }

  @override
  void dispose() {

    super.dispose();
    _controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("My Video Player"),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
            size: 33,
          ),
          onPressed: (){
            setState(() {

              if (_controller.value.isPlaying) {
                _controller.pause();
              } else {

                _controller.play();
              }
            });

          }),

      body: Stack(
        children: [
          Container(
            color: Colors.greenAccent,
            height: 280,
            child: FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot){
                if (snapshot.connectionState == ConnectionState.done) {

                  return AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,

                    child: VideoPlayer(_controller),
                  );
                } else {

                  return Center(child: CircularProgressIndicator());
                }

              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 269),
            child: VideoProgressIndicator(

              _controller,
              allowScrubbing: true,

            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:280),
            child: Container(
              color: Colors.white70,

            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top:220),
              child: FlutterLogo(size: 300,),
            ),
          )

        ],
      ),

    );
  }
}
