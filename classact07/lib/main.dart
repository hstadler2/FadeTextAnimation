import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  void toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fading Text Animation',
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: FadingTextAnimation(toggleTheme: toggleTheme, isDarkMode: _isDarkMode),
    );
  }
}

class FadingTextAnimation extends StatefulWidget {
  final Function toggleTheme;
  final bool isDarkMode;

  const FadingTextAnimation({Key? key, required this.toggleTheme, required this.isDarkMode}) : super(key: key);

  @override
  _FadingTextAnimationState createState() => _FadingTextAnimationState();
}

class _FadingTextAnimationState extends State<FadingTextAnimation> {
  bool _isVisible = true;
  Color _textColor = Colors.black;

  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  void openColorPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _textColor,
              onColorChanged: (Color color) {
                setState(() {
                  _textColor = color;
                });
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Done'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fading Text Animation'),
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.wb_sunny : Icons.nights_stay),
            onPressed: () => widget.toggleTheme(),
          ),
          IconButton(
            icon: Icon(Icons.color_lens),
            onPressed: openColorPicker,
          ),
        ],
      ),
<<<<<<< HEAD
      body: PageView(
        children: [
          Center(
            child: AnimatedOpacity(
              opacity: _isVisible ? 1.0 : 0.0,
              duration: Duration(seconds: 1),
              curve: Curves.easeInOut,
              child: Text(
                'Hello, Flutter!',
                style: TextStyle(fontSize: 24, color: _textColor),
              ),
=======
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
>>>>>>> b52ad69cb79781ff104c60ec691c80b55cd2fef1
            ),
          ),
          Center(
            child: AnimatedOpacity(
              opacity: _isVisible ? 1.0 : 0.0,
              duration: Duration(seconds: 2),
              curve: Curves.fastOutSlowIn,
              child: Text(
                'Second Screen',
                style: TextStyle(fontSize: 24, color: _textColor),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleVisibility,
        child: Icon(Icons.play_arrow),
      ),
    );
  }
<<<<<<< HEAD
}
=======
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
>>>>>>> b52ad69cb79781ff104c60ec691c80b55cd2fef1
