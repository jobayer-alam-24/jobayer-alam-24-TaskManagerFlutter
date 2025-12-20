import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/ui/screens/reset_password_screen.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key});

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
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
                Text("PIN Verification", style: textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w500
                ),),
                const SizedBox(height: 8,),
                Text("A 6 digits verification otp will be sent to your email address", style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey
                ),),
                const SizedBox(height: 24,),
                _pinVerification(),
                const SizedBox(height: 24,),
                ElevatedButton(
                    onPressed: _onTapNextButton,
                    child: Text("Verify")
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


  Widget _pinVerification() {
    return Column(
      children: [
        PinCodeTextField(
          appContext: context,
          pastedTextStyle: TextStyle(
            color: Colors.green.shade600,
            fontWeight: FontWeight.bold,
          ),
          length: 6,
          obscureText: false,
          obscuringCharacter: '*',
          backgroundColor: Colors.transparent,
          blinkWhenObscuring: true,
          animationType: AnimationType.fade,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(5),
            fieldHeight: 50,
            fieldWidth: 40,
            inactiveFillColor: Colors.white,
            activeFillColor: Colors.white,
            selectedFillColor: Colors.white
          ),
          cursorColor: Colors.black,
          animationDuration: const Duration(milliseconds: 300),
          enableActiveFill: true,
          keyboardType: TextInputType.number,
          boxShadows: const [
            BoxShadow(
              offset: Offset(0, 1),
              color: Colors.black12,
              blurRadius: 10,
            )
          ],
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
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => const SignInScreen()), (_) => false);
  }
  void _onTapNextButton() {
    Navigator.push(context,
      MaterialPageRoute(builder: (context) => const ResetPasswordScreen())
    );
  }
}