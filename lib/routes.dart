import 'package:flutter/material.dart';
import 'package:trade_depot_tracker_assessment_test/presentations/auth/register/register_name_view.dart';
import 'package:trade_depot_tracker_assessment_test/presentations/home/get_started_view.dart';

import 'presentations/auth/login/login_view.dart';

final Map<String, WidgetBuilder> routes = {
  GetStartedView.routeName: (context) => const GetStartedView(),
  LoginView.routeName: (context) => const LoginView(),
  FullNameRegisterView.routeName: (context) => const FullNameRegisterView(),
};
