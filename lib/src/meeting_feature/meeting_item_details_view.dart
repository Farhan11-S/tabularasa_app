import 'package:flutter/material.dart';

/// Displays detailed information about a MeetingItem.
class MeetingItemDetailsView extends StatelessWidget {
  const MeetingItemDetailsView({super.key});

  static const routeName = '/meeting_item';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meeting Details'),
      ),
      body: const Center(
        child: Text('More Information Here'),
      ),
    );
  }
}
