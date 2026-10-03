import 'package:flutter/material.dart';
import 'screens/library_shell.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PageTrackApp());
}

class PageTrackApp extends StatelessWidget {
  const PageTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    const ink = Color(0xFF172033);
    const navy = Color(0xFF1F3154);
    const cream = Color(0xFFF7F5F0);

    return MaterialApp(
      title: 'PageTrack',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: cream,
        colorScheme: ColorScheme.fromSeed(
          seedColor: navy,
          brightness: Brightness.light,
          surface: cream,
        ),
        fontFamily: 'Arial',
        appBarTheme: const AppBarTheme(
          backgroundColor: cream,
          foregroundColor: ink,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(22)),
            side: BorderSide(color: Color(0xFFE8E4DC)),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          hintStyle: const TextStyle(color: Color(0xFF7C8492)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: Color(0xFFE8E4DC)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: navy, width: 1.4),
          ),
        ),
        navigationBarTheme: const NavigationBarThemeData(
          backgroundColor: Colors.white,
          indicatorColor: Color(0xFFE5EBF5),
          labelTextStyle: WidgetStatePropertyAll(
            TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ),
      home: const LibraryShell(),
    );
  }
}
