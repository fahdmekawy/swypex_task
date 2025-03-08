import 'package:flutter/material.dart';
import 'package:swypex_task/core/theming/text_styles.dart';

class CurrencySelector extends StatefulWidget {
  final String? placeHolder;
  final String selectedCurrency;
  final ValueChanged<String> onCurrencyChanged;

  const CurrencySelector({
    super.key,
    this.placeHolder,
    required this.selectedCurrency,
    required this.onCurrencyChanged,
  });

  @override
  State<CurrencySelector> createState() => _CurrencySelectorState();
}

class _CurrencySelectorState extends State<CurrencySelector> {
  List<String> currencies = ['USD', 'EUR', 'EGP'];

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: _handleCurrencySelected,
      itemBuilder: _buildCurrencyMenuItems,
      child: _buildCurrencySelectorButton(),
    );
  }

  void _handleCurrencySelected(String value) {
    widget.onCurrencyChanged(value);
  }

  List<PopupMenuEntry<String>> _buildCurrencyMenuItems(BuildContext context) {
    return currencies.map((String currency) {
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
            widget.selectedCurrency.isEmpty
                ? '${widget.placeHolder} Currency'
                : '${widget.placeHolder} ${widget.selectedCurrency}',
            style: AppTextStyles.boldBlack16,
          ),
        ),
      ),
    );
  }
}
