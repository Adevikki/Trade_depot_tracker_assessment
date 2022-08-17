import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_depot_tracker_assessment_test/core/models/api_response.dart';

final loginAuthProvider = StateNotifierProvider<LoginViewmodel, LoginState>(
    (ref) => LoginViewmodel(FirebaseAuth.instance));

class LoginViewmodel extends StateNotifier<LoginState> {
  LoginViewmodel(this._auth) : super(const LoginState());

  final FirebaseAuth _auth;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<ApiResponse> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(status: Status.loading);
    try {
      final response = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        state = state.copyWith(status: Status.success);
        return ApiResponse(
          message: "Login Successful",
          successful: true,
        );
      } else {
        state = state.copyWith(status: Status.error);
        return ApiResponse(
          message: "An error occurred",
          successful: false,
        );
      }
    } on FirebaseException catch (e) {
      state = state.copyWith(status: Status.error);
      return ApiResponse(
        message: e.message ?? "An error occcurred",
        successful: false,
      );
    }
  }
}

class LoginState {
  final Status status;

  const LoginState({
    this.status = Status.idle,
  });

  LoginState copyWith({
    Status? status,
  }) {
    return LoginState(
      status: status ?? this.status,
    );
  }
}

enum Status { error, success, loading, idle }

class Users {
  final String email;
  final String password;

  Users({
    required this.email,
    required this.password,
  });

  static Map<String, dynamic> toFireStore({
    required String email,
    required String password,
  }) {
    return {
      'email': email,
      'password': password,
    };
  }
}
