import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinklotus/auth_module/login_screen_otp.dart';
import 'package:pinklotus/dashboard_module/dashboard_screen.dart';
import 'package:pinklotus/utils/utils_file.dart';

class LoginScreenMobile extends StatefulWidget {
  const LoginScreenMobile({super.key});

  @override
  State<LoginScreenMobile> createState() => _LoginScreenMobileState();
}

class _LoginScreenMobileState extends State<LoginScreenMobile> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UtilsFile.backgorundColor,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,

          child: Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: SizedBox(
                  width: 440,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 50),
                      Center(
                        child: Image.asset(
                          "assets/app_logo_login.png",
                          fit: BoxFit.contain,
                          filterQuality: FilterQuality.high,
                          height: 200,
                          width: 240,
                        ),
                      ),
                      // Username Field
                      const SizedBox(height: 30),

                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: Text(
                            "Login  or Sign Up",
                            style: GoogleFonts.oxygen(
                              fontSize: 18,

                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Text(
                        "Mobile Number",
                        style: GoogleFonts.oxygen(
                          fontSize: 16,

                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: usernameController,
                        validator: validateUsername,

                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Enter your mobile",
                        ),
                      ),

                      // Password Field
                      const SizedBox(height: 30),

                      // Login Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.zero,
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                          ),
                          onPressed: () {
                            // Login action
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (builder) => LoginScreenOtp(),
                              ),
                             
                            );
                          },
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.pink.shade100,
                                  Colors.pink.shade200,
                                  Colors.pink.shade300,
                                  Colors.pink.shade400,
                                  Colors.pink.shade500,
                                  Colors.pink.shade600,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                "Continue",
                                style: GoogleFonts.oxygen(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 1,
                        color: Colors.grey,
                        margin: EdgeInsets.symmetric(vertical: 40),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Design and Developed by ",
                            style: GoogleFonts.oxygen(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            " TUDUM SOFTWARE PRIVATE LIMITED   ",
                            style: GoogleFonts.oxygen(
                              fontSize: 12,
                              color: Colors.pinkAccent,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Username is required';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  @override
  void dispose() {
    usernameController.clear();
    passwordController.clear();
    super.dispose();
  }
}
