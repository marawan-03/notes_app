import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notes_app/Components/note_tile.dart';
import 'package:provider/provider.dart';

import '../Logic/note_provider.dart';
import '../Logic/settings_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final notes = context.watch<NoteProvider>().notes;
    final isGrid = context.watch<SettingsProvider>().isGrid;

    return Stack(
      children: [
        Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: AppBar(
            elevation: 0,
            scrolledUnderElevation: 0,
            title: SvgPicture.asset(
              Theme.of(context).brightness == Brightness.dark
                  ? 'assets/dark_appbar_logo.svg'
                  : 'assets/light_appbar_logo.svg',
            ),
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                  icon: Icon(
                    isGrid ? Icons.view_agenda_outlined : Icons.grid_view,
                  ),
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: () =>
                      context.read<SettingsProvider>().toggleView(),
                ),
              ),
            ],
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(16.0),
            // Floating action button to create a new note
            child: FloatingActionButton(
              elevation: 1,
              onPressed: () {
                Navigator.pushNamed(context, '/notepage');
              },
              child: const Icon(Icons.add),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(right: 16, left: 16, top: 4),
            child: MasonryGridView.builder(
              gridDelegate: isGrid
                  ? const SliverSimpleGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 220,
                    )
                  : const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                    ),
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              itemCount: notes.length,
              itemBuilder: (context, index) {
                return NoteTile(note: notes[index]);
              },
            ),
          ),
        ),
        notes.length == 0
            ? Center(
                child: Material(
                  child: Text(
                    'Add a new Note',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 20,
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
