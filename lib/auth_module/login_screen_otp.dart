import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:pinklotus/auth_module/login_screen.dart';
import 'package:pinklotus/auth_module/login_screen_user_details.dart';
import 'package:pinklotus/dashboard_module/dashboard_screen.dart';
import 'package:pinklotus/utils/utils_file.dart';

class LoginScreenOtp extends StatefulWidget {
  const LoginScreenOtp({super.key});

  @override
  State<LoginScreenOtp> createState() => _LoginScreenOtpState();
}

class _LoginScreenOtpState extends State<LoginScreenOtp> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController otpController = TextEditingController();

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
                          width: 200,
                        ),
                      ),
                      // Username Field
                      const SizedBox(height: 10),

                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: Text(
                            "Welcome",
                            style: GoogleFonts.oxygen(
                              fontSize: 18,

                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Text(
                          "Please enter the 6 digit OTP  that we just sent \non your mobile number",
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.oxygen(
                            fontSize: 14,

                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: PinCodeTextField(
                          appContext: context,
                          length: 6,
                          controller: otpController,
                          keyboardType: TextInputType.number,
                          animationType: AnimationType.fade,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(12),
                            fieldHeight: 50,
                            fieldWidth: 45,
                            activeColor: Colors.grey.shade300,
                            inactiveColor: Colors.grey.shade300,
                            selectedColor: Colors.white,
                            activeFillColor: Colors.white.withOpacity(0.9),
                            inactiveFillColor: Colors.white.withOpacity(0.6),
                            selectedFillColor: Colors.white,
                          ),
                          animationDuration: Duration(milliseconds: 300),
                          enableActiveFill: true,
                          onCompleted: (value) {
                            print("OTP Entered: $value");
                          },
                          onChanged: (value) {},
                        ),
                      ),

                      // Password Field
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: Text(
                            "Re send OTP",
                            style: GoogleFonts.oxygen(
                              fontSize: 14,
                              textStyle: TextStyle(
                                decorationColor: Colors.pinkAccent,
                                decoration: TextDecoration.underline,
                              ),
                              color: Colors.pinkAccent,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),

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
                                builder: (builder) => LoginScreenUserDetails(),
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
                      Center(
                        child: GestureDetector(
                          onTap: () {
                              Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (builder) => LoginScreen(),
                              ),
                              (route) => false,
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            child: Text(
                              "Trouble getting OTP? Login with password",
                          
                              style: GoogleFonts.oxygen(
                                fontSize: 14,
                                textStyle: TextStyle(
                                  decoration: TextDecoration.underline,
                                ),
                                fontWeight: FontWeight.w400,
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
