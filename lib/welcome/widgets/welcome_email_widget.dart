import 'package:coaching/coaching_test/view/coaching_test_page.dart';
import 'package:coaching/l10n/l10n.dart';
import 'package:coaching/welcome/models/user_date_model.dart';
import 'package:coaching/welcome/models/welcome_page_validators.dart';
import 'package:coaching/welcome/widgets/start_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class WelcomeEmailWidget extends StatefulWidget {
  const WelcomeEmailWidget({
    super.key,
    required this.width,
  });

  final double width;

  @override
  State<WelcomeEmailWidget> createState() => _WelcomeEmailWidgetState();
}

class _WelcomeEmailWidgetState extends State<WelcomeEmailWidget> {
  late GlobalKey<FormState> formKey;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController birthDateController;
  late TextEditingController nationalityController;
  late TextEditingController residenceController;
  late TextEditingController certificateDateController;

  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    nameController = TextEditingController();
    emailController = TextEditingController();
    birthDateController = TextEditingController();
    nationalityController = TextEditingController();
    residenceController = TextEditingController();
    certificateDateController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
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
        autovalidateMode: AutovalidateMode.onUserInteraction,
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
              controller: emailController,
              validator: (value) => WelcomePageValidators.validateEmail(
                value,
                context.l10n,
              ),
              decoration: InputDecoration(
                labelText: context.l10n.email,
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
                  certificateDateController.text = formattedDate;
                });
              },
            ),
            const SizedBox(
              height: 16,
            ),
            StartButton(
              onSubmit: (context) {
                final isFormValid = formKey.currentState!.validate();
                if (!isFormValid) return;
                final userInfoModel = UserDataModel(
                  name: nameController.text,
                  email: emailController.text,
                  birthDate: birthDateController.text,
                  nationality: nationalityController.text,
                  residence: residenceController.text,
                  certificateDate: certificateDateController.text,
                );
                context.pushNamed(
                  CoachingTestPage.name,
                  extra: userInfoModel,
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
