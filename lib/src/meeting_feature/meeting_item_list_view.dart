import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tabularasa_app/src/create_meeting_feature/create_meeting_view.dart';

import '../settings/settings_view.dart';
import '../model/meeting_item.dart';
import 'meeting_item_details_view.dart';

/// Displays a list of MeetingItems.
class MeetingItemListView extends StatelessWidget {
  const MeetingItemListView({
    super.key,
    this.items = const [
      MeetingItem(1, 'Absensi 17 Februari', ['Test'])
    ],
  });

  static const routeName = '/';

  final List<MeetingItem> items;

  @override
  Widget build(BuildContext context) {
    DatabaseReference _meetingsRef = FirebaseDatabase.instance.ref().child('meetings');
    _meetingsRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      print(data);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meeting Items'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),

      // To work with lists that may contain a large number of items, it’s best
      // to use the ListView.builder constructor.
      //
      // In contrast to the default ListView constructor, which requires
      // building all Widgets up front, the ListView.builder constructor lazily
      // builds Widgets as they’re scrolled into view.
      body: ListView.builder(
        // Providing a restorationId allows the ListView to restore the
        // scroll position when a user leaves and returns to the app after it
        // has been killed while running in the background.
        restorationId: 'MeetingItemListView',
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];

          return ListTile(
              title: Text(item.title),
              leading: const CircleAvatar(
                // Display the Flutter Logo image asset.
                foregroundImage: AssetImage('assets/images/flutter_logo.png'),
              ),
              onTap: () {
                // Navigate to the details page. If the user leaves and returns to
                // the app after it has been killed while running in the
                // background, the navigation stack is restored.
                Navigator.restorablePushNamed(
                  context,
                  MeetingItemDetailsView.routeName,
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.restorablePushNamed(context, CreateMeetingView.routeName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
