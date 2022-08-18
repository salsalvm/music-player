import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marquee/marquee.dart';
import 'package:music/function/favouriteicon.dart';
import 'package:music/screens/favouritescreen/favouritescreen.dart';
import 'package:music/screens/homescreen/navbar/navbar.dart';
import 'package:music/screens/nowplayingscreen/widget.dart';
import 'package:music/screens/splashscreen/splashscreen.dart';

class MusicPlaySceeen extends StatefulWidget {
  List<Audio>? allSongs = [];
  int? index;
  final String? songId;
  MusicPlaySceeen({
    Key? key,
    this.songId,
    this.allSongs,
    this.index,
  }) : super(key: key);

  @override
  State<MusicPlaySceeen> createState() => _MusicPlaySceeenState();
}

class _MusicPlaySceeenState extends State<MusicPlaySceeen>
    with TickerProviderStateMixin {
  Color color = const Color.fromARGB(255, 235, 139, 171);
  late AnimationController animationController;
  List playlist = [];
  List<dynamic> playlistSongs = [];
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 7),
    );
    animationController.repeat();
  }

  bool isRepeate = false;

  @override
  Widget build(BuildContext context) {
    final playlistName = databaseSongs(dbSongs, widget.songId!);
    // log(dbsongs.toString());
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          colors: [
            Color(0xFF911BEE),
            Color(0xFF4D0089),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('NowPlaying'),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_drop_down_outlined,
              size: 35.sp,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: audioPlayer.builderCurrent(
          builder: (context, Playing? playing) {
            final myAudio = find(widget.allSongs!, playing!.audio.audio.path);
            final currentSong = dbSongs.firstWhere((element) =>
                element.id.toString() == myAudio.metas.id.toString());
            // final currentsong = dbsongs!.firstWhere((e)=>e.id.toString() == myAudio.metas.id.toString());
            // log(currentsong.toString());
            return Padding(
              padding: EdgeInsets.only(top: 50.h, left: 25.w, right: 25.w),
              child: Column(
                children: [
                  AnimatedBuilder(
                    animation: animationController,
                    child: Image.asset(
                      'assets/img/musiclogo.png',
                    ),
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: animationController.value * 6.3,
                        child: child,
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30.h),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50.h,
                          width: 250.w,
                          child: Marquee(
                            blankSpace: 50.w.h,
                            startAfter: Duration.zero,
                            velocity: 60,
                            text: myAudio.metas.title!,
                            style: TextStyle(
                              fontSize: 25.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            myAudio.metas.artist!.toLowerCase(),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            if (isRepeate == false) {
                              audioPlayer.setLoopMode(LoopMode.single);
                              setState(
                                () {
                                  isRepeate = true;
                                  color = Colors.black;
                                },
                              );
                            } else {
                              audioPlayer.setLoopMode(LoopMode.playlist);
                              setState(
                                () {
                                  isRepeate = false;
                                  color = Colors.white;
                                },
                              );
                            }
                          },
                          icon: Icon(
                            isRepeate == false ? Icons.loop : Icons.repeat_one,
                            color: Colors.white,
                            size: 30.sp,
                          ),
                        ),
                        FavouriteIcon(
                          songId: myAudio.metas.id!,
                        ),
                        IconButton(
                          onPressed: () {
                            playlistshowbottomsheet(
                                context: context,
                                playlistNames: playlistName,
                                currentplaysong: currentSong);
                            // addtoPlaylistinNowpalying(context: context);
                          },
                          icon: Icon(
                            Icons.queue_music_sharp,
                            color: Colors.white,
                            size: 30.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  audioPlayer.builderRealtimePlayingInfos(
                    builder: (
                      context,
                      RealtimePlayingInfos realtimePlayingInfos,
                    ) {
                      return audioplayerUI(
                        realtimePlayingInfos,
                      );
                    },
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  // slider(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
