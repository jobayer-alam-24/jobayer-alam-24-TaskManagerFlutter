import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/widgets/build_photo_picker.dart';
import 'package:task_manager/ui/widgets/center_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/tm_app_bar.dart';

import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import '../controllers/auth_controller.dart';
import '../widgets/show_snackbar.dart';
import 'no_internet_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileNoTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  bool _inProgress = false;
  String? userName;
  String? userEmail, userPhone;
  @override
  void initState() {
    loadUserInfo();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(
        userName: userName, userEmail: userEmail,
        IsProfileScreenOpen: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _emailTEController,
                  decoration: InputDecoration(
                    hintText: "Email"
                  ),
                  validator: (String? value){
                    if(value?.isEmpty ?? true)
                    {
                      return "Enter valid email.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8,),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _firstNameTEController,
                  decoration: InputDecoration(
                      hintText: "First name"
                  ),
                  validator: (String? value){
                    if(value?.isEmpty ?? true)
                    {
                      return "Enter First name.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8,),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _lastNameTEController,
                  decoration: InputDecoration(
                      hintText: "Last name"
                  ),
                  validator: (String? value){
                    if(value?.isEmpty ?? true)
                    {
                      return "Enter last name.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8,),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _mobileNoTEController,
                  decoration: InputDecoration(
                      hintText: "Phone"
                  ),
                  validator: (String? value){
                    if(value?.isEmpty ?? true)
                    {
                      return "Enter valid phone number.";
                    }
                    else if(value?.length != 11)
                    {
                      return "Phone number will be 11 characters";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8,),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _passwordTEController,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "Password"
                  ),
                  validator: (String? value){
                    if(value?.isEmpty ?? true)
                    {
                      return "Enter your password.";
                    }
                    else if(value!.length < 6)
                    {
                      return "Password will be at least 6 characters.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16,),
                Visibility(
                  visible: !_inProgress,
                    replacement: CenterCircularProgressIndicator(),
                    child: ElevatedButton(onPressed: _onTapNextButton, child: Icon(Icons.arrow_circle_right_outlined))),
                const SizedBox(height: 16,),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> loadUserInfo() async {
    userName = await AuthController.getFullName();
    userEmail = await AuthController.getEmail();
    userPhone = await AuthController.getPhoneNo();
    _emailTEController.text = userEmail ?? "";
    _mobileNoTEController.text = userPhone ?? "";
    _firstNameTEController.text = userName?.split(' ').first ?? "";
    _lastNameTEController.text = userName?.split(' ').last ?? "";
    setState(() {});
  }
  void _onTapNextButton() {
    if(!_formKey.currentState!.validate())
    {
      return;
    }
    _checkConnectivityAndGoNoInternet();
    _updateProfile();
  }
  Future<void> _checkConnectivityAndGoNoInternet() async
  {
    bool isConnected = await InternetConnection().hasInternetAccess;

    if (!isConnected) {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const NoInternetScreen()),
      );
      return;
    }
  }
  Future<void> _updateProfile() async {
    setState(() => _inProgress = true);

    try {
      Map<String, dynamic> reqBody = {
        "email": _emailTEController.text.trim(),
        "firstName": _firstNameTEController.text.trim(),
        "lastName": _lastNameTEController.text.trim(),
        "mobile": _mobileNoTEController.text.trim(),
        "password": _passwordTEController.text.trim(),
        "photo": ""
      };

      NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.updateProfile,
        body: reqBody,
      );

      if (response.isSuccess) {
        _formKey.currentState!.reset();
        _clearTextFields();
        await AuthController.ClearUserData();
        ShowSnackBarMessege(context, "Profile Updated Successfully!");
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const SignInScreen()), (_) => false);
      } else {
        ShowSnackBarMessege(context, "Something went wrong!", true);
      }
    } catch (e) {
      ShowSnackBarMessege(context, "Something went wrong!", true);
      debugPrint("UPDATE PROFILE ERROR: $e");
    } finally {
      setState(() => _inProgress = false);
    }
  }
  void _clearTextFields()
  {
    _emailTEController.clear();
    _firstNameTEController.clear();
    _lastNameTEController.clear();
    _mobileNoTEController.clear();
    _passwordTEController.clear();
  }
  @override
  void dispose() {
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileNoTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}

