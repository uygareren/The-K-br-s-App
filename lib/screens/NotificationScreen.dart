import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_kibris/models/NotificationModel.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationModel> notificationList = [];

  String formatNewsDate(String originalDate) {
    DateTime parsedDate = DateTime.parse(originalDate);
    String formattedDate = DateFormat('dd MMMM yyyy HH:mm').format(parsedDate);
    return formattedDate;
  }

  @override
  void initState() {
    super.initState();
    notificationList = NotificationModel.getNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: _buildNotificationList(),
    );
  }

  AppBar _appbar() {
    return AppBar(
      title: const Text(
        "Notifications",
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

  Widget _buildNotificationList() {
    return ListView.builder(
      padding: EdgeInsets.only(top: 25),
      itemCount: notificationList.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildNotificationCard(notificationList[index]);
      },
    );
  }

  Widget _buildNotificationCard(NotificationModel notification) {
    String formattedDate = formatNewsDate(notification.date);

    String truncatedName = notification.title.length > 30
        ? notification.title.substring(0, 30) + "..."
        : notification.title;

    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 10),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: const Color(0xff1D1617).withOpacity(0.11),
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
                child: Image.network(notification.image),
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
                        formattedDate,
                        style: TextStyle(),
                      ),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          notification.category_name,
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                      )
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
}
