import 'package:auth_repository/auth_repository.dart';
import 'package:coaching/admin_panel/admin_login/models/admin_loing_validators.dart';
import 'package:coaching/authentication/login/view/login_page.dart';
import 'package:coaching/authentication/register/cubit/register_cubit.dart';
import 'package:coaching/l10n/l10n.dart';
import 'package:coaching/welcome/view/welcome_page.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  static const name = 'RegisterPage';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(
        firestoreRepository: context.read<FirestoreRepository>(),
        authRepository: context.read<AuthRepository>(),
      ),
      child: const RegisterView(),
    );
  }
}

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is! RegisterSuccess) return;
          return GoRouter.of(context).goNamed(
            WelcomePage.name,
            extra: state.userDataModel,
          );
        },
        builder: (context, state) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                width: 300,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiary,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                              onPressed: context.pop,
                              icon: Icon(
                                Icons.close,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          context.l10n.register,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: context.l10n.email,
                            border: const OutlineInputBorder(),
                          ),
                          controller: _emailController,
                          validator: (value) =>
                              AdminLoginValidators.validateEmail(
                            value,
                            context.l10n,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: context.l10n.password,
                            border: const OutlineInputBorder(),
                          ),
                          controller: _passwordController,
                          obscureText: true,
                          validator: (value) =>
                              AdminLoginValidators.validatePassword(
                            value,
                            context.l10n,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: context.l10n.confirmPassword,
                            border: const OutlineInputBorder(),
                          ),
                          controller: _confirmPasswordController,
                          obscureText: true,
                          validator: (value) =>
                              AdminLoginValidators.validatePassword(
                            value,
                            context.l10n,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Visibility(
                          visible: state is RegisterFailure,
                          child: Text(
                            state is RegisterFailure
                                ? state.getMessage(context.l10n)
                                : '',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            if (!formKey.currentState!.validate()) return;
                            context
                                .read<RegisterCubit>()
                                .registerWithEmailAndPassword(
                                  _emailController.text,
                                  _passwordController.text,
                                  _confirmPasswordController.text,
                                );
                          },
                          child: SizedBox(
                            height: 40,
                            width: 90,
                            child: Center(
                              child: state is RegisterLoading
                                  ? const SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  : Text(context.l10n.register),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: () {
                            context.pop();
                            showDialog<void>(
                              context: context,
                              builder: (context) => const LoginPage(),
                            );
                          },
                          child: Text(
                            context.l10n.login,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
