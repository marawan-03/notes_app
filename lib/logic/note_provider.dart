import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class Note {
  final String id;
  String title;
  String body;
  String date;
  int updatedAt;

  Note({
    required this.id,
    required this.title,
    required this.body,
    required this.date,
    int? updatedAt,
  }) : updatedAt = updatedAt ?? DateTime.now().millisecondsSinceEpoch;

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'body': body,
    'date': date,
    'updatedAt': updatedAt,
  };

  factory Note.fromMap(Map map) => Note(
    id: map['id'],
    title: map['title'],
    body: map['body'],
    date: map['date'],
    updatedAt:
    map['updatedAt'] ?? DateTime.tryParse(map['id'])?.millisecondsSinceEpoch,
  );
}

String formatedDate(DateTime d) => DateFormat('MMM d, yyyy - h:mm a').format(d);

class NoteProvider with ChangeNotifier {
  final List<Note> _notes = [];
  final Box _box = Hive.box('notesBox');

  NoteProvider() {
    _loadNotes();
  }

  List<Note> get notes => List.unmodifiable(_notes);

  void _loadNotes() {
    for (final item in _box.values) {
      _notes.add(Note.fromMap(Map.from(item)));
    }
    _notes.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
  }

  Future<void> addNote(Note note) async {
    _notes.insert(0, note);
    notifyListeners();
    await _box.put(note.id, note.toMap());
  }

  Future<void> updateNote(String id, String title, String content) async {
    final index = _notes.indexWhere((note) => note.id == id);
    if (index == -1) return;

    final now = DateTime.now();
    final note = _notes.removeAt(index);

    note.title = title;
    note.body = content;
    note.date = formatedDate(now);
    note.updatedAt = now.millisecondsSinceEpoch;

    _notes.insert(0, note);
    notifyListeners();
    await _box.put(note.id, note.toMap());
  }

  Future<void> deleteNote(String id) async {
    _notes.removeWhere((note) => note.id == id);
    notifyListeners();
    await _box.delete(id);
  }
}
