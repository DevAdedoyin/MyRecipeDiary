import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myrecipediary/routing/go_router_provider.dart';
import 'package:myrecipediary/themes/theme.dart';
import 'package:myrecipediary/themes/theme_manager.dart';
import 'package:myrecipediary/themes/theme_notifier.dart';
import 'firebase_options.dart';

Future<void> main() async {
  // await dotenv.load(fileName: ".env");
  // FirebaseInitialization.initializeFirebase();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  // WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyRecipeDiary()));
}

class MyRecipeDiary extends ConsumerStatefulWidget {
  const MyRecipeDiary({super.key});

  @override
  ConsumerState<MyRecipeDiary> createState() => _MyRecipeDiaryState();
}

class _MyRecipeDiaryState extends ConsumerState<MyRecipeDiary> {
  @override
  Widget build(BuildContext context) {
    ThemeManager themeManager = ThemeManager();
    // final router = ref.watch(goRouterProvider);
    final themeMode = ref.watch(themeNotifierProvider);
    return MaterialApp.router(
      routeInformationParser: goRouter.routeInformationParser,
      routeInformationProvider: goRouter.routeInformationProvider,
      routerDelegate: goRouter.routerDelegate,
      debugShowCheckedModeBanner: false,
      title: 'My Recipe Diary',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
    );
  }
}
