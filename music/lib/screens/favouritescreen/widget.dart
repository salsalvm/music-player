import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music/screens/favouritescreen/favouritescreen.dart';
import 'package:music/screens/nowplayingscreen/widget.dart';
import 'package:music/screens/splashscreen/splashscreen.dart';

List? favourites = box.get("favourites");

Widget favpopup({required songId, required context}) {
  final temp = databaseSongs(dbSongs, songId);
  return PopupMenuButton(
    padding: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        const Radius.circular(15.0).r,
      ),
    ),
    color: Colors.black,
    icon: const Icon(
      Icons.more_vert,
      color: Colors.white,
    ),
    itemBuilder: (context) => [
      favourites!
              .where((element) => element.id.toString() == temp.id.toString())
              .isEmpty
          ? PopupMenuItem(
              onTap: () async {
                favourites!.add(temp);
                await box.put("favourites", favourites!);
              },
              child: const Text(
                "Add to Favourite",
                style: TextStyle(color: Colors.white),
              ),
            )
          : PopupMenuItem(
              onTap: () async {
                favourites!.removeWhere(
                  (element) => element.id.toString() == temp.id.toString(),
                );
                await box.put("favourites", favourites!);
              },
              child: const Text(
                'Remove From Favourites',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
    ],
    // onSelected: (value) {
    //   if (value == 1) {
    //     playlistshowbottomsheet(
    //       context: context,
    //       playlistName: temp,
    //     );
    //     // showModalBottomSheet(
    //     //     context: context, builder: (BuildContext context) {
    //     //       return AddtoPlaylist(song: temp,);
    //     //     });
    //   }
    // },
  );
}
