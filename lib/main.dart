import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinklotus/auth_module/login_screen.dart';
import 'package:pinklotus/auth_module/login_screen_mobile.dart';
import 'package:pinklotus/auth_module/login_screen_otp.dart';
import 'package:pinklotus/auth_module/login_screen_user_details.dart';
import 'package:pinklotus/dashboard_module/dashboard_screen.dart';
import 'package:pinklotus/network_call/local_storage.dart';
import 'package:pinklotus/utils/utils_file.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Required!
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GMR-DF Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.oxygenTextTheme(),
        primarySwatch: Colors.pink, // Example primary color
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  Future<void> checkLogin() async {
    await Future.delayed(const Duration(milliseconds: 10)); // Simulate splash delay
    final token = await LocalStorage.getToken();

    if (token != null && token.isNotEmpty) {
       Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, _, __) =>  DashboardScreen(),
          transitionDuration: Duration.zero, // No animation
        ),
      );
   
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UtilsFile.backgorundColor,

      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to PinkLotus',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Image.asset(
                "assets/app_logo_login.png",
                fit: BoxFit.contain,
                filterQuality: FilterQuality.high,
                height: 200,
                width: 200,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
