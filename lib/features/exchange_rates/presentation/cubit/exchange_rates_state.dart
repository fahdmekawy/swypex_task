import 'package:equatable/equatable.dart';
import '../../domain/entities/exchange_rates_entity.dart';

abstract class ExchangeRatesState extends Equatable {
  const ExchangeRatesState();

  @override
  List<Object?> get props => [];
}

/// Represents the initial state of exchange rates.
class ExchangeRatesInitial extends ExchangeRatesState {}

/// Represents the loading state while fetching exchange rates.
class ExchangeRatesLoading extends ExchangeRatesState {}

/// Represents the successfully loaded exchange rates state.
class ExchangeRatesLoaded extends ExchangeRatesState {
  final ExchangeRatesEntity exchangeRates;

  const ExchangeRatesLoaded(this.exchangeRates);

  @override
  List<Object?> get props => [exchangeRates];
}

/// Represents an error state when fetching exchange rates fails.
class ExchangeRatesError extends ExchangeRatesState {
  final String message;

  const ExchangeRatesError(this.message);

  @override
  List<Object?> get props => [message];
}
