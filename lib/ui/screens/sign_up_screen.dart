import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
import 'package:task_manager/ui/widgets/center_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/show_snackbar.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileNoTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  bool _inProgress = false;
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme
        .of(context)
        .textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: ScreenBackground(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 82,),
                Text("Join With Us", style: textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w500
                ),),
                const SizedBox(height: 24,),
                _buildSignUpForm(),
                const SizedBox(height: 24,),
                Visibility(
                  visible: !_inProgress,
                  replacement: CenterCircularProgressIndicator(),
                  child: ElevatedButton(
                      onPressed: _onTapNextButton,
                      child: Icon(Icons.arrow_circle_right_outlined)
                  ),
                ),
                const SizedBox(height: 24,),
                _haveAccountSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildSignUpForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _emailTEController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                hint: Text("Email", style: const TextStyle(
                    fontWeight: FontWeight.w500
                ))
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
                hint: Text("First name", style: const TextStyle(
                    fontWeight: FontWeight.w500
                ))
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
                hint: Text("Last name", style: const TextStyle(
                    fontWeight: FontWeight.w500
                ))
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
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
                hint: Text("Mobile", style: const TextStyle(
                    fontWeight: FontWeight.w500
                ))
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
                hint: Text("Password", style: const TextStyle(
                    fontWeight: FontWeight.w500
                ),)
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
        ],
      ),
    );
  }

  Widget _haveAccountSection() {
    return Center(
      child: Column(
        children: [
          RichText(text: TextSpan(
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.5
              ),
              text: "Have account?",
              children: [
                TextSpan(text: " Sign In", style: const TextStyle(
                  color: AppColors.themeColor,
                ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = _onTapSignIn,
                ),
              ]
          ))
        ],
      ),
    );
  }
  void _onTapSignIn() {
    Navigator.pop(context);
  }
  void _onTapNextButton() {
    if(!_formKey.currentState!.validate())
      {
        return;
      }
    _singUp();
  }
  Future<void> _singUp() async {
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
        url: Urls.registration,
        body: reqBody,
      );

      if (response.isSuccess) {
        _formKey.currentState!.reset();
        _clearTextFields();
        ShowSnackBarMessege(context, "New User Created Successfully!");
      } else {
        ShowSnackBarMessege(context, response.errorMessege, true);
      }
    } catch (e) {
      ShowSnackBarMessege(context, "Something went wrong!", true);
      debugPrint("SIGN UP ERROR: $e");
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