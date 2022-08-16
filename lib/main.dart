import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_depot_tracker_assessment_test/presentations/home/get_started_view.dart';
import 'package:trade_depot_tracker_assessment_test/routes.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) async {
      runApp(
        const ProviderScope(child: TradeDepotAssessment()),
      );
    },
  );
}

class TradeDepotAssessment extends StatelessWidget {
  const TradeDepotAssessment({Key? key}) : super(key: key);
  // final _appRouter = TradeDepotRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cooperative Mobile App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      initialRoute: GetStartedView.routeName,
      routes: routes,
    );
  }
}
