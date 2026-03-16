import 'package:sanad_2025/Models/home_model.dart';
import 'package:sanad_2025/Models/settings_model.dart';
import 'package:sanad_2025/Utilities/shared_preferences.dart';
import 'package:sanad_2025/Utilities/toast_helper.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../core/API/request_method.dart';

class HomeController extends ControllerMVC {
  factory HomeController() {
    _this ??= HomeController._();
    return _this!;
  }
  static HomeController? _this;
  HomeController._();

  bool loading = false;
  HomeModel homeData = HomeModel();

  // =========================
  // LOGIN تلقائي إذا ما في Token
  // =========================
  Future<void> _autoLoginIfNeeded() async {
    final token = await SharedPref.getToken();

    if (token != null && token.isNotEmpty) {
      print("Token موجود ✔️");
      return;
    }

    print("ما في Token → تسجيل دخول تلقائي");

    var loginRequest = RequestApi.postJson(
      url: "https://sanad.alfarid.info/api/login",
      auth: false,
      bodyJson: {
        "email": "aws@gmail.com",
        "password": "123456",
        "device_token":
        "euz-vidfR1q5ekIrFsWqRL:APA91bHXo6V4VhqUpZLx-w8kR3Dp4FfTG_Z7Y5AQyX6L6tTXLrGckFV6dCenG-kQCe8hamrqEYyVDrLFnWzHXDgyL6CGZli07vwD9xcdCIjxUHeQBJdIFIE",
      },
    );

    final response = await loginRequest.requestJson();

    if (response["status"] == true) {
      await SharedPref.saveToken(response["data"]["token"]);
      print("تم حفظ Token بنجاح ✅");
    } else {
      throw Exception(response["msg"]);
    }
  }

  // =========================
  // HOME
  // =========================
  Future<void> _getHomeData() async {
    var request = RequestApi.get(
      url: "https://sanad.alfarid.info/api/home?lang=ar",
      auth: false,
    );

    var response = await request.requestJson();
    homeData = HomeModel.fromJson(response['data']);
  }

  // =========================
  // SETTINGS
  // =========================
  Future<void> _getAppSettings() async {
    var request = RequestApi.get(
      url: "https://sanad.alfarid.info/api/settings?lang=ar",
      auth: false,
    );

    var response = await request.requestJson();

    // حول JSON إلى SettingsModel
    SettingsModel settings = SettingsModel.fromJson(response['data']);

    // احفظه في SharedPref
    SharedPref.saveAppSettings(settings: settings);
  }

  // =========================
  // INIT
  // =========================
  Future<void> init() async {
    setState(() => loading = true);

    try {
      await _autoLoginIfNeeded();

      await Future.wait([
        _getHomeData(),
        _getAppSettings(),
      ]);
    } catch (e) {
      ToastHelper.showError(message: e.toString());
      print("INIT ERROR: $e");
    }

    setState(() => loading = false);
  }
}
