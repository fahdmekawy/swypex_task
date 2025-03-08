import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/di/di_container.dart';
import 'features/exchange_rates/presentation/cubit/exchange_rates_cubit.dart';
import 'features/exchange_rates/presentation/views/exchange_rates_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Loads environment variables from the .env file.
  await dotenv.load(fileName: ".env");

  /// Sets up dependency injection using GetIt.
  await setupGetIt();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      /// Provides the ExchangeRatesCubit instance from GetIt.
      home: BlocProvider(
        create: (context) => sl<ExchangeRatesCubit>(),
        child: ExchangeRatesScreen(),
      ),
    );
  }
}
