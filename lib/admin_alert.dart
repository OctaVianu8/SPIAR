import 'package:flutter/material.dart';

class AdminAlert extends StatefulWidget {
  const AdminAlert({super.key});

  @override
  State<AdminAlert> createState() => _AdminAlertState();
}

class _AdminAlertState extends State<AdminAlert> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Alert'),
      content: Text(
          'You need administrator priviliges to access the configure tab.'),
      actions: [
        TextButton(
          child: const Text('Enter'),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/configure');
          },
        ),
      ],
    );
  }
}
