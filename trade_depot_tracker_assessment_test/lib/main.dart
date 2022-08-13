import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_depot_tracker_assessment_test/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding?.ensureInitialized();
  // await Hive.initFlutter();
  // await Hive.openBox(HiveKeys.appBox);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) async {
      // await Hive.openBox(HiveKeys.appBox);
      runApp(
       const ProviderScope(
          child: TradeDepotAssessment()
        ),
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
      routes: routes,
    );
  }
}
