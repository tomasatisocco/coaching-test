import 'package:coaching/app/cubit/localizations_cubit.dart';
import 'package:coaching/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageSwitch extends StatelessWidget {
  const LanguageSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(context.l10n.language),
      leading: const Icon(Icons.flag_circle_rounded),
      onTap: () async {
        await showDialog<void>(
          context: context,
          builder: (context) => Dialog(
            child: SizedBox(
              height: 100,
              width: 200,
              child: Column(
                children: [
                  RadioListTile(
                    title: const Text('English'),
                    value: 'en',
                    activeColor: Theme.of(context).colorScheme.primary,
                    groupValue: context
                        .read<LocalizationsCubit>()
                        .state
                        .locale
                        .languageCode,
                    onChanged: (value) {
                      context.read<LocalizationsCubit>().switchLanguage();
                      Navigator.of(context).pop();
                    },
                  ),
                  RadioListTile(
                    title: const Text('Español'),
                    value: 'es',
                    activeColor: Theme.of(context).colorScheme.primary,
                    groupValue: context
                        .read<LocalizationsCubit>()
                        .state
                        .locale
                        .languageCode,
                    onChanged: (value) {
                      context.read<LocalizationsCubit>().switchLanguage();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
