import 'package:flutter/material.dart';

class DeleteDialogueBox extends StatelessWidget {

  const DeleteDialogueBox({super.key});

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
