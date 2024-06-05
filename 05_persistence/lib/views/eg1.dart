// Demonstrates the use of shared preferences to persist data.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App1 extends StatelessWidget {
  const App1({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PreferencesList(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PreferencesList extends StatefulWidget {
  const PreferencesList({super.key});

  @override
  State<PreferencesList> createState() => _PreferencesListState();
}

class _PreferencesListState extends State<PreferencesList> {
  bool _darkMode = false;
  bool _showAds = true;
  String _version = '';
  String _language = '';

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // let's pretend this takes a while
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _darkMode = prefs.getBool('darkMode') ?? false;
      _showAds = prefs.getBool('showAds') ?? true;
      _version = prefs.getString('version') ?? '1.0.0';
      _language = prefs.getString('language') ?? 'English';
    });
  }

  _savePreference(String key, dynamic value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is String) {
      await prefs.setString(key, value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preferences'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: _darkMode,
            onChanged: (bool value) {
              setState(() {
                _darkMode = value;
                _savePreference('darkMode', value);
              });
            },
          ),
          SwitchListTile(
            title: const Text('Show Ads'),
            value: _showAds,
            onChanged: (bool value) {
              setState(() {
                _showAds = value;
                _savePreference('showAds', value);
              });
            },
          ),
          ListTile(
            title: const Text('App Version'),
            subtitle: Text(_version),
          ),
          ListTile(
            title: const Text('Language'),
            subtitle: Text(_language),
            onTap: () async {
              String selectedLanguage = await _selectLanguage();
              setState(() {
                _language = selectedLanguage;
                _savePreference('language', selectedLanguage);
              });
            },
          ),
        ],
      ),
    );
  }

  Future<String> _selectLanguage() async {
    return await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Select Language'),
          children: [
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 'English');
              },
              child: const Text('English'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 'Spanish');
              },
              child: const Text('Spanish'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 'French');
              },
              child: const Text('French'),
            ),
          ],
        );
      },
    ) ?? _language;
  }
}
