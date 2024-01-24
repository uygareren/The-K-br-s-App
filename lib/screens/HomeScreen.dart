import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:the_kibris/models/newsCategoryModel.dart';
import 'package:the_kibris/models/newsModel.dart';
import 'package:the_kibris/services/newsService.dart';
import 'package:the_kibris/utils/utils.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // var categoryNames = [
  //   "All News",
  //   "Business",
  //   "Politics",
  //   "Tech",
  //   "Science",
  //   "Sports"
  // ];

  bool _isLoading =
      true; // Veri çekilirken yükleniyor durumunu takip etmek için yeni değişken

  int _selectedCategoryIndex = 0;

  List<String> sliderImages = [
    Utils.banner1,
    Utils.banner2,
    // Add more image paths as needed
  ];

  List<NewsModel> _news = [];
  List<NewsCategoryModel> _categoryNames = [];

  void _getNewsCategoryData() async {
    _categoryNames = NewsCategoryModel.getNewsCategoryName();
  }

  void _getNewsData() async {
    // setState(() {
    //   _isLoading =
    //       true; // Veri çekilirken yükleniyor durumunu true olarak ayarla
    // });
    // _news = await NewsService().getNewsData();
    // setState(() {
    //   _isLoading =
    //       false; // Veri çekildikten sonra yükleniyor durumunu false olarak ayarla
    // });
  }

  String formatNewsDate(String originalDate) {
    DateTime parsedDate = DateTime.parse(originalDate);
    String formattedDate = DateFormat('dd MMMM yyyy HH:mm').format(parsedDate);
    return formattedDate;
  }

  @override
  void initState() {
    _getNewsData();
    _getNewsCategoryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);

    double width = mediaQuery.size.width;
    double height = mediaQuery.size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "The Kıbrıs",
          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 24),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Horizontal category list
            categorySection(),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(25, 25, 0, 0),
                child: Text(
                  "popular_news".tr(),
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                ),
              ),
            ),
            // Carousel Slider
            newsSlider(),
            // Last News text
            Padding(
              padding: EdgeInsets.fromLTRB(25, 25, 0, 25),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "last_news".tr(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: _isLoading
                  ? CircularProgressIndicator() // Veri çekilirken yükleniyor göstergesi göster
                  : _buildNewsList(), // Veri mevcutsa haber listesini oluştur
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(25, 25, 0, 25),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "contact_us".tr(),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ))),
            _buildContactUsSection()
          ],
        ),
      ),
    );
  }

  Padding newsSlider() {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 200.0,
          enlargeCenterPage: true,
          autoPlay: true,
          aspectRatio: 16 / 9,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          viewportFraction: 0.8,
        ),
        items: sliderImages.map((imagePath) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(imagePath),
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  Container categorySection() {
    return Container(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categoryNames.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCategoryIndex = index;
                });
              },
              child: Container(
                padding: const EdgeInsets.only(bottom: 4.0),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: _selectedCategoryIndex == index
                          ? Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black
                          : Colors.transparent,
                      width: 3,
                    ),
                  ),
                ),
                child: Chip(
                  side: BorderSide.none,
                  label: Text(
                    _categoryNames[index].categoryName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNewsList() {
    if (_news.isEmpty) {
      // Haber verisi yoksa bir mesaj veya widget göster
      return Text("Haber yok.");
    }

    // Haber kartlarını oluştur
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _news.length,
      itemBuilder: (context, index) {
        return _newsCard(_news[index]);
      },
    );
  }

  Widget _newsCard(NewsModel news) {
    String formattedDate = formatNewsDate(news.date);

    String truncatedName =
        news.name.length > 30 ? news.name.substring(0, 30) + "..." : news.name;

    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 4),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Color.fromARGB(255, 158, 157, 157).withOpacity(0.11),
              blurRadius: 3,
              spreadRadius: 0.5)
        ]),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 25, 15, 25),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Image.network(news.image),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        truncatedName,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Tarih: $formattedDate",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactUsSection() {
    return Padding(
      padding: EdgeInsets.only(bottom: 50),
      child: Container(
        padding: EdgeInsets.all(16),
        color: Color.fromARGB(31, 6, 6, 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                labelText: 'name'.tr(),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                labelText: 'surname'.tr(),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                labelText: 'email'.tr(),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                labelText: 'phone'.tr(),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(style: BorderStyle.solid),
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle button press
              },
              child: Text(
                'send'.tr(),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
