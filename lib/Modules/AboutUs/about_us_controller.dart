import 'package:mvc_pattern/mvc_pattern.dart';

class AboutUsController extends ControllerMVC {
  // singleton
  factory AboutUsController() {
    _this ??= AboutUsController._();
    return _this!;
  }
  static AboutUsController? _this;
  AboutUsController._();

}
