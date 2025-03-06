import 'package:flutter/material.dart';

class CurrencySelector extends StatefulWidget {
  const CurrencySelector({super.key});

  @override
  State<CurrencySelector> createState() => _CurrencySelectorState();
}

class _CurrencySelectorState extends State<CurrencySelector> {
  String? _selectedCurrency;
  final List<String> _currencies = ['USD', 'EUR', 'GBP', 'JPY'];

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: _handleCurrencySelected,
      itemBuilder: _buildCurrencyMenuItems,
      child: _buildCurrencySelectorButton(),
    );
  }

  void _handleCurrencySelected(String value) {
    setState(() {
      _selectedCurrency = value;
    });
  }

  List<PopupMenuEntry<String>> _buildCurrencyMenuItems(BuildContext context) {
    return _currencies.map((String currency) {
      return PopupMenuItem(
        value: currency,
        child: Text(currency),
      );
    }).toList();
  }

  Widget _buildCurrencySelectorButton() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.black, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: FittedBox(
          child: Text(
            _selectedCurrency == null
                ? 'From Currency'
                : 'From $_selectedCurrency',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
