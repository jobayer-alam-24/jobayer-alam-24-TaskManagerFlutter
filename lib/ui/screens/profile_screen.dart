import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/build_photo_picker.dart';
import 'package:task_manager/ui/widgets/tm_app_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(
        IsProfileScreenOpen: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 48,),
              Text(
                "Update Profile", style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w500
              ),),
              const SizedBox(height: 32,),
              BuildPhotoPicker(),
              const SizedBox(height: 16,),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Email"
                ),
              ),
              const SizedBox(height: 8,),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "First name"
                ),
              ),
              const SizedBox(height: 8,),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "Last name"
                ),
              ),
              const SizedBox(height: 8,),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "Phone"
                ),
              ),
              const SizedBox(height: 8,),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "Password"
                ),
              ),
              const SizedBox(height: 16,),
              ElevatedButton(onPressed: (){}, child: Icon(Icons.arrow_circle_right_outlined)),
              const SizedBox(height: 16,),
            ],
          ),
        ),
      ),
    );
  }
}

