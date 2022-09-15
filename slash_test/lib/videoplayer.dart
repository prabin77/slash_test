import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slash_test/bloc/bloc/videobloc_bloc.dart';
import 'package:video_player/video_player.dart';

class VideoApp extends StatefulWidget {
  const VideoApp({
    Key? key,
    required this.videoPath,
  }) : super(key: key);

  final String videoPath;

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoPath)
      ..initialize().then((_) {
        setState(() {});
      });
    _controller.play();
    _controller.addListener(() {
      checkVideo();
    });
  }

  void checkVideo() {
    if (!_controller.value.isPlaying &&
        (_controller.value.duration == _controller.value.position)) {
      print('video Ended');
      context
          .read<VideoblocBloc>()
          .add(SelectNew(playedVideo: widget.videoPath));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _controller.value.isInitialized
          ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
          : Container(),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
}
