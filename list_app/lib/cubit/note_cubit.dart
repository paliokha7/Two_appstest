import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:list_app/model/note_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoteCubit extends Cubit<List<NoteModel>> {
  NoteCubit() : super([]);

  List<NoteModel> notes = [];

  void addNote(String title, String description, BuildContext context) {
    if (title.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Заголовок і опис не можуть бути порожніми'),
        ),
      );
      return;
    }

    notes.add(
      NoteModel(
        title: title,
        description: description,
      ),
    );
    emit([...notes]);
    saveNotes();
  }

  void editNote(NoteModel oldNote, String newTitle, String newDescription) {
    final updatedNote = NoteModel(
      title: newTitle,
      description: newDescription,
    );

    final index = notes.indexOf(oldNote);
    if (index != -1) {
      notes[index] = updatedNote;
      emit([...notes]);
      saveNotes();
    }
  }

  void deleteNote(int index) {
    notes.removeAt(index);
    emit(notes);
    saveNotes();
  }

  Future<void> loadNotes() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final storedNotes = prefs.getStringList('notes') ?? [];
      notes = storedNotes
          .map((noteStr) => NoteModel.fromJson(jsonDecode(noteStr)))
          .toList();
      emit([...notes]);
    } catch (e) {
      print('Error loading notes: $e');
    }
  }

  Future<void> saveNotes() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final notesToStore = notes.map((note) => note.toJson()).toList();
      await prefs.setStringList(
          'notes', notesToStore.map((note) => jsonEncode(note)).toList());
    } catch (e) {
      print('Error saving notes: $e');
    }
  }
}
