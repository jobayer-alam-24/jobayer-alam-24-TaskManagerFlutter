import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';
import 'package:task_manager/ui/screens/profile_screen.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'dart:convert';
import 'dart:typed_data';
import '../utils/app_colors.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TMAppBar({
    super.key, this.IsProfileScreenOpen = false, this.userName, this.userEmail
  });
  final String? userName;
  final String? userEmail;
  final bool IsProfileScreenOpen;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(IsProfileScreenOpen)
          {
            return;
          }
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
      },
      child: AppBar(
        backgroundColor: AppColors.themeColor,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 16,
              backgroundImage: AssetImage('assets/images/default_avatar.png') as ImageProvider,
              // backgroundImage: MemoryImage(AuthController.bytes),
            ),
            const SizedBox(width: 16,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(userName ?? 'Username', style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),),
                  Text(userEmail ?? "E-mail", style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),),
                ],
              ),
            ),
            IconButton(onPressed: () async {
              await AuthController.ClearUserData();
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context) => const SignInScreen())
                  , (_) => false);
            }, icon: Icon(Icons.logout, color: Colors.white,))
          ],
        ),
      ),
    );
  }


  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  }



