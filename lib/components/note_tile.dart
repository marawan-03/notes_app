import 'package:flutter/material.dart';
import 'package:notes_app/logic/auto_direction.dart';
import 'package:provider/provider.dart';

import '../logic/note_provider.dart';
import '../pages/note_page.dart';
import 'delete_dialogue_box.dart';

class NoteTile extends StatelessWidget {
  final Note note;
  NoteTile({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (n) => NotePage(note: note)),
        );
      },
      onLongPressStart: (LongPressStartDetails details) async {
        final double tapX = details.globalPosition.dx;
        final double tapY = details.globalPosition.dy;

        final String? selectedValue = await showMenu<String>(
          context: context,

          position: RelativeRect.fromLTRB(tapX, tapY, tapX, tapY),
          items: const [
            PopupMenuItem<String>(
              value: 'delete',
              child: ListTile(
                leading: Icon(Icons.delete),
                title: Text('Delete Note'),
              ),
            ),
          ],
          elevation: 8.0,
        );
        if (selectedValue != 'delete' || !context.mounted) return;
        final bool? confirmDelete = await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return DeleteDialogueBox();
          },
        );
        if (confirmDelete != true || !context.mounted) return;
        context.read<NoteProvider>().deleteNote(note.id);
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (note.title.isNotEmpty)
              Text(
                note.title,
                maxLines: 1,
                textDirection: directionOf(note.title),
                overflow: TextOverflow.clip,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: isArabic(note.title) ? 18 : 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            if (note.title.isNotEmpty && note.body.isNotEmpty)
              SizedBox(height: 8),
            if (note.body.isNotEmpty)
              Text(
                note.body,
                maxLines: 5,
                style: TextStyle(
                  fontSize: isArabic(note.body) ? 12 : 14,
                  height: 1.6,
                ),
                textDirection: directionOf(note.body),
                textAlign: TextAlign.start,
                overflow: TextOverflow.clip,
              ),
            const SizedBox(height: 12),
            Text(
              note.date,
              style: TextStyle(
                fontSize: 10,
                color: Theme.of(context).colorScheme.primary
                    .withValues(alpha: 0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
