import 'package:flutter/material.dart';
import 'package:list_app/cubit/note_cubit.dart';
import 'package:list_app/model/note_model.dart';
import 'package:list_app/screens/edit_note_page.dart';
import 'package:list_app/theme/pallete.dart';
import 'package:list_app/screens/add_notes_page.dart';
import 'package:list_app/screens/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NoteCubit>(
          create: (context) => NoteCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Note App',
        theme: Pallete.darkModeAppTheme,
        initialRoute: '/',
        routes: {
          '/': (_) => const HomePage(),
          '/add-notes': (_) => const AddNotePage(),
          '/edit-note': (context) => EditNotePage(
              note: ModalRoute.of(context)!.settings.arguments as NoteModel),
        },
      ),
    );
  }
}
