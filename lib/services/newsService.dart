import 'package:dio/dio.dart';
import 'package:the_kibris/models/newsModel.dart';

class NewsService {
  Future<List<NewsModel>> getNewsData() async {
    const String url =
        "https://api.collectapi.com/news/getNews?country=tr&tag=generalll";

    const Map<String, dynamic> headers = {
      "authorization": "apikey 1OGei4mP0T6ckQSX0gYHbi:5FqwgyA9gG3GOq5T1jx2d4",
      "content-type": "application/json"
    };

    final dio = Dio();

    final response = await dio.get(url, options: Options(headers: headers));

    if (response.statusCode != 200) {
      return Future.error("Bir sorun oluştu!");
    }

    final List list = response.data["result"];
    final List<NewsModel> newsList =
        list.map((e) => NewsModel.fromJson(e)).toList();

    return newsList;
  }
}
