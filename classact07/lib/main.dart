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
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          // Navigate to the second animation screen when a horizontal swipe is detected.
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SecondAnimationScreen()),
          );
        },
        child: Center(
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleVisibility,
        tooltip: 'Toggle Visibility', // Tooltip for accessibility.
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}

// Second screen that demonstrates a different fading animation duration.
class SecondAnimationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Second Fading Animation')),
      body: Center(
        child: FadeInOutText(durationInSeconds: 3),
      ),
    );
  }
}

// Widget to handle the fading text with a configurable duration.
class FadeInOutText extends StatefulWidget {
  final int durationInSeconds;

  FadeInOutText({this.durationInSeconds = 1});

  @override
  _FadeInOutTextState createState() => _FadeInOutTextState();
}

class _FadeInOutTextState extends State<FadeInOutText> {
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    // Periodically toggle the visibility to demonstrate the fading effect.
    Future.delayed(Duration(seconds: widget.durationInSeconds), () {
      if (mounted) {
        setState(() {
          _isVisible = !_isVisible;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _isVisible ? 1.0 : 0.0,
      duration: Duration(seconds: widget.durationInSeconds),
      child: Text(
        'Different Duration!',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
