import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_chat/common/theme/app_theme.dart';
import 'package:todo_chat/di/di.dart';
import 'package:todo_chat/domain/entity/user.dart';
import 'package:todo_chat/presentation/screen/home_screen.dart';
import 'presentation/screen/chat_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await configureDependencies(Environment.dev);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      initialLocation: HomeScreen.routeName,
      routes: <RouteBase>[
        GoRoute(
          path: HomeScreen.routeName,
          pageBuilder: (context, state) => const CupertinoPage(
            child: HomeScreen(),
          ),
        ),
        GoRoute(
          path: ChatScreen.routeName,
          pageBuilder: (context, state) => CupertinoPage(
            child: ChatScreen(
              users: state.extra as List<User>,
            ),
          ),
        ),
      ],
    );

    return MaterialApp.router(
      routerConfig: router,
      title: 'Taro Calculator',
      theme: AppTheme.defaults(),
      debugShowCheckedModeBanner: false,
    );
  }
}
