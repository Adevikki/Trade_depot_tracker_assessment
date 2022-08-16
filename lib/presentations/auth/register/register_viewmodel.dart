import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_depot_tracker_assessment_test/core/models/api_response.dart';
import 'package:trade_depot_tracker_assessment_test/presentations/auth/login/login_auth_viewmodel.dart';

final authProvider = StateNotifierProvider<RegisterViewmodel, RegisterState>(
    (ref) =>
        RegisterViewmodel(FirebaseAuth.instance, FirebaseFirestore.instance));

class RegisterViewmodel extends StateNotifier<RegisterState> {
  RegisterViewmodel(this._auth, this._fireStore) : super(const RegisterState());

  final FirebaseAuth _auth;
  final FirebaseFirestore _fireStore;

  Future<ApiResponse> createUser({
    required String email,
    required String password,
    required String fullName,
  }) async {
    state = state.copyWith(status: Status.loading);
    try {
      final user = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (user.user != null) {
        // updateUserinfo(
        //   uid: user.user!.uid,
        //   email: email,
        //   fullname: fullName,
        // );
        state = state.copyWith(status: Status.success);
        return ApiResponse(
          data: user,
          message: "Registration Successful",
          successful: true,
        );
      } else {
        state = state.copyWith(
          status: Status.error,
        );
        return ApiResponse(
          message: "An error occurred",
          successful: false,
        );
      }
    } on FirebaseException catch (e) {
      state = state.copyWith(
        status: Status.error,
      );
      return ApiResponse(
        message: e.message ?? "An error occcurred",
        successful: false,
      );
    } catch (e) {
      state = state.copyWith(
        status: Status.error,
      );
      return ApiResponse(
        message: "An error occcurred",
        successful: false,
      );
    }
  }

  void updateUserinfo({
    required String uid,
    required String email,
    required String fullname,
  }) async {
    try {
      await _fireStore.collection('users').doc(uid).set(Users.toFireStore(
            uid: uid,
            email: email,
            fullName: fullname,
          ));
    } catch (e) {
      state = state.copyWith(status: Status.error);
      print(e);
    }
  }
}

class RegisterState {
  final Status status;

  const RegisterState({
    this.status = Status.idle,
  });

  RegisterState copyWith({
    Status? status,
  }) {
    return RegisterState(
      status: status ?? this.status,
    );
  }
}

class Users {
  final String fullName;
  final String uid;
  final String email;

  Users({
    required this.fullName,
    required this.uid,
    required this.email,
  });

  static Map<String, dynamic> toFireStore({
    required String uid,
    required String email,
    required String fullName,
  }) {
    return {
      'uid': uid,
      'email': email,
      'fullName': fullName,
    };
  }
}
