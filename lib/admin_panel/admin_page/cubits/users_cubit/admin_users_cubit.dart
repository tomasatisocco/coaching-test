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
  UserDataModel? _shadowUser;

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
            _shadowUser = user;
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
    _shadowUser = user;
    emit(shadowState.copyWith(user: user));
  }

  void updateSelectedUser(UserDataModel user) {
    if (state is! AdminUsersFetched) return;
    final shadowState = state as AdminUsersFetched;
    emit(const AdminFetchingUsers());
    final users = shadowState.users.map((e) {
      if (e.authId == user.authId) {
        return user;
      }
      return e;
    }).toList();
    emit(shadowState.copyWith(users: users, user: user));
  }

  bool get isUserUpdated {
    if (state is! AdminUsersFetched) return false;
    final shadowState = state as AdminUsersFetched;
    if (_shadowUser == null) return false;
    if (shadowState.user == null) return false;
    return shadowState.user != _shadowUser;
  }

  void clearUser() {
    if (state is! AdminUsersFetched) return;
    final shadowState = state as AdminUsersFetched;
    emit(shadowState.copyWith(user: _shadowUser));
  }

  void unSelectUser() {
    if (state is! AdminUsersFetched) return;
    final shadowState = state as AdminUsersFetched;
    emit(const AdminFetchingUsers());
    _shadowUser = null;
    emit(AdminUsersFetched(users: shadowState.users));
  }

  Future<void> updateUser() async {
    if (state is! AdminUsersFetched) return;
    final shadowState = state as AdminUsersFetched;
    final user = shadowState.user;
    if (user == null) return;
    try {
      emit(shadowState.copyWith(isUpdating: true));
      await _firestoreRepository.updateUser(user.toMap(), user.id!);
      _shadowUser = user;
      emit(shadowState.copyWith());
    } catch (_) {
      emit(shadowState.copyWith(user: _shadowUser));
    }
  }

  Future<void> markUserAsRead({required UserDataModel user}) async {
    if (state is! AdminUsersFetched) return;
    try {
      await _firestoreRepository.updateUser(
        user.copyWith(isRead: true).toMap(),
        user.authId!,
      );
    } catch (_) {}
  }

  @override
  Future<void> close() {
    _userListSubscription.cancel();
    return super.close();
  }
}
