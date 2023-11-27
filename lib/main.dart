import 'package:flutter/material.dart';
import 'package:fooderlich/models/profile_manger.dart';
import 'fooderlich_theme.dart';
import 'package:provider/provider.dart';
import 'models/models.dart';
import 'navigation/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appStateManger = AppStateManger();
  await appStateManger.initializeApp();
  runApp(Fooderlich(appStateManger: appStateManger));
}

class Fooderlich extends StatefulWidget {
  final AppStateManger appStateManger;

  const Fooderlich({
    super.key,
    required this.appStateManger,
  });

  @override
  State<Fooderlich> createState() => _FooderlichState();
}

class _FooderlichState extends State<Fooderlich> {
  late final _groceryManger = GroceryManger();
  late final _profileManger = ProfileManger();
  late final _appRouter = AppRouter(
    widget.appStateManger,
    _profileManger,
    _groceryManger,
  );

  @override
  Widget build(BuildContext context) {
    final router = _appRouter.router;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => _groceryManger,
        ),
        ChangeNotifierProvider(
          create: (context) => _profileManger,
        ),
        ChangeNotifierProvider(
          create: (context) => widget.appStateManger,
        ),
      ],
      child: Consumer<ProfileManger>(
        builder: (context, profileManger, child) {
          ThemeData themeData;
          if (profileManger.darkMode) {
            themeData = FooderlichTheme.dark();
          } else {
            themeData = FooderlichTheme.light();
          }
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: themeData,
            title: 'Fooderlich',
            routerDelegate: router.routerDelegate,
            routeInformationParser: router.routeInformationParser,
            routeInformationProvider: router.routeInformationProvider,
          );
        },
      ),
    );
  }
}