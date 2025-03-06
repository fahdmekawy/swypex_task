import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/exchange_rates_entity.dart';

part 'exchange_rates_model.g.dart';

@JsonSerializable()
class ExchangeRatesModel extends ExchangeRatesEntity {
  const ExchangeRatesModel({
    required super.startDate,
    required super.endDate,
    required super.source,
    required super.quotes,
  });

  factory ExchangeRatesModel.fromJson(Map<String, dynamic> json) =>
      _$ExchangeRatesModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExchangeRatesModelToJson(this);
}
