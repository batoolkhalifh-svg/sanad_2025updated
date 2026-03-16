import 'package:sanad_2025/Utilities/theme_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Utilities/firebase_operations.dart';
import 'Utilities/git_it.dart';
import 'Utilities/router_config.dart';
import 'package:provider/provider.dart';
import 'core/Font/font_provider.dart';
import 'core/Language/app_languages.dart';
import 'core/Language/locales.dart';
import 'core/Theme/theme_provider.dart';
import 'core/network/dio_client.dart';
import 'firebase_options.dart';
import 'package:sanad_2025/core/network/dio_client.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }
  } catch (e) {
    // تجاهل الخطأ إذا كان Firebase مهيأ مسبقًا
    debugPrint('Firebase already initialized: $e');
  }

  await FireBaseOperations.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await GitIt.initGitIt();
  DioClient.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AppLanguage>(create: (_) => AppLanguage()),
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
        ChangeNotifierProvider<FontProvider>(create: (_) => FontProvider()),
      ],
      child: const EntryPoint(),
    ),
  );
}

class EntryPoint extends StatelessWidget {
  const EntryPoint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLan = Provider.of<AppLanguage>(context);
    final appTheme = Provider.of<ThemeProvider>(context);

    // جلب الإعدادات عند بداية التطبيق
    appLan.fetchLocale();
    appTheme.fetchTheme();

    return ScreenUtilInit(
      designSize: const Size(428, 890),
      builder: (_, __) => MaterialApp.router(
        scrollBehavior: MyCustomScrollBehavior(),
        routerConfig: GoRouterConfig.router,
        debugShowCheckedModeBanner: false,
        title: 'سند',
        locale: Locale(appLan.appLang.name),
        theme: appTheme.appThemeMode?.copyWith(
          scaffoldBackgroundColor: ThemeClass.of(context).background,
          primaryColor: ThemeClass.of(context).primaryColor,
          colorScheme: ThemeData().colorScheme.copyWith(
            primary: ThemeClass.of(context).primaryColor,
          ),
        ),
        supportedLocales: Languages.values.map((e) => Locale(e.name)).toList(),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
          DefaultMaterialLocalizations.delegate,
        ],
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}