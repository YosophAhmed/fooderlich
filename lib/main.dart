import 'package:flutter/material.dart';
import 'package:fooderlich/models/profile_manger.dart';
import 'package:fooderlich/screens/login_screen.dart';
import 'fooderlich_theme.dart';
import 'screens/home.dart';
import 'package:provider/provider.dart';
import 'models/models.dart';

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

  @override
  Widget build(BuildContext context) {
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
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeData,
            title: 'Fooderlich',
            home: const LoginScreen(),
          );
        },
      ),
    );
  }
}
