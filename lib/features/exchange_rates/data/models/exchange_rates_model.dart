import 'package:json_annotation/json_annotation.dart';
import '../../../../core/helpers/typedef.dart';
import '../../domain/entities/exchange_rates_entity.dart';

part 'exchange_rates_model.g.dart';

/// A data model that represents exchange rates and extends [ExchangeRatesEntity].
@JsonSerializable()
class ExchangeRatesModel extends ExchangeRatesEntity {
  @JsonKey(name: 'start_date')
  final String startDate;

  @JsonKey(name: 'end_date')
  final String endDate;

  final String source;
  final ExchangeRatesMap quotes;

  const ExchangeRatesModel({
    required this.startDate,
    required this.endDate,
    required this.source,
    required this.quotes,
  }) : super(
          startDate: startDate,
          endDate: endDate,
          source: source,
          quotes: quotes,
        );

  factory ExchangeRatesModel.fromJson(Map<String, dynamic> json) =>
      _$ExchangeRatesModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExchangeRatesModelToJson(this);
}
