import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:the_kibris/bloc/theme_bloc.dart';
import 'package:the_kibris/screens/HomeScreen.dart';
import 'package:the_kibris/screens/NotificationScreen.dart';
import 'package:the_kibris/screens/SearchScreen.dart';
import 'package:the_kibris/screens/SettingsScreen.dart';
import 'package:the_kibris/theme/theme.dart';
import 'package:the_kibris/utils/utils.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
        supportedLocales: [Locale('tr', 'TR'), Locale('en', 'US')],
        path: 'assets/lang',
        saveLocale: true,
        fallbackLocale: Locale('tr', 'TR'),
        child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeBloc>(
      create: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeMode>(
        builder: (context, state) {
          return MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: lightTheme,
            themeMode: state,
            darkTheme: darkTheme,
            home: const MyHomePage(),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final screens = [
    HomeScreen(),
    SearchScreen(),
    NotificationScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: GNav(
        gap: 10,
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
        selectedIndex: _currentIndex,
        onTabChange: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        tabs: [
          GButton(
            icon: Icons.home,
            text: "home".tr(),
          ),
          GButton(
            icon: Icons.search,
            text: "search".tr(),
          ),
          GButton(
            icon: Icons.notifications,
            text: "notification".tr(),
          ),
          GButton(
            icon: Icons.settings,
            text: "settings".tr(),
          ),
        ],
      ),
    );
  }
}
