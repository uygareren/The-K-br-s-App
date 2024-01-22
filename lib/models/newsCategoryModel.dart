class NewsCategoryModel {
  final String categoryName;

  NewsCategoryModel({required this.categoryName});

  static List<NewsCategoryModel> getNewsCategoryName() {
    List<NewsCategoryModel> categoryNames = [];

    categoryNames.add(NewsCategoryModel(categoryName: "All News"));
    categoryNames.add(NewsCategoryModel(categoryName: "Business"));
    categoryNames.add(NewsCategoryModel(categoryName: "Politics"));
    categoryNames.add(NewsCategoryModel(categoryName: "Tech"));
    categoryNames.add(NewsCategoryModel(categoryName: "Science"));
    categoryNames.add(NewsCategoryModel(categoryName: "Sports"));

    return categoryNames;
  }
}
