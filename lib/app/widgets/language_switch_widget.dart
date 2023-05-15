import 'package:coaching/app/cubit/localizations_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageSwitch extends StatelessWidget {
  const LanguageSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationsCubit, LocalizationsState>(
      builder: (context, state) {
        return TextButton(
          child: Text(
            state.locale.languageCode,
            style: const TextStyle(fontSize: 16),
          ),
          onPressed: () {
            context.read<LocalizationsCubit>().switchLanguage();
          },
        );
      },
    );
  }
}
