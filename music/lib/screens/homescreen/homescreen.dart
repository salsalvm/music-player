import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marquee/marquee.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music/function/searchdelagete.dart';
import 'package:music/screens/homescreen/navdrawer/navdrawer.dart';
import 'package:music/screens/homescreen/widget.dart';
import 'package:music/screens/splashscreen/splashscreen.dart';
import 'package:music/widget/openplayer.dart';

bool boolfav = false;
// ignore: prefer_typing_uninitialized_variables
var showsnackbar;

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF911BEE),
            Colors.black.withOpacity(0.94),
            Colors.black,
            Colors.black.withOpacity(0.94),
            const Color(0xFF911BEE),
          ],
          stops: const [
            0.01,
            0.3,
            0.5,
            0.7,
            1,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        drawer: const Navdrawer(),
        // extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('jMUSIC'),
          centerTitle: true,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              tooltip: 'Search',
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: MySearch(),
                );
              },
            ),
          ],
          backgroundColor: Colors.transparent,
        ),
        body: ValueListenableBuilder(
          valueListenable: box.listenable(),
          builder: (context, songslist, child) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: dbSongs.length,
                itemBuilder: (BuildContext context, int index) {
                  // Songs? audio = box.getAt(index);
                  // log('${audio!.path} songs is here');
                  // final songdata = songslist[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20).r,
                      side: const BorderSide(
                        color: Colors.white54,
                        width: 2.0,
                      ),
                    ),
                    color: Colors.transparent,
                    elevation: 0,
                    child: Container(
                      height: 80.h,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20).r,
                      ),
                      child: ListTile(
                        onTap: (() async {
                          await Openplayer(
                            fullSongs: [],
                            index: index,
                            songId: fullSongs[index].metas.id.toString(),
                          ).openAssetPlayer(
                            index: index,
                            songs: fullSongs,
                          );
                          // log(
                          //   fullSongs[index].metas.id.toString(),
                          // );
                        }),
                        leading: const CircleAvatar(
                          // child:
                          child: Icon(
                            Icons.music_note,
                            color: Colors.white,
                          ),
                        ),
                        title: SizedBox(
                          height: 40.h,
                          child: Marquee(
                            blankSpace: 50.w.h,
                            startAfter: Duration.zero,
                            velocity: 50,
                            // text: songdata.songtitle!,
                            text: fullSongs[index].metas.title!,
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.sp,
                            ),
                          ),
                        ),
                        subtitle: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 2.0, bottom: 5).r,
                            child: Text(
                              // songdata.songartist!,
                              fullSongs[index].metas.artist!.toLowerCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        trailing: SizedBox(
                          width: 25,
                          child: popup(
                            songId: fullSongs[index].metas.id.toString(),
                            context: context
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}