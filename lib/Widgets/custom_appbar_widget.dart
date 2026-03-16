import 'package:sanad_2025/Modules/Courses/courses_screen.dart';
import 'package:sanad_2025/Utilities/theme_helper.dart';
import 'package:sanad_2025/Widgets/menu_widget.dart';
import 'package:sanad_2025/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../Modules/Notifications/notifications_screen.dart';
import '../Utilities/text_style_helper.dart';
import 'bottom_sheet_widget.dart';
import 'custom_textfield_widget.dart';

class CustomAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool isMainScreen;
  final bool withShadow;
  final String? searchText;

  const CustomAppBarWidget.homeScreen({
    Key? key,
    this.withShadow = false,
    this.searchText,
  })  : isMainScreen = true,
        title = null,
        super(key: key);

  const CustomAppBarWidget.detailsScreen({
    Key? key,
    this.title,
    this.withShadow = false,
  })  : isMainScreen = false,
        searchText = null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isMainScreen) return _HomeAppBarWidget(searchText: searchText);
    return _DetailsAppBarWidget(title: title ?? "", withShadow: withShadow);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HomeAppBarWidget extends StatefulWidget {
  final String? searchText;
  const _HomeAppBarWidget({Key? key, this.searchText}) : super(key: key);

  @override
  State<_HomeAppBarWidget> createState() => _HomeAppBarWidgetState();
}

class _HomeAppBarWidgetState extends State<_HomeAppBarWidget> {
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    if (widget.searchText != null) isSearching = true;
  }

  @override
  void didUpdateWidget(covariant _HomeAppBarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (isSearching) isSearching = false;
    if (widget.searchText != null) isSearching = true;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 312.w,
      height: 100.h,
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 20.w, right: 20.w),
        child: Row(
          children: [
            InkWell(
              onTap: () => ShowBottomSheet(
                  context: context, child: const MenuWidget()),
              child: Icon(
                Icons.menu,
                size: 30.r,
                color: ThemeClass.of(context).reversedColor,
              ),
            ),
            SizedBox(width: 12.w),
            if (isSearching)
              CustomTextFieldWidget(
                height: 40.h,
                width: 300.w,
                borderRadiusValue: 40.r,
                suffixIcon: Icon(Icons.search, size: 28.r),
                controller:
                TextEditingController(text: widget.searchText ?? ""),
                textInputAction: TextInputAction.search,
                onSave: (value) {
                  context.pushNamed(
                      CoursesScreen.routeName,
                      queryParameters: {"searchText": value ?? ""});
                  setState(() => isSearching = false);
                },
              ),
            if (isSearching) const Spacer(),
            if (isSearching)
              InkWell(
                onTap: () => setState(() => isSearching = false),
                child: Icon(Icons.close,
                    size: 28.r, color: ThemeClass.of(context).reversedColor),
              ),
            if (!isSearching)
              InkWell(
                onTap: () =>
                    context.pushNamed(NotificationsScreen.routeName),
                child: Icon(Icons.notifications_none_outlined,
                    size: 30.r, color: ThemeClass.of(context).reversedColor),
              ),
            if (!isSearching) SizedBox(width: 20.w),
            if (!isSearching)
              InkWell(
                  onTap: () => setState(() => isSearching = true),
                  child: Image.asset(
                    Assets.imagesSearch,
                    width: 26.r,
                    height: 26.r,
                  )),
            if (!isSearching) const Spacer(),
            if (!isSearching)
              Image.asset(
                Assets.imagesLogo,
                width: 40.r,
                height: 40.r,
              ),
          ],
        ),
      ),
    );
  }
}

class _DetailsAppBarWidget extends StatelessWidget {
  final String title;
  final bool withShadow;
  const _DetailsAppBarWidget(
      {Key? key, required this.title, required this.withShadow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 312.w,
      height: 100.h,
      decoration: BoxDecoration(
        color: ThemeClass.of(context).background,
        boxShadow: [
          if (withShadow)
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4.r,
                offset: Offset(0, 4.r))
        ],
      ),
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top, left: 20.w, right: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BackButton(
            onPressed: () => context.pop(context),
            color: ThemeClass.of(context).reversedColor,
          ),
          Text(
            title,
            style: TextStyleHelper.of(context)
                .s_18W600
                .copyWith(color: ThemeClass.of(context).reversedColor),
          ),
          SizedBox(width: 26.r),
        ],
      ),
    );
  }
}
