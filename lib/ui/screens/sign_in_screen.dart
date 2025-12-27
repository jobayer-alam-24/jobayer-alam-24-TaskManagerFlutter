
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart' show Get;
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:task_manager/ui/controllers/sign_in_controller.dart';
import 'package:task_manager/ui/screens/forgot_password_email_screen.dart';
import 'package:task_manager/ui/screens/main_bottom_nav_bar_screen.dart';
import 'package:task_manager/ui/screens/sign_up_screen.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/show_snackbar.dart';

import '../widgets/center_circular_progress_indicator.dart';
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  static const String name = '/SigninScreen';
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passworkdTEController = TextEditingController();
  final SignInController _signInController = Get.find<SignInController>();
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme
        .of(context)
        .textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ScreenBackground(
        child: SingleChildScrollView(
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
                GetBuilder<SignInController>(
                  builder:(signInController) {
                    return Visibility(
                      visible: !signInController.inProgress,
                      replacement: CenterCircularProgressIndicator(),
                      child: ElevatedButton(
                          onPressed: _onTapNextButton,
                          child: Icon(Icons.arrow_circle_right_outlined)
                      ),
                    );
                  },
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
    Get.toNamed(ForgotPasswordEmailScreen.name);
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
    final bool result = await _signInController.signIn(_emailTEController.text.trim(), _passworkdTEController.text);
    if(result)
      {
        Get.offAllNamed(MainBottomNavBarScreen.name, predicate: (_) => false);
      }
    else
      {
        ShowSnackBarMessege(context, "Something went wrong!", true);
      }
  }

  void _onTapSignUp() {
    Get.toNamed(SignUpScreen.name);
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passworkdTEController.dispose();
    super.dispose();
  }

}