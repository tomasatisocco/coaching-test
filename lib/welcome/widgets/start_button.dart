import 'package:coaching/l10n/l10n.dart';
import 'package:coaching/welcome/cubit/welcome_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartButton extends StatelessWidget {
  const StartButton({
    super.key,
    required this.onSubmit,
    required this.fontSize,
  });

  final void Function(BuildContext context) onSubmit;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WelcomeCubit, WelcomeState>(
      listenWhen: (previous, current) => current is WelcomeError,
      listener: (context, state) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(
                  Icons.error_outline_rounded,
                  color: Colors.white,
                ),
                const SizedBox(width: 4),
                Text(context.l10n.welcomeError),
              ],
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () => onSubmit(context),
            child: SizedBox(
              height: 64,
              width: 150,
              child: Center(
                child: state is WelcomeLoading
                    ? CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.onPrimary,
                      )
                    : Text(
                        context.l10n.getStarted,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: fontSize,
                        ),
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}
