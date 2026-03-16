import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingWidget extends StatelessWidget {
  final Widget child;
  final bool loading;
  final bool showAsOpacity;
  const LoadingWidget({Key? key, required this.child, this.loading = false,this.showAsOpacity = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(showAsOpacity) {
      return Stack(
        children: [
          child,
          if(loading)
            Container(
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: Colors.grey.withOpacity(0.5),
                ),
                width: 200.r,
                height: 200.r,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              ),
            )
        ],
      );
    }
    if(loading) {
      return Container(
        alignment: Alignment.center,
        child: const CircularProgressIndicator(),
      );
    }
    return child;
  }
}
