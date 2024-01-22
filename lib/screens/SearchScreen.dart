import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double width = mediaQuery.size.width;

    return Scaffold(
      body: Column(children: [searchField(width)]),
    );
  }

  Container searchField(double width) {
    return Container(
      alignment: Alignment.center,
      width: width,
      height: 150,
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: TextField(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            hintText: "Search News..",
            fillColor: HexColor("#f7f5f7"),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}
