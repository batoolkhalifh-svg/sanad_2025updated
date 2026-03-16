
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Utilities/theme_helper.dart';

class ShowBottomSheet{
  final Widget child;
  final BuildContext context;

  ShowBottomSheet({required this.child, required this.context}){
    _show();
  }

  _show(){
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context){
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: ThemeClass.of(context).background,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.r),
              topRight: Radius.circular(24.r),
            ),
          ),
          padding: MediaQuery.of(context).viewInsets,
          // padding: EdgeInsets.symmetric(vertical: 16.h,horizontal: 16.w),
          child: child,
        );
      },
    );
  }
}