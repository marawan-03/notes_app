import 'package:flutter/material.dart';

import '../Logic/note_provider.dart';

class DeleteDialogueBox extends StatelessWidget {
  final Note note;

  const DeleteDialogueBox({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Delete Note',
        style: TextStyle(color: Theme.of(context).colorScheme.primary),
      ),
      content: const Text('Are you sure you want to delete this note?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
