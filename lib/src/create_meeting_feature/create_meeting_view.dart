import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

// Create a Form widget.
class CreateMeetingView extends StatefulWidget {
  static const routeName = '/create-meeting';
  const CreateMeetingView({super.key});

  @override
  CreateMeetingViewState createState() {
    return CreateMeetingViewState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class CreateMeetingViewState extends State<CreateMeetingView> {
  late DatabaseReference _meetingsRef;

  @override
  void initState() {
    super.initState();
    _meetingsRef = FirebaseDatabase.instance.ref().child('meetings');
  }

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<CreateMeetingViewState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
        key: _formKey,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Create New Meeting'),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'Meeting Title',
                  labelText: 'Name of the meeting',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ElevatedButton(
                  onPressed: () async {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                      Map<String, String> meeting = {"title": "test"};

                      _meetingsRef.push().set(meeting);
                    }
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ));
  }
}
