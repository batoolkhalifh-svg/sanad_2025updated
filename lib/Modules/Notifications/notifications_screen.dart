import 'package:sanad_2025/Models/notification_model.dart';
import 'package:sanad_2025/Utilities/text_style_helper.dart';
import 'package:sanad_2025/Utilities/theme_helper.dart';
import 'package:sanad_2025/Widgets/loading_widget.dart';
import 'package:sanad_2025/core/Language/locales.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../Utilities/strings.dart';
import '../../Widgets/custom_appbar_widget.dart';
import 'notifications_controller.dart';

class NotificationsScreen extends StatefulWidget {
  static const routeName = "notifications";

  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends StateMVC<NotificationsScreen> {
  _NotificationsScreenState() : super(NotificationsController()) {
    con = NotificationsController();
  }

  late NotificationsController con;


  @override
  void initState() {
    super.initState();
    con.init();
  }

  @override
  Widget build(BuildContext context) {
    return  LoadingWidget(
      loading: con.loading,
      child: Scaffold(
        appBar: CustomAppBarWidget.detailsScreen(title: Strings.notifications.tr,withShadow: true),
        body: ListView.separated(
          itemCount: con.notifications.length,
          itemBuilder: (_,index)=> NotificationWidget(notification: con.notifications[index]),
          separatorBuilder: (_,index)=> Divider(height: 0,thickness: 1.2.r),
        ),
      ),
    );
  }
}


class NotificationWidget extends StatelessWidget {
  final bool isRead;
  final NotificationModel notification;
  const NotificationWidget({super.key, this.isRead = true, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isRead? ThemeClass.of(context).secondary.withOpacity(0.2):ThemeClass.of(context).background,
      padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(notification.title??"",style: TextStyleHelper.of(context).s_22W600,),
          Text(notification.date??"",style: TextStyleHelper.of(context).s_16Reg,),
          Text("${notification.date??""}   -   ${notification.time??""}",style: TextStyleHelper.of(context).s_14Reg,),
        ],
      ),
    );
  }
}

