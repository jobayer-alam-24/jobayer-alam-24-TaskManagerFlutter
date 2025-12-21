import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/profile_screen.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';

import '../utils/app_colors.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TMAppBar({
    super.key, this.IsProfileScreenOpen = false,
  });
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
            ),
            const SizedBox(width: 16,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Jobayer Alam", style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),),
                  Text("jobayer123@gmail.com", style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),),
                ],
              ),
            ),
            IconButton(onPressed: (){
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
