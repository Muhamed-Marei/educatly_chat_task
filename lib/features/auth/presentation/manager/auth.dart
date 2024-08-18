//
//
//
// import 'package:animated_login/animated_login.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
//
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:animated_login/animated_login.dart';
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({Key? key}) : super(key: key);
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   LanguageOption _selectedLanguage = _languageOptions[1];
//   AuthMode _currentAuthMode = AuthMode.login;
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedLogin(
//       onLogin: _handleOnLogin,
//       onSignup: _handleOnSignup,
//       logo: Image.asset('assets/images/logo.gif'),
//       signUpMode: SignUpModes.both,
//       socialLogins: _buildSocialLogins(context),
//       loginDesktopTheme: _desktopTheme,
//       loginMobileTheme: _mobileTheme,
//       loginTexts: _buildLoginTexts(),
//       emailValidator: ValidatorModel(
//         validatorCallback: (String? email) => 'What an email! $email',
//       ),
//       changeLanguageCallback: _changeLanguage,
//       changeLangDefaultOnPressed: () {},
//       languageOptions: _languageOptions,
//       selectedLanguage: _selectedLanguage,
//       initialMode: _currentAuthMode,
//       onAuthModeChange: _changeAuthMode,
//     );
//   }
//
//   Future<String?> _handleOnLogin(LoginData data) async {
//     // Implement your login logic here
//     return null;
//   }
//
//   Future<String?> _handleOnSignup(SignUpData data) async {
//     // Implement your signup logic here
//     return null;
//   }
//
//   void _handleOnForgotPassword(BuildContext context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
//     );
//   }
//
//   void _changeLanguage(LanguageOption? selectedLanguage) {
//     if (selectedLanguage != null) {
//
//       setState(() => _selectedLanguage = selectedLanguage);
//     }
//   }
//
//   Future<void> _changeAuthMode(AuthMode newMode) async {
//     _currentAuthMode = newMode;
//     await _cancelableOperation?.cancel();
//   }
//
//   List<SocialLogin> _buildSocialLogins(BuildContext context) => [
//     SocialLogin(
//       callback: () => _handleSocialLogin(context, 'Google'),
//       iconPath: 'assets/images/google.png',
//     ),
//     SocialLogin(
//       callback: () => _handleSocialLogin(context, 'Facebook'),
//       iconPath: 'assets/images/facebook.png',
//     ),
//     SocialLogin(
//       callback: () => _handleSocialLogin(context, 'LinkedIn'),
//       iconPath: 'assets/images/linkedin.png',
//     ),
//   ];
//
//   Future<String?> _handleSocialLogin(BuildContext context, String type) async {
//     await _cancelableOperation?.cancel();
//     _cancelableOperation = CancelableOperation.fromFuture(
//       LoginFunctions(context).socialLogin(type),
//     );
//     final String? result = await _cancelableOperation?.valueOrCancellation();
//     if (_cancelableOperation?.isCompleted == true && result == null) {
//       DialogBuilder(context).showResultDialog('Successfully logged in with $type.');
//     }
//     return result;
//   }
//
//   LoginViewTheme get _desktopTheme => _mobileTheme.copyWith(
//     actionButtonStyle: ButtonStyle(
//       foregroundColor: MaterialStateProperty.all(Colors.white),
//     ),
//     dialogTheme: const AnimatedDialogTheme(
//       languageDialogTheme: LanguageDialogTheme(
//         optionMargin: EdgeInsets.symmetric(horizontal: 80),
//       ),
//     ),
//     loadingSocialButtonColor: Colors.blue,
//     loadingButtonColor: Colors.white,
//     privacyPolicyStyle: const TextStyle(color: Colors.black87),
//     privacyPolicyLinkStyle: const TextStyle(
//       color: Colors.blue,
//       decoration: TextDecoration.underline,
//     ),
//   );
//
//   LoginViewTheme get _mobileTheme => LoginViewTheme(
//     backgroundColor: Colors.blue,
//     formFieldBackgroundColor: Colors.white,
//     formWidthRatio: 60,
//     actionButtonStyle: ButtonStyle(
//       foregroundColor: MaterialStateProperty.all(Colors.blue),
//     ),
//     animatedComponentOrder: const <AnimatedComponent>[
//       AnimatedComponent(component: LoginComponents.logo, animationType: AnimationType.right),
//       AnimatedComponent(component: LoginComponents.title),
//       AnimatedComponent(component: LoginComponents.description),
//       AnimatedComponent(component: LoginComponents.formTitle),
//       AnimatedComponent(component: LoginComponents.socialLogins),
//       AnimatedComponent(component: LoginComponents.useEmail),
//       AnimatedComponent(component: LoginComponents.form),
//       AnimatedComponent(component: LoginComponents.notHaveAnAccount),
//       AnimatedComponent(component: LoginComponents.forgotPassword),
//       AnimatedComponent(component: LoginComponents.policyCheckbox),
//       AnimatedComponent(component: LoginComponents.changeActionButton),
//       AnimatedComponent(component: LoginComponents.actionButton),
//     ],
//     privacyPolicyStyle: const TextStyle(color: Colors.white70),
//     privacyPolicyLinkStyle: const TextStyle(
//       color: Colors.white,
//       decoration: TextDecoration.underline,
//     ),
//   );
//
//   LoginTexts _buildLoginTexts() {
//     return LoginTexts(
//       nameHint: _username,
//       login: _loginText,
//       signUp: _signUpText,
//     );
//   }
//
//   String get _username => _selectedLanguage.code == 'TR' ? 'Kullanıcı Adı' : 'Username';
//
//   String get _loginText => _selectedLanguage.code == 'TR' ? 'Giriş Yap' : 'Login';
//
//   String get _signUpText => _selectedLanguage.code == 'TR' ? 'Kayıt Ol' : 'Sign Up';
//
//   static List<LanguageOption> get _languageOptions => const [
//     LanguageOption(value: 'Turkish', code: 'TR', iconPath: 'assets/images/tr.png'),
//     LanguageOption(value: 'English', code: 'EN', iconPath: 'assets/images/en.png'),
//   ];
// }
//
// class ForgotPasswordScreen extends StatelessWidget {
//   const ForgotPasswordScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: Text('FORGOT PASSWORD'),
//       ),
//     );
//   }
// }
