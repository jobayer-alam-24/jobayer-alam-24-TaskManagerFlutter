import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
                ElevatedButton(
                    onPressed: _onTapNextButton,
                    child: Icon(Icons.arrow_circle_right_outlined)
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
        TextFormField(
          decoration: InputDecoration(
              hint: Text("First name", style: const TextStyle(
                  fontWeight: FontWeight.w500
              ))
          ),
        ),
        const SizedBox(height: 8,),
        TextFormField(
          decoration: InputDecoration(
              hint: Text("Last name", style: const TextStyle(
                  fontWeight: FontWeight.w500
              ))
          ),
        ),
        const SizedBox(height: 8,),
        TextFormField(
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
              hint: Text("Mobile", style: const TextStyle(
                  fontWeight: FontWeight.w500
              ))
          ),
        ),
        const SizedBox(height: 8,),
        TextFormField(
          obscureText: true,
          decoration: InputDecoration(
              hint: Text("Password", style: const TextStyle(
                  fontWeight: FontWeight.w500
              ),)
          ),
        ),
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
    // TODO: ON TAP NEXT BUTTON IMPLEMENT
  }
}