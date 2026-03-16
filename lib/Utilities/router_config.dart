import 'package:sanad_2025/Models/user_model.dart';
import 'package:sanad_2025/Utilities/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../Models/course_model.dart';
import '../Modules/AboutUs/about_us_screen.dart';
import '../Modules/Auth/ChangePassword/change_password_screen.dart';
import '../Modules/Auth/ForgotPassword/forgot_password_screen.dart';
import '../Modules/Auth/Login/login_screen.dart';
import '../Modules/Auth/Registration/registration_screen.dart';
import '../Modules/ContactUs/contact_us_screen.dart';
import '../Modules/CourseDetails/course_details_screen.dart';
import '../Modules/Courses/courses_screen.dart';
import '../Modules/Experts/experts_screen.dart';
import '../Modules/Home/home_screen.dart';
import '../Modules/Notifications/notifications_screen.dart';
import '../Modules/Settings/settings_screen.dart';
import '../Modules/Splash/splash_screen.dart';
import '../Modules/TrainerDetails/trainers_details_screen.dart';

BuildContext? get CURRENT_CONTEXT => GoRouterConfig.router.routerDelegate.navigatorKey.currentContext;

class GoRouterConfig{
  static GoRouter get router => _router;
  static final GoRouter _router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: SplashScreen.routeName,
        pageBuilder: (_, GoRouterState state) {
          return getCustomTransitionPage(
            state: state,
            child: const SplashScreen(),
          );
        },
        routes: const <RouteBase>[],
      ),
      GoRoute(
        name: LoginScreen.routeName,
        path: "/${LoginScreen.routeName}",
        pageBuilder: (_, GoRouterState state) {
          return getCustomTransitionPage(
            state: state,
            child: const LoginScreen(),
          );
        },
        routes: const <RouteBase>[],
      ),
      GoRoute(
        name: RegistrationScreen.routeName,
        path: "/${RegistrationScreen.routeName}",
        pageBuilder: (_, GoRouterState state) {
          return getCustomTransitionPage(
            state: state,
            child: const RegistrationScreen(),
          );
        },
        routes: const <RouteBase>[],
      ),
      GoRoute(
        name: HomeScreen.routeName,
        path: "/${HomeScreen.routeName}",
        pageBuilder: (_, GoRouterState state) {
          return getCustomTransitionPage(
            state: state,
            child: const HomeScreen(),
          );
        },
        routes: const <RouteBase>[],
      ),
      GoRoute(
        name: CoursesScreen.routeName,
        path: "/${CoursesScreen.routeName}",
        pageBuilder: (_, GoRouterState state) {
          return getCustomTransitionPage(
            state: state,
            child: CoursesScreen(onlyMyCourses: state.extra == true,searchText: state.queryParameters["searchText"]),
          );
        },
        routes: const <RouteBase>[],
      ),
      GoRoute(
        name: ExpertsScreen.routeName,
        path: "/${ExpertsScreen.routeName}",
        pageBuilder: (_, GoRouterState state) {
          return getCustomTransitionPage(
            state: state,
            child: const ExpertsScreen(),
          );
        },
        routes: const <RouteBase>[],
      ),
      GoRoute(
        name: AboutUsScreen.routeName,
        path: "/${AboutUsScreen.routeName}",
        pageBuilder: (_, GoRouterState state) {
          return getCustomTransitionPage(
            state: state,
            child: const AboutUsScreen(),
          );
        },
        routes: const <RouteBase>[],
      ),
      GoRoute(
        name: NotificationsScreen.routeName,
        path: "/${NotificationsScreen.routeName}",
        pageBuilder: (_, GoRouterState state) {
          return getCustomTransitionPage(
            state: state,
            child: const NotificationsScreen(),
          );
        },
        routes: const <RouteBase>[],
      ),
      GoRoute(
        name: SettingsScreen.routeName,
        path: "/${SettingsScreen.routeName}",
        pageBuilder: (_, GoRouterState state) {
          return getCustomTransitionPage(
            state: state,
            child: const SettingsScreen(),
          );
        },
        routes: const <RouteBase>[],
      ),
      GoRoute(
        name: ContactUsScreen.routeName,
        path: "/${ContactUsScreen.routeName}",
        pageBuilder: (_, GoRouterState state) {
          return getCustomTransitionPage(
            state: state,
            child: const ContactUsScreen(),
          );
        },
        routes: const <RouteBase>[],
      ),
      GoRoute(
        name: CourseDetailsScreen.routeName,
        path: "/${CourseDetailsScreen.routeName}",
        pageBuilder: (_, GoRouterState state) {
          return getCustomTransitionPage(
            state: state,
            child: CourseDetailsScreen(
              courseModel: state.extra is CourseModel? state.extra as CourseModel: null,
            ),
          );
        },
        routes: const <RouteBase>[],
      ),
      GoRoute(
        name: TrainerDetailsScreen.routeName,
        path: "/${TrainerDetailsScreen.routeName}",
        pageBuilder: (_, GoRouterState state) {
          return getCustomTransitionPage(
            state: state,
            child: TrainerDetailsScreen(instructor: state.extra is UserModel? state.extra as UserModel: null),
          );
        },
        routes: const <RouteBase>[],
      ),
      GoRoute(
        name: ForgotPasswordScreen.routeName,
        path: "/${ForgotPasswordScreen.routeName}",
        pageBuilder: (_, GoRouterState state) {
          return getCustomTransitionPage(
            state: state,
            child: const ForgotPasswordScreen(),
          );
        },
        routes: const <RouteBase>[],
      ),
      GoRoute(
        name: ChangePasswordScreen.routeName,
        path: "/${ChangePasswordScreen.routeName}",
        pageBuilder: (_, GoRouterState state) {
          return getCustomTransitionPage(
            state: state,
            child: const ChangePasswordScreen(),
          );
        },
        routes: const <RouteBase>[],
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      if(!SharedPref.isLogin() && !expectedRoutes.contains(state.matchedLocation.replaceAll("/", ""))) return "/${LoginScreen.routeName}";
      if(state.matchedLocation.contains(LoginScreen.routeName) && SharedPref.isLogin()) return "/${HomeScreen.routeName}";

      // if(state.matchedLocation == OtpScreen.routeName && state.extra == null){
      //   return ForgotPasswordScreen.routeName;
      // }

      return null;
    },
  );

  static List<String> expectedRoutes = [
    ForgotPasswordScreen.routeName,
    RegistrationScreen.routeName
  ];

  static CustomTransitionPage getCustomTransitionPage({required GoRouterState state, required Widget child}){
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 300),
      reverseTransitionDuration: Duration.zero,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
          child: child,
        );
      },
    );
  }
}





