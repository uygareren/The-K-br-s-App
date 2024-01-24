import 'package:easy_localization/easy_localization.dart';
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
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(5, 8, 5, 8),
                decoration: const BoxDecoration(color: Colors.transparent),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize
                      .min, // Set mainAxisSize to minimize vertical space
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Row(
                        children: [
                          Icon(Icons.language),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "change_language".tr(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                print("theme tıklandı");
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(5, 8, 5, 8),
                decoration: const BoxDecoration(color: Colors.transparent),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize
                      .min, // Set mainAxisSize to minimize vertical space
                  children: [
                    Row(
                      children: [
                        Icon(Icons.light_mode_sharp),
                        SizedBox(width: 8),
                        BlocBuilder<ThemeBloc, ThemeMode>(
                          builder: (context, themeState) {
                            return Text(
                              themeState == ThemeMode.dark
                                  ? "dark_mode".tr()
                                  : "light_mode".tr(),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            );
                          },
                        ),
                      ],
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
      title: Text(
        "settings".tr(),
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
