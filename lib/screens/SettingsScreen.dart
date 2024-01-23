import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool _isLight;

  @override
  void initState() {
    super.initState();
    _isLight = true; // Initialize _isLight here
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLight = prefs.getBool('isLight') ?? false;
    });
  }

  Future<void> _saveTheme(bool isLight) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLight', isLight);
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double width = mediaQuery.size.width;

    return Scaffold(
      appBar: _appbar(),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 25)),
            GestureDetector(
              onTap: () {
                // _showLanguageBottomSheet(context);
              },
              child: Container(
                width: (width * 6.5) / 10,
                padding: const EdgeInsets.fromLTRB(5, 8, 5, 8),
                decoration: const BoxDecoration(color: Colors.transparent),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize
                      .min, // Set mainAxisSize to minimize vertical space
                  children: [
                    Icon(Icons.language),
                    SizedBox(width: 8),
                    Text(
                      "Change Language",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Icon(Icons.arrow_right_alt_rounded),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                print("theme tıklandı");
                setState(() {
                  _isLight = !_isLight;
                  _saveTheme(_isLight);
                });
              },
              child: Container(
                width: (width * 6.5) / 10,
                padding: const EdgeInsets.fromLTRB(5, 8, 5, 8),
                decoration: const BoxDecoration(color: Colors.transparent),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize
                      .min, // Set mainAxisSize to minimize vertical space
                  children: [
                    Icon(Icons.nights_stay_outlined),
                    SizedBox(width: 8),
                    const Text(
                      "Theme",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Switch(
                        value: _isLight,
                        onChanged: (bool value) {
                          setState(() {
                            _isLight = value;
                            _saveTheme(_isLight);
                          });
                        })
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  AppBar _appbar() {
    return AppBar(
      title: const Text(
        "Settings",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      leading: GestureDetector(
        onTap: () {
          print("left arrow tıklandı.");
        },
        child: const Icon(
          Icons.keyboard_arrow_left,
          size: 26,
        ),
      ),
    );
  }
}
