import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp(
      title: 'Camera & Gallery Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
        '/display_image': (context) => DisplayImageScreen(),
        '/settings': (context) => SettingsScreen(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();

  MyHomePage();

  Future<void> _openCamera(BuildContext context) async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      Navigator.pushNamed(
        context,
        '/display_image',
        arguments: pickedFile.path,
      );
    }
  }

  Future<void> _openGallery(BuildContext context) async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      Navigator.pushNamed(
        context,
        '/display_image',
        arguments: pickedFile.path,
      );
    }
  }

  void _navigateToSettings(BuildContext context) {
    Navigator.pushNamed(context, '/settings'); // Navigate to settings screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Main Screen'),
      ),
      drawer: SideBar(),
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Hello,',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                'What do you want to do today?',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.lightBlue,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.camera),
              onPressed: () => _openCamera(context),
              iconSize: 64.0,
              color: Colors.black,
            ),
            IconButton(
              icon: Icon(Icons.photo),
              onPressed: () => _openGallery(context),
              iconSize: 64.0,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}


class DisplayImageScreen extends StatelessWidget {
  final FlutterTts flutterTts = FlutterTts();

  Future<void> _openCamera(BuildContext context) async {
    final XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      Navigator.pushNamed(
        context,
        '/display_image',
        arguments: pickedFile.path,
      );
    }
  }

  Future<void> _openGallery(BuildContext context) async {
    final XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      Navigator.pushNamed(
        context,
        '/display_image',
        arguments: pickedFile.path,
      );
    }
  }

  Future<void> _speakText(String text) async {
    await flutterTts.setVolume(1.0);
    await flutterTts.setSpeechRate(1.0);
    await flutterTts.setPitch(1.0);

    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    final String imagePath = ModalRoute.of(context)!.settings.arguments as String;
    final String translatedText = 'Translated Text'; // Replace with actual translated text

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Translation'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.home),
            color: Colors.black,
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
          ),
        ],
      ),
      drawer: SideBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Center(
                child: Container(
                  child: Image.file(File(imagePath)),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.volume_up),
                  iconSize: 35,
                  color: Colors.black,
                  onPressed: () {
                    _speakText(translatedText); // Speak translated text
                  },
                ),
                SizedBox(width: 10),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      translatedText,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      backgroundColor: Colors.lightBlue,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.camera),
              onPressed: () => _openCamera(context),
              iconSize: 64.0,
              color: Colors.black,
            ),
            IconButton(
              icon: Icon(Icons.photo),
              onPressed: () => _openGallery(context),
              iconSize: 64.0,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}

class SideBar extends StatelessWidget {
  void _showAboutUsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('About Us'),
          content: Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
            'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
            'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. '
            'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. '
            'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _navigateToSettings(BuildContext context) {
    Navigator.pushNamed(context, '/settings');
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Sidebar',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('Settings'),
            onTap: () {
              _navigateToSettings(context); // Navigate to settings screen
            },
          ),
          ListTile(
            title: Text('About Us'),
            onTap: () {
              _showAboutUsDialog(context); // Show about us dialog
            },
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double _fontSize = 16.0;
  FontWeight _fontWeight = FontWeight.normal;
  double _volume = 0.5; // Assume initial volume level is 50%

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Font Size'),
            subtitle: Slider(
              value: _fontSize,
              min: 10.0,
              max: 30.0,
              onChanged: (value) {
                setState(() {
                  _fontSize = value;
                });
              },
            ),
          ),
          ListTile(
            title: Text('Font Weight'),
            subtitle: DropdownButtonFormField<FontWeight>(
              value: _fontWeight,
              items: [
                DropdownMenuItem<FontWeight>(
                  value: FontWeight.normal,
                  child: Text('Normal'),
                ),
                DropdownMenuItem<FontWeight>(
                  value: FontWeight.bold,
                  child: Text('Bold'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _fontWeight = value!;
                });
              },
            ),
          ),
          ListTile(
            title: Text('Text-to-Speech Volume'),
            subtitle: Slider(
              value: _volume,
              min: 0.0,
              max: 1.0,
              onChanged: (value) {
                setState(() {
                  _volume = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
