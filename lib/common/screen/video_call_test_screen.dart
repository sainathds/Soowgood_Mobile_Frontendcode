import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:twilio_programmable_video/twilio_programmable_video.dart';

class VideoCallTestScreen extends StatefulWidget {
  const VideoCallTestScreen({Key? key}) : super(key: key);

  @override
  _VideoCallTestScreenState createState() => _VideoCallTestScreenState();
}

class _VideoCallTestScreenState extends State<VideoCallTestScreen> {
  late Room _room;
  final Completer<Room> _completer = Completer<Room>();
  // Create a video track.
  late var localVideoTrack;

  late var widget ;

  var isConnect = false.obs;

  ///*
  ///
  ///
  void _onConnected(Room room) {
    print('Connected to ${room.name}');
    _completer.complete(_room);

    widget = localVideoTrack.widget();

    isConnect.value  = true;
  }

  void _onConnectFailure(RoomConnectFailureEvent event) {
    print('Failed to connect to room ${event.room.name} with exception: ${event.exception}');
    _completer.completeError(event.exception.toString());
  }


  @override
  Widget build(BuildContext context) {
    return Obx((){
      return SafeArea(
        child: Scaffold(
          body: Container(
            child: Column(
              children: [

                !isConnect.value?
                    SizedBox(height: 200,):SizedBox(),

                !isConnect.value?
                InkWell(
                    onTap: (){
                      connectToRoom();
                    },
                    child: const Text('Connect To Ms. Vedha')):SizedBox(),


                /*isConnect.value ?
                Container(
                    height: 500,
                    child: widget) :SizedBox()*/
              ],
            ),
          ),
        ),
      );
    });
  }


  ///*
  ///
  ///
  Future<Room> connectToRoom() async {
    // Retrieve the camera source of your choosing
    var cameraSources = await CameraSource.getSources();
    var cameraCapturer = CameraCapturer(
      cameraSources.firstWhere((source) => source.isFrontFacing),
    );

    localVideoTrack = LocalVideoTrack(true, cameraCapturer);

    var connectOptions = ConnectOptions(
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCIsImN0eSI6InR3aWxpby1mcGE7dj0xIn0.eyJpc3MiOiJTSzcxMDIxM2QxZWI2NjY1MGRlMjlhZTBlNDExNWQ2ODRiIiwiZXhwIjoxNjY5MTAzNjEwLCJqdGkiOiJTSzcxMDIxM2QxZWI2NjY1MGRlMjlhZTBlNDExNWQ2ODRiLTE2NjkxMDAwMTAiLCJzdWIiOiJBQzZhNGNiYzI2YWFlOWE2M2E3ZDc2MTk5NDRkMGFkYTg2IiwiZ3JhbnRzIjp7ImlkZW50aXR5IjoiOGIzNDhmYzktYzczMS00ODQzLThiMTItMGI5Y2Q1NjBhOTkyIiwidmlkZW8iOnt9fX0.M7zsc36GOM6mpesaj0gMBXwSuSksKQzj5qt8LqN2ePM',
      roomName: 'TestTwillo',                   // Optional name for the room
      // region: '',                       // Optional region.
      preferredAudioCodecs: [OpusCodec()],  // Optional list of preferred AudioCodecs
      preferredVideoCodecs: [H264Codec()],  // Optional list of preferred VideoCodecs.
      audioTracks: [LocalAudioTrack(true, 'TestTwillo')], // Optional list of audio tracks.
      /*dataTracks: [
        LocalDataTrack(
          DataTrackOptions(
              ordered: ordered,                      // Optional, Ordered transmission of messages. Default is `true`.
              maxPacketLifeTime: maxPacketLifeTime,  // Optional, Maximum retransmit time in milliseconds. Default is [DataTrackOptions.defaultMaxPacketLifeTime]
              maxRetransmits: maxRetransmits,        // Optional, Maximum number of retransmitted messages. Default is [DataTrackOptions.defaultMaxRetransmits]
              name: name                             // Optional
          ),                                // Optional
        ),
      ],        */                            // Optional list of data tracks
      videoTracks: [LocalVideoTrack(true, cameraCapturer)], // Optional list of video tracks.
    );
    _room = await TwilioProgrammableVideo.connect(connectOptions);
    _room.onConnected.listen(_onConnected);
    _room.onConnectFailure.listen(_onConnectFailure);
    return _completer.future;
  }
}
