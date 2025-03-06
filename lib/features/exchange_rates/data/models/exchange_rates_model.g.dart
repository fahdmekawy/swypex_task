// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exchange_rates_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExchangeRatesModel _$ExchangeRatesModelFromJson(Map<String, dynamic> json) =>
    ExchangeRatesModel(
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      source: json['source'] as String,
      quotes: (json['quotes'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k,
            (e as Map<String, dynamic>).map(
              (k, e) => MapEntry(k, (e as num).toDouble()),
            )),
      ),
    );

Map<String, dynamic> _$ExchangeRatesModelToJson(ExchangeRatesModel instance) =>
    <String, dynamic>{
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'source': instance.source,
      'quotes': instance.quotes,
    };
