import 'package:coaching/l10n/l10n.dart';
import 'package:coaching/welcome/cubit/welcome_cubit.dart';
import 'package:coaching/welcome/models/welcome_page_validators.dart';
import 'package:coaching/welcome/widgets/start_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class WelcomeFormWidget extends StatefulWidget {
  const WelcomeFormWidget({
    super.key,
    required this.width,
  });

  final double width;

  @override
  State<WelcomeFormWidget> createState() => _WelcomeFormWidgetState();
}

class _WelcomeFormWidgetState extends State<WelcomeFormWidget> {
  late GlobalKey<FormState> formKey;
  late TextEditingController nameController;
  late TextEditingController birthDateController;
  late TextEditingController nationalityController;
  late TextEditingController residenceController;
  late TextEditingController certificateDateController;
  late DateTime initialDate;

  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    nameController = TextEditingController();
    birthDateController = TextEditingController();
    nationalityController = TextEditingController();
    residenceController = TextEditingController();
    certificateDateController = TextEditingController();
    initialDate = DateTime.now();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    birthDateController.dispose();
    nationalityController.dispose();
    residenceController.dispose();
    certificateDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              validator: (value) => WelcomePageValidators.validateName(
                value,
                context.l10n,
              ),
              decoration: InputDecoration(
                labelText: context.l10n.name,
              ),
            ),
            TextFormField(
              controller: birthDateController,
              decoration: InputDecoration(
                labelText: context.l10n.birthDate,
              ),
              readOnly: true,
              validator: (value) => WelcomePageValidators.validateBirthDate(
                value,
                context.l10n,
              ),
              onTap: () async {
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1950),
                  lastDate: DateTime.now(),
                );
                if (pickedDate == null) return;
                final formattedDate =
                    DateFormat('yyyy-MM-dd').format(pickedDate);

                setState(() {
                  birthDateController.text = formattedDate;
                });
              },
            ),
            TextFormField(
              controller: nationalityController,
              validator: (value) => WelcomePageValidators.validateNational(
                value,
                context.l10n,
              ),
              decoration: InputDecoration(
                labelText: context.l10n.nationality,
              ),
            ),
            TextFormField(
              controller: residenceController,
              validator: (value) => WelcomePageValidators.validateResidence(
                value,
                context.l10n,
              ),
              decoration: InputDecoration(
                labelText: context.l10n.residenceCountry,
              ),
            ),
            TextFormField(
              controller: certificateDateController,
              decoration: InputDecoration(
                labelText: context.l10n.yearOfCertification,
              ),
              validator: (value) => WelcomePageValidators.validateCertificate(
                value,
                context.l10n,
              ),
              readOnly: true,
              onTap: () async {
                await showDialog<void>(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        context.l10n.yearOfCertification,
                        textAlign: TextAlign.center,
                      ),
                      content: SizedBox(
                        height: 300,
                        width: 300,
                        child: YearPicker(
                          firstDate: DateTime(1950),
                          lastDate: DateTime.now(),
                          selectedDate: initialDate,
                          onChanged: (pickedDate) {
                            final formattedDate =
                                DateFormat('yyyy').format(pickedDate);

                            setState(() {
                              certificateDateController.text = formattedDate;
                              initialDate = pickedDate;
                            });
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            const SizedBox(
              height: 16,
            ),
            StartButton(
              onSubmit: (_) async {
                final welcomeCubit = context.read<WelcomeCubit>();
                final isFormValid = formKey.currentState!.validate();
                if (!isFormValid) return;
                await welcomeCubit.submitUser(
                  name: nameController.text,
                  birthDate: birthDateController.text,
                  nationality: birthDateController.text,
                  residence: residenceController.text,
                  certificateDate: certificateDateController.text,
                );
              },
              fontSize: 24,
            ),
          ],
        ),
      ),
    );
  }
}
