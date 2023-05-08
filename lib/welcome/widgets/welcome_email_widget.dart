import 'package:coaching/l10n/l10n.dart';
import 'package:flutter/material.dart';

class WelcomeEmailWidget extends StatelessWidget {
  const WelcomeEmailWidget({
    super.key,
    required this.onSubmit,
    required this.textEditingController,
    required this.isError,
    required this.width,
  });

  final void Function(BuildContext context) onSubmit;
  final TextEditingController textEditingController;
  final bool isError;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: width,
          child: TextField(
            controller: textEditingController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(36),
                borderSide: BorderSide.none,
              ),
              filled: true,
              hintStyle: TextStyle(color: Colors.grey[600]),
              hintText: 'example@email.com',
              fillColor: Colors.blueGrey.shade100,
              contentPadding: const EdgeInsets.symmetric(horizontal: 24),
            ),
            onSubmitted: (_) => onSubmit(context),
          ),
        ),
        Visibility(
          visible: isError,
          child: Text(
            context.l10n.emailError,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
