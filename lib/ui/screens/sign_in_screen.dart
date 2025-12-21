
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';
import 'package:task_manager/ui/screens/forgot_password_email_screen.dart';
import 'package:task_manager/ui/screens/main_bottom_nav_bar_screen.dart';
import 'package:task_manager/ui/screens/sign_up_screen.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/show_snackbar.dart';

import '../widgets/center_circular_progress_indicator.dart';
import '../widgets/show_snackbar.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passworkdTEController = TextEditingController();
  bool _inProgess = false;
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
                Text(
                  "Get Started With", style: textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w500
                ),),
                const SizedBox(height: 24,),
                _buildSignInForm(),
                const SizedBox(height: 24,),
                Visibility(
                  visible: !_inProgess,
                  replacement: CenterCircularProgressIndicator(),
                  child: ElevatedButton(
                      onPressed: _onTapNextButton,
                      child: Icon(Icons.arrow_circle_right_outlined)
                  ),
                ),
                const SizedBox(height: 24,),
                _buildSignUpSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInForm() {
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
            validator: (String? value)
            {
              if(value?.isEmpty ?? true)
                {
                  return "Enter a valid email.";
                }
              return null;
            },
          ),
          const SizedBox(height: 8,),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _passworkdTEController,
            obscureText: true,
            decoration: InputDecoration(
                hint: Text("Password", style: const TextStyle(
                    fontWeight: FontWeight.w500
                ),)
            ),
            validator: (String? value)
            {
              if(value?.isEmpty ?? true)
                {
                  return "Enter your password.";
                }
              if(value!.length <= 6)
                {
                  return "Enter a password more than 6 letters.";
                }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpSection() {
    return Center(
      child: Column(
        children: [
          TextButton(
              onPressed: _onTapForgotPasswordButton,
              child: Text("Forgot Password?", style: const TextStyle(
                  color: Colors.grey
              ),)
          ),
          RichText(text: TextSpan(
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.5
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = _onTapSignUp,
              text: "Don't have an account?",
              children: [
                TextSpan(text: " Sign Up", style: const TextStyle(
                  color: AppColors.themeColor,
                )),
              ]
          ))
        ],
      ),
    );
  }

  void _onTapForgotPasswordButton() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPasswordEmailScreen()));
  }

  void _onTapNextButton() {
    if(!_formKey.currentState!.validate())
      {
        return;
      }
    _signIn();

  }

  Future<void> _signIn() async
  {
    _inProgess = true;
    setState(() {

    });
    Map<String, dynamic> reqBody =
        {
          "email" : _emailTEController.text.trim(),
          "password" : _passworkdTEController.text
        };
    final NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.login,
      body: reqBody
    );
    _inProgess = false;
    setState(() {

    });
    if(response.isSuccess)
      {
        await AuthController.SaveAccessToken(response.responseData['token']);

        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => const MainBottomNavBarScreen())
            , (_) => false);
      }
    else
      {
        ShowSnackBarMessege(context, response.errorMessege, true);
      }
  }

  void _onTapSignUp() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passworkdTEController.dispose();
    super.dispose();
  }

}