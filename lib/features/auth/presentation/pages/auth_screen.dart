import 'package:animated_login/animated_login.dart';
import 'package:educayly_chat_app/core/show_message/show_failed_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/show_message/comming_soon_message.dart';
import '../../../../generated/assets.dart';
import '../../../../l10n/language.dart';
import '../../../../l10n/localization_provider.dart';
import '../../data/data_sources/remote/auth_data_source.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  AuthMode currentMode = AuthMode.login;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedLogin(
      onLogin: (data) async => null,
      onSignup: (data) async => null,
      onForgotPassword: _onForgotPassword,
      logo: Image.asset(Assets.imagesEducatlyLogo),
      signUpMode: SignUpModes.both,
      socialLogins: _socialLogins(context),
      loginDesktopTheme: _desktopTheme,
      loginMobileTheme: _mobileTheme,
      loginTexts: LoginTexts(
        signUpUseEmail: AppLocalizations.of(context)!.signUpUseEmail,
        signupEmailHint: AppLocalizations.of(context)!.signupEmailHint,
        signupPasswordHint: AppLocalizations.of(context)!.signupPasswordHint,
        signUpFormTitle: AppLocalizations.of(context)!.signUpFormTitle,
        confirmPasswordHint: AppLocalizations.of(context)!.confirmPasswordHint,
        nameHint: AppLocalizations.of(context)!.userName,
        login: AppLocalizations.of(context)!.login,
        signUp: AppLocalizations.of(context)!.signUp,
        welcome: AppLocalizations.of(context)!.welcome,
        welcomeDescription: AppLocalizations.of(context)!.welcomeDescription,
        welcomeBack: AppLocalizations.of(context)!.welcomeBack,
        loginEmailHint: AppLocalizations.of(context)!.loginEmailHint,
        loginFormTitle: AppLocalizations.of(context)!.loginFormTitle,
        loginPasswordHint: AppLocalizations.of(context)!.loginPasswordHint,
        loginUseEmail: AppLocalizations.of(context)!.loginUseEmail,
        welcomeBackDescription:
            AppLocalizations.of(context)!.welcomeBackDescription,
        notHaveAnAccount: AppLocalizations.of(context)!.notHaveAnAccount,
        forgotPassword: AppLocalizations.of(context)!.forgotPassword,
      ),
      emailValidator: ValidatorModel(
        validatorCallback: (email) => 'What an email! $email',
      ),
      changeLanguageCallback: (LanguageOption? newLanguage) {
        if (newLanguage != null) {
          ref.read(languageCodeProvider.notifier).changeLanguage(
              newLanguage: newLanguage.code == "ar"
                  ? Language.languageList()[1]
                  : Language.languageList()[0]);
        }
      },
      languageOptions: Language.languageList()
          .map((e) => LanguageOption(value: e.name, code: e.languageCode))
          .toList(),
      selectedLanguage: _getSelectedLanguage(ref),
      initialMode: currentMode,
      onAuthModeChange: _onAuthModeChange,
    );
  }

  LanguageOption _getSelectedLanguage(WidgetRef ref) {
    final currentLanguageCode = ref.watch(languageCodeProvider).languageCode;
    final selectedLanguage = Language.languageList()
        .firstWhere((lang) => lang.languageCode == currentLanguageCode);

    return LanguageOption(
        value: selectedLanguage.name, code: selectedLanguage.languageCode);
  }

  Future<String?> _onForgotPassword(String email) async {
    return null;
  }

  Future<void> _onAuthModeChange(AuthMode newMode) async {
    currentMode = newMode;
  }

  LoginViewTheme get _desktopTheme => _mobileTheme.copyWith(
        actionButtonStyle: const ButtonStyle(),
        dialogTheme: const AnimatedDialogTheme(
          languageDialogTheme: LanguageDialogTheme(
            optionMargin: EdgeInsets.symmetric(horizontal: 80),
          ),
        ),
        privacyPolicyLinkStyle: const TextStyle(
          decoration: TextDecoration.underline,
        ),
      );

  LoginViewTheme get _mobileTheme => LoginViewTheme(
        formWidthRatio: 60,
        actionButtonStyle: const ButtonStyle(),
        animatedComponentOrder: const <AnimatedComponent>[
          AnimatedComponent(
              component: LoginComponents.logo,
              animationType: AnimationType.right),
          AnimatedComponent(component: LoginComponents.title),
          AnimatedComponent(component: LoginComponents.description),
          AnimatedComponent(component: LoginComponents.formTitle),
          AnimatedComponent(component: LoginComponents.socialLogins),
          // AnimatedComponent(component: LoginComponents.useEmail),
          //  AnimatedComponent(component: LoginComponents.form),
          //  AnimatedComponent(component: LoginComponents.notHaveAnAccount),
          // AnimatedComponent(component: LoginComponents.forgotPassword),
          //AnimatedComponent(component: LoginComponents.policyCheckbox),
          // AnimatedComponent(component: LoginComponents.changeActionButton),
          //   AnimatedComponent(component: LoginComponents.actionButton),
        ],
        privacyPolicyLinkStyle: const TextStyle(
          decoration: TextDecoration.underline,
        ),
      );

  List<SocialLogin> _socialLogins(BuildContext context) => <SocialLogin>[
        SocialLogin(
          callback: () async =>
              _socialCallback(type: LoginType.google, context: context),
          iconPath: Assets.imagesGoogleLogo,
        ),
        SocialLogin(
          callback: () async =>
              _socialCallback(type: LoginType.linkedin, context: context),
          iconPath: Assets.imagesLinkedinLogo,
        ),
      ];

  Future<String?> _socialCallback(
      {required LoginType type, required BuildContext context}) async {
    // Simulate social login
    try {
      if (type == LoginType.google) {
      await  googleLogin(context: context);
      }
       else{
        showComingSoonMessage( context: context);
      }
    } catch (e) {
      showFailedMessage(message: e.toString(), context: context);
    }
    return null;
  }
}

enum LoginType { google, linkedin }
