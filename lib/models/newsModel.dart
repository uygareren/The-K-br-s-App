class NewsModel {
  final String key;
  final String url;
  final String description;
  final String image;
  final String name;
  final String source;
  final String date;

  NewsModel(this.key, this.url, this.description, this.image, this.name,
      this.source, this.date);

  // Constructor for creating an instance from JSON
  NewsModel.fromJson(Map<String, dynamic> json)
      : key = json['key'] ?? "",
        url = json['url'] ?? "",
        description = json['description'] ?? "",
        image = json['image'] ?? "",
        name = json['name'] ?? "",
        source = json['source'] ?? "",
        date = json['date'] ?? "";
}
