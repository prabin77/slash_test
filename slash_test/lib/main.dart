import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:intl/intl_browser.dart';
//import 'package:video_player/video_player.dart';
import 'package:location/location.dart';
import 'package:image_picker/image_picker.dart';
import 'package:slash_test/location.dart';
import 'package:slash_test/bloc/bloc/videobloc_bloc.dart';
import 'package:slash_test/videoplayer.dart';
import 'package:video_player/video_player.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => VideoblocBloc(),
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

List<String> dayName = [
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday",
  "Saturday",
  "Sunday",
];
DateTime today = DateTime.now();
String dateStr = "${today.day}-${today.month}-${today.year}";
String time = "${today.hour}:${today.minute}:${today.second}";
String day = dayName[today.weekday];

class _MyHomePageState extends State<MyHomePage> {
  File? video;

  Future pickVideo() async {
    try {
      final video = await ImagePicker().pickVideo(source: ImageSource.gallery);

      if (video == null) return;

      final videoTemporary = File(video.path);
      setState(() => this.video = videoTemporary);
    } on PlatformException catch (e) {
      print("failed to pick video: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Container(
            color: Colors.black,
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child: Row(
                  children: [
                    Icon(
                      Icons.calendar_month,
                      color: Colors.white,
                    ),
                    SizedBox(width: 5),
                    Text(
                      dateStr,
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ],
                )),
                Container(
                    child: Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      color: Colors.white,
                    ),
                    SizedBox(width: 5),
                    Text(
                      time,
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ],
                )),
                Text(
                  day,
                  style: const TextStyle(fontSize: 25, color: Colors.white),
                ),
                MyLocation()
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: BlocBuilder<VideoblocBloc, VideoblocState>(
                  builder: (context, state) {
                    return Container(
                        height: 250,

                        // color: Colors.deepOrange,
                        child: VideoApp(
                          videoPath: state.playingVideo,
                        ));
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: 250,
                  child: Image(
                    image: AssetImage("assets/cola.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          ),
          Container(
            width: 1000,
            height: 50,
            color: Colors.red,
            child: Text(
              "Notification: ",
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
          ),
        ],
      )),
    );
  }
}
