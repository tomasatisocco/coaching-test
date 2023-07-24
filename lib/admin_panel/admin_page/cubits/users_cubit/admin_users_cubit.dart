import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coaching/welcome/models/user_date_model.dart';
import 'package:equatable/equatable.dart';
import 'package:firestore_repository/firestore_repository.dart';

part 'admin_users_state.dart';

class AdminUsersCubit extends Cubit<AdminUsersState> {
  AdminUsersCubit({required FirestoreRepository firestoreRepository})
      : _firestoreRepository = firestoreRepository,
        super(const AdminInitial());

  final FirestoreRepository _firestoreRepository;
  late final StreamSubscription<dynamic> _userListSubscription;

  Future<void> init() async {
    emit(const AdminFetchingUsers());
    try {
      _userListSubscription =
          _firestoreRepository.listenUserList().listen((snapshots) {
        final users = snapshots.docs
            .map(
              (e) => UserDataModel.fromMap(e.data()).copyWith(authId: e.id),
            )
            .toList();
        UserDataModel? user;
        if (state is AdminUsersFetched) {
          final shadowState = state as AdminUsersFetched;
          user = shadowState.user;
          if (user != null) {
            user = users.firstWhere(
              (element) => element.authId == user!.authId,
              orElse: () => user!,
            );
          }
        }
        emit(AdminUsersFetched(users: users, user: user));
      });
    } catch (_) {
      emit(const AdminUsersError());
    }
  }

  Future<void> selectUser(String userId) async {
    if (state is! AdminUsersFetched) return;
    final shadowState = state as AdminUsersFetched;
    final user = shadowState.users.firstWhere(
      (element) => element.authId == userId,
    );
    emit(shadowState.copyWith(user: user));
  }

  @override
  Future<void> close() {
    _userListSubscription.cancel();
    return super.close();
  }
}
