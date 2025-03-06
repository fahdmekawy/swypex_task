import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../../features/exchange_rates/data/datasources/exchange_rates_remote_data_source.dart';
import '../../features/exchange_rates/data/repositories/exchange_rates_repository_impl.dart';
import '../../features/exchange_rates/domain/repositories/exchange_rates_repository.dart';
import '../../features/exchange_rates/domain/usecases/get_exchange_rates.dart';
import '../../features/exchange_rates/presentation/cubit/exchange_rates_cubit.dart';
import '../networking/dio_factory.dart';

final sl = GetIt.instance;

Future<void> setupGetIt() async {
  //Register Dio globally
  sl.registerLazySingleton<Dio>(() => DioFactory.getDio());

  //Register Remote Data Source
  sl.registerLazySingleton<ExchangeRatesRemoteDataSource>(
    () => ExchangeRatesRemoteDataSourceImpl(dio: sl<Dio>()),
  );

  //Register Repository
  sl.registerLazySingleton<ExchangeRatesRepository>(
    () => ExchangeRatesRepositoryImpl(
        remoteDataSource: sl<ExchangeRatesRemoteDataSource>()),
  );

  //Register UseCase
  sl.registerLazySingleton<GetExchangeRates>(
    () => GetExchangeRates(sl<ExchangeRatesRepository>()),
  );

  //Register Cubit
  sl.registerFactory<ExchangeRatesCubit>(
    () => ExchangeRatesCubit(getExchangeRates: sl<GetExchangeRates>()),
  );
}
