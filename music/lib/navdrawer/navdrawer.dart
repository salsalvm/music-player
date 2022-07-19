import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';


class Navdrawer extends StatefulWidget {
  const Navdrawer({Key? key}) : super(key: key);

  @override
  State<Navdrawer> createState() => _NavdrawerState();
}

class _NavdrawerState extends State<Navdrawer> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          colors: [
            Color(0xFF911BEE),
            Color(0xFF4D0089),
          ],
        ),
      ),
      child: Drawer(
        backgroundColor: Colors.transparent,
        child: ListView(
          children: <Widget>[
            const DrawerHeader(
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Text(
                  'Music',
                  style: TextStyle(color: Colors.white, fontSize: 50),
                ),
              ),
            ),
             ListTile(
              onTap:() async {
                await Share.share("Thanks for sharing",
                subject: 'hai');
              },
              leading:const Icon(
                Icons.share,
                color: Colors.white,
              ),
              title:const Text(
                'Share',
                style: TextStyle(color: Colors.white),
              ),
              trailing:const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 18,
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.notification_add,
                color: Colors.white,
              ),
              title: const Text(
                'Notification',
                style: TextStyle(color: Colors.white),
              ),
              trailing: Switch(
                value: true,
                onChanged: (value) {
                  // setState(
                  //   () {
                  //     isSwitched = value;
                  //   },
                  // );
                },
                activeTrackColor: Colors.white,
                activeColor: const Color(0xFF911BEE),
              ),
            ),
            const ListTile(
              leading: Icon(
                Icons.star_border_rounded,
                color: Colors.white,
              ),
              title: Text(
                'Rate us',
                style: TextStyle(color: Colors.white),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 18,
              ),
            ),
            ListTile(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AlertDialog(
                            title: const Text(
                              'Privacy policy',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            content: const Text(
                              ''' HAI,
      I'm JIYAD AHAMMAD, who creted the music player . the player is completly free of cost.
      Here i relive the privacy policy of this app.''',
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('I Accept'),
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              leading: const Icon(
                Icons.lock,
                color: Colors.white,
              ),
              title: const Text(
                'Privacy policy',
                style: TextStyle(color: Colors.white),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 18,
              ),
            ),
            ListTile(
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationIcon: const Icon(Icons.music_note),
                  applicationName: "jmusic",
                  applicationVersion: "2.4.2",
                );
              },
              leading: const Icon(
                Icons.info,
                color: Colors.white,
              ),
              title: const Text(
                'About',
                style: TextStyle(color: Colors.white),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 18,
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              title: const Text(
                'Exit',
                style: TextStyle(color: Colors.white),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 18,
              ),
              onTap: () => exitApp(),
            ),
            const SizedBox(
              height: 140,
            ),
            const ListTile(
              title: Text(
                ' version',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              subtitle: Text(
                '2.4.2',
                style: TextStyle(color: Color.fromARGB(255, 159, 209, 203)),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void exitApp() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Do you want to exit'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
