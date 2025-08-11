import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pinklotus/dashboard_module/network_call/user_profile_update.dart';
import 'package:pinklotus/network_call/base_network.dart';
import 'package:pinklotus/network_call/local_storage.dart';

class UserProfileScreen extends StatefulWidget {
  final Function callBack;
  final String name;
  final String level;
  final String? image;
  const UserProfileScreen({
    super.key,
    required this.callBack,
    required this.name,
    required this.level,
    this.image,
  });

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  File? _profileImage;
  bool _isUploading = false;
  double _uploadProgress = 0;

  // Controllers for form fields
  final _empidController = TextEditingController();
  final _nameController = TextEditingController();
  final _designationController = TextEditingController();
  final _storeController = TextEditingController();
  final _mobileController = TextEditingController();
  final _companyController = TextEditingController();

  @override
  void dispose() {
    _empidController.dispose();
    _nameController.dispose();
    _designationController.dispose();
    _storeController.dispose();
    _mobileController.dispose();
    _companyController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final image = await ProfileService.pickProfileImage();
    if (image != null) {
      setState(() => _profileImage = image);
    }
  }

  Future<void> _submitForm() async {
    // if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isUploading = true;
      _uploadProgress = 0;
    });

    // final success = await ProfileService.updateProfile(
    //   empid: _empidController.text,
    //   empname: _nameController.text,
    //   designation: _designationController.text,
    //   storename: _storeController.text,
    //   mobileno: _mobileController.text,
    //   companyname: _companyController.text,
    //   profileImage: _profileImage,
    //   onUploadProgress: (uploaded, total) {
    //     setState(() {
    //       _uploadProgress = uploaded / total;
    //     });
    //   },
    // );

    await ProfileService.editEmployeeProfile(
      empid: _empidController.text,
      empname: _nameController.text,
      designation: _designationController.text,
      storename: _storeController.text,
      mobileno: _mobileController.text,
      companyname: _companyController.text,
      profileImage: _profileImage,
    );
    setState(() => _isUploading = false);
  }

  bool averageShow = true;
   bool mainGraphShow = true;

  @override
  void initState() {
    // TODO: implement initState
    getUserData();
    super.initState();
  }

  String adminName = "", level = "", storeName = "", image = "";

  List<dynamic> getStoralist = [];

  void getUserData() async {
    Map<String, dynamic>? loadedUser = await LocalStorage.getUserData();
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _nameController.text = loadedUser?['emp_name'];
          _designationController.text = loadedUser?['user_designation'];
          _storeController.text = loadedUser?['STORES'];
          _profileImage = loadedUser?['image_url'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final textStyleLabel = TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
    final textStyleField = TextStyle(fontSize: 16);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FE),

      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => widget.callBack.call(),
                child: Row(
                  children: [
                    Icon(Icons.arrow_back, color: Colors.black),
                    SizedBox(width: 12),
                    Text(
                      'User Profile',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 18),
              Container(
                width: 900,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Stack(
                          children: [
                            // Main profile picture
                            CircleAvatar(
                              radius: 40, // You can change this size
                              backgroundColor: Colors.grey[300],
                              child: ClipOval(
                                child:
                                    widget.image != null &&
                                            widget.image!.isNotEmpty
                                        ? CachedNetworkImage(
                                          imageUrl: widget.image!,
                                          fit: BoxFit.cover,
                                          width: 80,
                                          height: 80,
                                          placeholder:
                                              (context, url) =>
                                                  CircularProgressIndicator(
                                                    color: Colors.pinkAccent,
                                                  ),
                                          errorWidget:
                                              (context, url, error) => Icon(
                                                Icons.person,
                                                color: Colors.black,
                                                size: 40,
                                              ),
                                        )
                                        : Icon(
                                          Icons.person,
                                          color: Colors.black,
                                          size: 40,
                                        ),
                              ),
                            ),

                            // Bottom-right edit icon
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap:
                                    () async =>
                                        await ProfileService.uploadProfilePictureDesktop(),
                                child: CircleAvatar(
                                  radius: 16,
                                  backgroundColor: Colors.pinkAccent,
                                  child: Icon(
                                    Icons.edit,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _nameController.text,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(_companyController.text),
                            Text('-'),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Form(
                      child: Wrap(
                        runSpacing: 16,
                        spacing: 32,
                        children: [
                          SizedBox(
                            width: 380,
                            child: _buildField(
                              'User Name *',
                              _nameController,
                              textStyleLabel,

                              textStyleField,
                            ),
                          ),
                          SizedBox(
                            width: 380,
                            child: _buildField(
                              'Designation *',
                              _designationController,
                              textStyleLabel,
                              textStyleField,
                            ),
                          ),
                          SizedBox(
                            width: 380,
                            child: _buildField(
                              'Mobile Number',
                              _mobileController,
                              textStyleLabel,
                              textStyleField,
                            ),
                          ),
                          SizedBox(
                            width: 380,
                            child: _buildField(
                              'Company Name *',
                              _companyController,
                              textStyleLabel,
                              textStyleField,
                            ),
                          ),
                          SizedBox(
                            width: 380,
                            child: _buildField(
                              'Location Name *',
                              _storeController,
                              textStyleLabel,
                              textStyleField,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        _isUploading
                            ? Center(
                              child: CircularProgressIndicator(
                                color: Colors.pinkAccent,
                              ),
                            )
                            : ElevatedButton(
                              onPressed: () {
                                _submitForm();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                side: const BorderSide(color: Colors.black12),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 32,
                                  vertical: 16,
                                ),
                              ),
                              child: Text('SAVE'),
                            ),
                        const SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: () {
                            if (mounted) {
                              setState(() {
                                isChangePassword = !isChangePassword;
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            side: const BorderSide(color: Colors.black12),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                          ),
                          child: const Text('CHANGE PASSWORD'),
                        ),
                      ],
                    ),
                    if (isChangePassword) changePasshideShow(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isChangePassword = false;
  bool isShowPassword = true;

  Widget changePasshideShow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Wrap(
          spacing: 32,
          runSpacing: 16,
          children: [
            SizedBox(
              width: 380,
              child: _buildPasswordField('Current Password', isShowPassword),
            ),
            SizedBox(
              width: 380,
              child: _buildPasswordField('New Password', isShowPassword),
            ),
          ],
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () {
            if (mounted) {
              setState(() {
                isShowPassword = !isShowPassword;
              });
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pinkAccent,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: const Text('CONFIRM'),
        ),
      ],
    );
  }

  Widget _buildField(
    String label,
    TextEditingController contoller,
    TextStyle labelStyle,
    TextStyle fieldStyle,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: labelStyle),
        const SizedBox(height: 4),
        TextFormField(
          style: fieldStyle,
          controller: contoller,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }

  Widget _buildUploadField(String label, TextStyle labelStyle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: labelStyle),
        const SizedBox(height: 4),
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Choose File',
            enabled: false,

            suffixIcon: const Icon(Icons.camera_alt_outlined),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField(String label, isShowPassword) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 4),
        TextFormField(
          obscureText: isShowPassword,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            suffixIcon: const Icon(Icons.visibility_off_outlined),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }
}
