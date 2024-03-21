
import 'package:complete_amazon_clone_flutter/features/auth/screens/auth_screen.dart';
import 'package:complete_amazon_clone_flutter/features/auth/services/auth_service.dart';
import 'package:complete_amazon_clone_flutter/providers/user_provider.dart';
import 'package:complete_amazon_clone_flutter/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'common/widgets/bottom_bar.dart';
import 'constant/global_variables.dart';
import 'features/admin/screens/admin_screen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => UserProvider()),
  ], child:  const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  // This widget is the root of your application.
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authService.GetUserData(context: context);
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amazon Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Provider.of<UserProvider>(context).userModel.token.isNotEmpty
          ?  Provider.of<UserProvider>(context).userModel.type == "user"?const BottomBar():
          const AdminScreen()
          : const AuthScreen(),

    );
  }
}
