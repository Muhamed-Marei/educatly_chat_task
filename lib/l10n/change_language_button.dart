import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'localization_provider.dart';
import 'language.dart';

class ChangeLanguageButton extends StatelessWidget {
  const ChangeLanguageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: DropdownButton<Language>(borderRadius: BorderRadius.circular(20),
            isExpanded: true,
            underline: const SizedBox(),
            hint: Text(
              AppLocalizations.of(context)!.login,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            onChanged: (Language? language) async {
              if (language != null) {
ref.watch(languageCodeProvider.notifier).changeLanguage(newLanguage: language);
              }
            },
            items: Language.languageList()
                .map<DropdownMenuItem<Language>>(
                  (e) => DropdownMenuItem<Language>(
                    value: e,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          e.flag,
                          style: const TextStyle(fontSize: 30),
                        ),
                        Text(e.name)
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}
