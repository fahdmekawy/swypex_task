// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exchange_rates_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExchangeRatesModel _$ExchangeRatesModelFromJson(Map<String, dynamic> json) =>
    ExchangeRatesModel(
      startDate: json['start_date'] as String,
      endDate: json['end_date'] as String,
      source: json['source'] as String,
      quotes: json['quotes'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$ExchangeRatesModelToJson(ExchangeRatesModel instance) =>
    <String, dynamic>{
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'source': instance.source,
      'quotes': instance.quotes,
    };
