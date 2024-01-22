class NotificationModel {
  final String category_name;
  final String date;
  final String title;
  final String image;

  NotificationModel(this.category_name, this.date, this.title, this.image);

  static List<NotificationModel> getNotification() {
    List<NotificationModel> notifications = [];

    notifications.add(NotificationModel(
        "Sport",
        "2024-01-22T10:04:36.084Z",
        "Trabzonspor, Bakasetas Transferini Resmen Açıkladı",
        "https://static.bundle.app/news/py-ce08417a89ae415e2f010a531d6c7b60.jpg"));
    notifications.add(NotificationModel(
        "Economy",
        "2024-01-22T10:03:41.084Z",
        "Pegasus’tan ChatGPT Adımı",
        "https://www.getmidas.com/wp-content/uploads/2022/09/pegasus.jpeg"));
    notifications.add(NotificationModel(
        "Economy",
        "2024-01-22T10:04:36.084Z",
        "TÜAD yeni başkanını seçti",
        "https://static.bundle.app/news/pc-2439cf52781e3a2def0f7208cbcdff26.jpg"));
    notifications.add(NotificationModel(
        "Economy",
        "2024-01-22T10:04:36.084Z",
        "TÜAD yeni başkanını seçti",
        "https://static.bundle.app/news/pc-2439cf52781e3a2def0f7208cbcdff26.jpg"));
    notifications.add(NotificationModel(
        "Economy",
        "2024-01-22T10:04:36.084Z",
        "TÜAD yeni başkanını seçti",
        "https://static.bundle.app/news/pc-2439cf52781e3a2def0f7208cbcdff26.jpg"));

    return notifications;
  }
}
