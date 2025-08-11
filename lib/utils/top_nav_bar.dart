import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinklotus/model_module/auth_module/login_response.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';

class TopNavBarCommon extends StatefulWidget {
  final String name;
  final String level;
  final String? image;
  final Function callback;

  const TopNavBarCommon({
    super.key,
    required this.name,
    required this.level,
    this.image,
   required this.callback,
  });

  @override
  State<TopNavBarCommon> createState() => _TopNavBarCommonState();
}

class _TopNavBarCommonState extends State<TopNavBarCommon> {
  String? imageUrl;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    imageUrl = widget.image ?? ""; // fallback logic if needed
  }

  String? fallbackImage = LoginApiResponseModel().imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0xFF485966).withValues(alpha: 0.1),
            blurRadius: 28,
            offset: Offset(0.0, 8),
          ),
        ],
        color: Colors.white,
      ),
      height: 70,
      width: MediaQuery.sizeOf(context).width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(width: 16), // Some spacing
              GestureDetector(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: Image.asset(
                  "assets/Shape.png",
                  width: 20,
                  color: Colors.black,
                  filterQuality: FilterQuality.high,
                  height: 18,
                ),
              ),
              SizedBox(width: 16), // Some spacing
              Container(
                height: 45,
                width: 400,
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Color(0xFFF2F2F2), // Light grey fill
                  borderRadius: BorderRadius.circular(30), // Rounded edges
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: Color(0xFFD73B73),
                    ), // Pink search icon
                    SizedBox(width: 10),
                    Flexible(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16),
            ],
          ),

          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.name,
                    style: GoogleFonts.oxygen(color: Colors.black),
                  ),
                  Text(
                    widget.level,
                    style: GoogleFonts.oxygen(color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  print("imageclick------");
                  widget.callback.call();
                },
           
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child:
                      widget.image != null && widget.image!.isNotEmpty
                          ? CachedNetworkImage(
                            imageUrl: widget.image!,
                            placeholder:
                                (context, url) => CircularProgressIndicator(
                                  color: Colors.pinkAccent,
                                ),
                            errorWidget:
                                (context, url, error) =>
                                    widget.image != null &&
                                            widget.image!.isNotEmpty
                                        ? CachedNetworkImage(
                                          imageUrl: widget.image!,
                                          placeholder:
                                              (context, url) =>
                                                  CircularProgressIndicator(
                                                    color: Colors.pinkAccent,
                                                  ),
                                          errorWidget:
                                              (context, url, error) => Icon(
                                                Icons.person,
                                                color: Colors.black,
                                              ),
                                          fit: BoxFit.cover,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                        )
                                        : Icon(
                                          Icons.person,
                                          color: Colors.black,
                                        ),
                            fit: BoxFit.cover,
                            imageBuilder:
                                (context, imageProvider) => Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                          )
                          : widget.image != null && widget.image!.isNotEmpty
                          ? CachedNetworkImage(
                            imageUrl: widget.image!,
                            placeholder:
                                (context, url) => CircularProgressIndicator(
                                  color: Colors.pinkAccent,
                                ),
                            errorWidget:
                                (context, url, error) =>
                                    Icon(Icons.person, color: Colors.black),
                            fit: BoxFit.cover,
                            imageBuilder:
                                (context, imageProvider) => Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                          )
                          : Icon(Icons.person, color: Colors.black),
                ),
              ),

              SizedBox(width: 8),
              IconButton(
                icon: Icon(Icons.settings, color: Colors.grey),
                onPressed: () {
                  // Handle settings action
                },
              ),
              SizedBox(width: 8),
              Stack(
                children: [
                  IconButton(
                    icon: Icon(Icons.notifications, color: Colors.grey),
                    onPressed: () {
                      // Handle notifications
                    },
                  ),
                  Positioned(
                    right: 2,
                    top: 2,
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: BoxConstraints(minWidth: 12, minHeight: 12),
                      child: Text(
                        '9+',
                        style: GoogleFonts.oxygen(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 16),
            ],
          ),
        ],
      ),
    );
  }
}

