import 'package:equatable/equatable.dart';
import '../../domain/entities/exchange_rates_entity.dart';

abstract class ExchangeRatesState extends Equatable {
  const ExchangeRatesState();

  @override
  List<Object?> get props => [];
}

class ExchangeRatesInitial extends ExchangeRatesState {}

class ExchangeRatesLoading extends ExchangeRatesState {}

class ExchangeRatesLoaded extends ExchangeRatesState {
  final ExchangeRatesEntity exchangeRates;

  const ExchangeRatesLoaded(this.exchangeRates);

  @override
  List<Object?> get props => [exchangeRates];
}

class ExchangeRatesError extends ExchangeRatesState {
  final String message;

  const ExchangeRatesError(this.message);

  @override
  List<Object?> get props => [message];
}
