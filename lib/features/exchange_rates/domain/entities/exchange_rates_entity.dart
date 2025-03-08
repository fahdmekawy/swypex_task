import 'package:equatable/equatable.dart';
import '../../../../core/helpers/typedef.dart';

/// Represents the exchange rates data model used in the application.
class ExchangeRatesEntity extends Equatable {
  final String startDate;
  final String endDate;
  final String source;
  final ExchangeRatesMap quotes;

  const ExchangeRatesEntity({
    required this.startDate,
    required this.endDate,
    required this.source,
    required this.quotes,
  });



  @override
  List<Object?> get props => [startDate, endDate, source, quotes];
}
