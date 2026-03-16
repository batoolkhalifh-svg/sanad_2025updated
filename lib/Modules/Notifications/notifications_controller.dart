import 'package:sanad_2025/Modules/Notifications/notifications_data_handler.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../Models/notification_model.dart';
import '../../Utilities/toast_helper.dart';

class NotificationsController extends ControllerMVC {
  // singleton
  factory NotificationsController() {
    _this ??= NotificationsController._();
    return _this!;
  }
  static NotificationsController? _this;
  NotificationsController._();


  bool loading = false;

  List<NotificationModel> notifications = [];



  Future init()async{
    setState(() {loading = true;});
    final result = await NotificationsDataHandler.getNotifications();
    result.fold((l) => ToastHelper.showError(message: l.message), (r) => notifications = r);
    setState(() {loading = false;});
  }
}
