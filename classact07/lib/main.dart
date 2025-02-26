/*
Harrison Stadler & Abreham Nedi
Mobile App Dev
CSC 4360 
ClassAct07 - Fade Animation
*/

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

// Main application stateful widget to manage themes dynamically.
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Track whether the dark theme is enabled or not.
  bool _isDarkMode = false;

  // Function to toggle between light and dark themes.
  void toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    // MaterialApp now uses the state to toggle between light and dark themes.
    return MaterialApp(
      title: 'Fade Animation App',
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: FadingTextAnimation(toggleTheme: toggleTheme, isDarkMode: _isDarkMode),
    );
  }
}

// Main widget for displaying the fading text animation.
class FadingTextAnimation extends StatefulWidget {
  final Function toggleTheme; // Function to toggle the theme.
  final bool isDarkMode; // Current state of the theme.

  const FadingTextAnimation({Key? key, required this.toggleTheme, required this.isDarkMode}) : super(key: key);

  @override
  _FadingTextAnimationState createState() => _FadingTextAnimationState();
}

class _FadingTextAnimationState extends State<FadingTextAnimation> {
  bool _isVisible = true; // Controls the visibility of the text for the fade effect.

  // Toggles the visibility state to trigger the fading effect.
  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fading Text Animation'),
        // Toggle button in the app bar to switch between day and night modes.
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.wb_sunny : Icons.nights_stay),
            onPressed: () => widget.toggleTheme(),
          )
        ],
      ),
      body: Center(
        // AnimatedOpacity widget animates the opacity from visible to invisible.
        child: AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0.0,
          duration: Duration(seconds: 1),
          child: Text(
            'Hello, Flutter!',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleVisibility,
        tooltip: 'Toggle Visibility', // Tooltip for accessibility.
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
