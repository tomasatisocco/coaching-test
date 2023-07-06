import 'package:auth_repository/auth_repository.dart';
import 'package:coaching/admin_panel/admin_login/cubit/admin_login_cubit.dart';
import 'package:coaching/admin_panel/admin_login/models/admin_loing_validators.dart';
import 'package:coaching/admin_panel/admin_page/view/admin_page.dart';
import 'package:coaching/app/widgets/coaching_app_bar.dart';
import 'package:coaching/l10n/l10n.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminLoginPage extends StatelessWidget {
  const AdminLoginPage({super.key});

  static const name = 'Admin Login Page';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminLoginCubit(
        firestoreRepository: context.read<FirestoreRepository>(),
        authRepository: context.read<AuthRepository>(),
      )..init(),
      child: const AdminLoginView(),
    );
  }
}

class AdminLoginView extends StatelessWidget {
  const AdminLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminLoginCubit, AdminLoginState>(
      builder: (context, state) {
        if (state is AdminLoginSuccess) return const AdminPage();
        return LoginFormWidget(state: state);
      },
    );
  }
}

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key, required this.state});

  final AdminLoginState state;

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CoachingAppBar(),
      endDrawer: Drawer(
        child: Column(
          children: [
            const Spacer(),
            ListTile(
              title: Text(context.l10n.logout),
              leading: const Icon(Icons.logout),
              onTap: () async {},
            ),
          ],
        ),
      ),
      body: Center(
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
                    Text(
                      'Admin Login',
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
                      validator: (value) => AdminLoginValidators.validateEmail(
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
                    Visibility(
                      visible: widget.state is AdminNotAuthorized,
                      child: Text(
                        context.l10n.userNotAuthorized,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: widget.state is AdminLoginFailure,
                      child: Text(
                        context.l10n.loginError,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        if (!formKey.currentState!.validate()) return;
                        context.read<AdminLoginCubit>().login(
                              _emailController.text,
                              _passwordController.text,
                            );
                      },
                      child: SizedBox(
                        height: 40,
                        width: 90,
                        child: Center(
                          child: widget.state is AdminLoginLoading
                              ? const SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              : Text(context.l10n.admin),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
