import 'package:sanad_2025/Modules/Experts/experts_data_handler.dart';
import 'package:sanad_2025/Utilities/toast_helper.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../Models/user_model.dart';

class ExpertsController extends ControllerMVC {
  // singleton
  factory ExpertsController() {
    _this ??= ExpertsController._();
    return _this!;
  }
  static ExpertsController? _this;
  ExpertsController._();

  bool loading = false;

  List<UserModel> instructors = [];

  Future init()async{
    setState(() {loading = true;});
    final result = await ExpertsDataHandler.getInstructors();
    result.fold((l) => ToastHelper.showError(message: l.message), (r) => instructors = r);
    setState(() {loading = false;});
  }
}
