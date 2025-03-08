import '../../../../core/helpers/typedef.dart';

/// This repository acts as an interface, allowing different implementations
/// (such as remote or local data sources) to provide exchange rate data.
abstract class ExchangeRatesRepository {
  FutureEitherExchangeRates getExchangeRates({
    required String startDate,
    required String endDate,
    required String source,
  });
}
