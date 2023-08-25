import 'package:coaching/mp_authorized/cubit/mp_authorized_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:functions_repository/functions_repository.dart';

class MPAuthorizedPage extends StatelessWidget {
  const MPAuthorizedPage({
    super.key,
    required this.code,
    required this.identifier,
  });

  static const name = 'MPAuthorizedPage';
  final String? identifier;
  final String? code;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MpAuthorizedCubit(
        code: code!,
        identifier: identifier!,
        functionsRepository: context.read<FunctionsRepository>(),
      )..authorize(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: BlocBuilder<MpAuthorizedCubit, MpAuthorizedState>(
              builder: (context, state) {
                if (state is MpAuthorizedSuccess) {
                  return const Center(
                    child: Text('Autorizado'),
                  );
                }
                if (state is MpAuthorizedLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return const Center(
                  child: Text('Error'),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
