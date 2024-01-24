import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_kibris/bloc/theme_bloc.dart';
import 'package:the_kibris/modalScreens/changeLanguage.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void _showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => const ChangeLanguage(),
    );
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
                _showLanguageBottomSheet(context);
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
                    Icon(Icons.light_mode_sharp),
                    SizedBox(width: 8),
                    BlocBuilder<ThemeBloc, ThemeMode>(
                      builder: (context, themeState) {
                        return Text(
                          themeState == ThemeMode.dark
                              ? "Dark Mode"
                              : "Light Mode",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        );
                      },
                    ),
                    BlocBuilder<ThemeBloc, ThemeMode>(
                      builder: (context, themeState) {
                        return Switch(
                          value: themeState == ThemeMode.dark,
                          onChanged: (bool value) {
                            context.read<ThemeBloc>().add(ThemeChanged(value));
                          },
                        );
                      },
                    )
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
      leading: GestureDetector(
        onTap: () {
          print("left arrow tıklandı.");
        },
      ),
    );
  }
}
