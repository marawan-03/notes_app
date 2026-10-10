import 'package:flutter/material.dart';
import 'package:notes_app/Logic/auto_direction.dart';
import 'package:provider/provider.dart';

import '../Logic/note_provider.dart';

class NotePage extends StatefulWidget {
  final Note? note;
  const NotePage({super.key, this.note});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  late final TextEditingController _titleController;
  late final TextEditingController _bodyController;
  late TextDirection _titleDir;
  late TextDirection _bodyDir;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _bodyController = TextEditingController(text: widget.note?.body ?? '');
    _titleDir = directionOf(_titleController.text);
    _bodyDir = directionOf(_bodyController.text);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  void _save() {
    final title = _titleController.text.trim();
    final body = _bodyController.text.trim();
    final provider = context.read<NoteProvider>();

    if (title.isNotEmpty || body.isNotEmpty) {
      if (widget.note == null) {
        provider.addNote(
          Note(
            id: DateTime.now().toString(),
            title: title,
            body: body,
            date: formatedDate(DateTime.now()),
          ),
        );
      } else {
        provider.updateNote(widget.note!.id, title, body);
      }
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final dateText = widget.note?.date ?? formatedDate(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: GestureDetector(
              onTap: _save,
              child: Text(
                'Save',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
            child: TextField(
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              maxLines: 1,
              minLines: 1,
              textDirection: _titleDir,
              textAlign: TextAlign.start,
              controller: _titleController,
              onChanged: (v) => setState(() => _titleDir = directionOf(v)),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Title',
                hintStyle: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.withValues(
                    alpha: Theme.of(context).brightness == Brightness.dark ? 0.5 : 1,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  dateText,
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: Theme.of(context).colorScheme.primary,
                    thickness: 1,
                    indent: 16,
                    endIndent: 16,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              maxLines: null,
              minLines: 1,
              textDirection: _bodyDir,
              textAlign: TextAlign.start,
              controller: _bodyController,
              onChanged: (v) => setState(() => _bodyDir = directionOf(v)),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Start Typing',
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.withValues(
                    alpha: Theme.of(context).brightness == Brightness.dark ? 0.5 : 1,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
