import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/pin_verification_screen.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
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
                Text("Set Password", style: textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w500
                ),),
                const SizedBox(height: 8,),
                Text("Minimum number of passwords should be 8 letters", style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey
                ),),
                const SizedBox(height: 24,),
                _buildResetPasswordForm(),
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


  Widget _buildResetPasswordForm() {
    return Column(
      children: [
        TextFormField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              hint: Text("Password", style: const TextStyle(
                  fontWeight: FontWeight.w500
              ))
          ),
        ),
        const SizedBox(height: 8,),
        TextFormField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              hint: Text("Confirm Password", style: const TextStyle(
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
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => const SignInScreen()), (_) => false);
  }
}