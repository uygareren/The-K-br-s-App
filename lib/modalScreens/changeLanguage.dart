import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_kibris/bloc/theme_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Import BlocBuilder
import 'package:the_kibris/models/changeLanguageModal.dart';

class ChangeLanguage extends StatefulWidget {
  const ChangeLanguage({Key? key}) : super(key: key);

  @override
  _ChangeLanguageState createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {
  List<ChangeLanguageModal> languages = [];
  late SharedPreferences _prefs;

  void _getLanguages() {
    setState(() {
      languages = ChangeLanguageModal.getLanguageName();
    });
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> _saveSelectedLanguage(String id) async {
    await _prefs.setString('selectedLanguageId', id);
  }

  void _changeLanguage() {
    var id = _getSelectedLanguage();

    if (id == "1") {
      context.setLocale(Locale('tr', 'TR'));
    } else if (id == "2") {
      context.setLocale(Locale('en', 'US'));
    }
  }

  String _getSelectedLanguage() {
    return _prefs.getString('selectedLanguageId') ?? '';
  }

  @override
  void initState() {
    super.initState();
    _initPrefs().then((_) {
      // After initializing SharedPreferences, load languages
      _getLanguages();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
      child: Container(
        width: double.infinity,
        child: IntrinsicHeight(
          child: SingleChildScrollView(
            child: Column(
              children: languages.map((language) {
                bool isSelected = language.id == _getSelectedLanguage();
                return GestureDetector(
                  onTap: () {
                    _saveSelectedLanguage(language.id);
                    _changeLanguage();
                    setState(() {});
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        padding: EdgeInsets.only(right: 10),
                        child: SvgPicture.asset(language.country_icon),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(language.country_name),
                            if (isSelected)
                              BlocBuilder<ThemeBloc, ThemeMode>(
                                builder: (context, state) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 25),
                                    child: Icon(
                                      Icons.check,
                                      color: state == ThemeMode.dark
                                          ? Colors.green
                                          : Colors.black,
                                    ),
                                  );
                                },
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
