import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinklotus/auth_module/api_calling/login_api.dart';
import 'package:pinklotus/dashboard_module/dashboard_screen.dart';
import 'package:pinklotus/network_call/local_storage.dart';
import 'package:pinklotus/utils/utils_file.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

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
                      Text(
                        "Username",
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
                          hintText: "Enter your username",
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Password Field
                      Text(
                        "Password",
                        style: GoogleFonts.oxygen(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        obscureText: true,
                        controller: passwordController,
                        validator: validatePassword,

                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.pinkAccent,
                              width: 1,
                            ),
                          ),
                          hintText: "Enter your password",
                        ),
                      ),
                      const SizedBox(height: 100),

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
                          onPressed:
                              isLoading
                                  ? null
                                  : () async {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        isLoading = true;
                                      });

                                      try {
                                        final result = await loginUser(
                                          loginId: usernameController.text,
                                          password: passwordController.text,
                                        );

                                        setState(() {
                                          isLoading = false;
                                        });

                                        if (result != null &&
                                            result.status == 'Success') {
                                          LocalStorage.saveToken(
                                            result.token.toString(),
                                          );
                                          LocalStorage.storeUserData(
                                            result.toJson(),
                                          );
                                          LocalStorage.saveUserId(
                                            usernameController.text
                                                .toString()
                                                .trim(),
                                          );
                                          // Navigate to Dashboard
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => DashboardScreen(),
                                            ),
                                            (route) => false,
                                          );
                                        } else {
                                          // Show error toast/snackbar
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                result?.status ??
                                                    'Login failed',
                                              ),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        }
                                      } catch (e) {
                                        setState(() {
                                          isLoading = false;
                                        });

                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Something went wrong: $e',
                                            ),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }
                                    }
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
                              child:
                                  isLoading
                                      ? Center(
                                        child: const CircularProgressIndicator(
                                          color: Colors.pinkAccent,
                                        ),
                                      )
                                      : Text(
                                        "Login",
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
    } else if (value.length < 4) {
      return 'Password must be at least 4 characters';
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
