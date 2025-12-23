import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/pin_verification_screen.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';

class ForgotPasswordEmailScreen extends StatefulWidget {
  const ForgotPasswordEmailScreen({super.key});

  @override
  State<ForgotPasswordEmailScreen> createState() => _ForgotPasswordEmailScreenState();
}

class _ForgotPasswordEmailScreenState extends State<ForgotPasswordEmailScreen> {
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
                Text("Your Email Address", style: textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w500
                ),),
                const SizedBox(height: 8,),
                Text("A 6 digits verification otp will be sent to your email address", style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey
                ),),
                const SizedBox(height: 24,),
                _buildSignUpForm(),
                const SizedBox(height: 24,),
                ElevatedButton(
                    onPressed: _onTapNextButton,
                    child: Icon(Icons.arrow_circle_right_outlined)
                ),
                const SizedBox(height: 48,),
                _haveAccountSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildSignUpForm() {
    return Column(
      children: [
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              hint: Text("Email", style: const TextStyle(
                  fontWeight: FontWeight.w500
              ))
          ),
        ),
        const SizedBox(height: 8,),
      ],
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
    Navigator.push(context, MaterialPageRoute(builder: (context) => const PinVerificationScreen()));
  }
}