import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swypex_task/core/widgets/app_loader.dart';
import 'package:swypex_task/features/exchange_rates/presentation/cubit/exchange_rates_cubit.dart';
import 'package:swypex_task/features/exchange_rates/presentation/cubit/exchange_rates_state.dart';
import '../../../../core/theming/text_styles.dart';
import '../../domain/entities/exchange_rates_entity.dart';
import 'next_and_previous_buttons.dart';

class ExchangeRatesTable extends StatefulWidget {
  const ExchangeRatesTable({super.key});

  @override
  State<ExchangeRatesTable> createState() => _ExchangeRatesTableState();
}

class _ExchangeRatesTableState extends State<ExchangeRatesTable> {
  /// Tracks the current page for pagination.
  int currentPage = 0;

  /// Number of rows to display per page.
  static const int rowsPerPage = 10;

  @override
  Widget build(BuildContext context) {
    /// Table header labels.
    const List<String> tableHeaderContents = ['Date', 'From', 'To', 'Price'];

    /// Access the [ExchangeRatesCubit] to read the selected currencies.
    var exchangeCubit = context.read<ExchangeRatesCubit>();

    return BlocBuilder<ExchangeRatesCubit, ExchangeRatesState>(
      builder: (context, state) {
        if (state is ExchangeRatesLoaded) {
          final allRows = _buildTableRows(state.exchangeRates, exchangeCubit);
          final paginatedRows = _getPaginatedRows(allRows);

          return Column(
            children: [
              Table(
                border: TableBorder.all(color: Colors.white30),
                columnWidths: {
                  0: FixedColumnWidth(MediaQuery.of(context).size.width * 0.3),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  _buildTableHeader(tableHeaderContents),
                  ...paginatedRows,
                ],
              ),
              const SizedBox(height: 32),

              /// Pagination controls for navigating between pages.
              NextAndPreviousButtons(
                onNext: () {
                  if ((currentPage + 1) * rowsPerPage < allRows.length) {
                    setState(() {
                      currentPage++;
                    });
                  }
                },
                onPrevious: () {
                  if (currentPage > 0) {
                    setState(() {
                      currentPage--;
                    });
                  }
                },
              ),
            ],
          );
        } else if (state is ExchangeRatesError) {
          return Text(
            state.message,
            textAlign: TextAlign.center,
            style: AppTextStyles.boldRed20,
          );
        } else if (state is ExchangeRatesLoading) {
          return Column(
            children: [
              AppLoader(),
            ],
          );
        } else {
          return Text(
            'Please Select Your Dates and Currency to show you the details',
            textAlign: TextAlign.center,
            style: AppTextStyles.boldBlack20,
          );
        }
      },
    );
  }

  /// Returns a paginated list of table rows based on the current page.
  List<TableRow> _getPaginatedRows(List<TableRow> allRows) {
    int startIndex = currentPage * rowsPerPage;
    int endIndex = startIndex + rowsPerPage;
    if (startIndex >= allRows.length) return [];
    return allRows.sublist(
        startIndex, endIndex > allRows.length ? allRows.length : endIndex);
  }
}

/// Builds the table header row.
TableRow _buildTableHeader(List<String> tableHeaderContents) => TableRow(
      decoration: BoxDecoration(color: Colors.black26),
      children: tableHeaderContents
          .map(
            (e) => TableCell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  e,
                  style: AppTextStyles.boldBlack14,
                ),
              ),
            ),
          )
          .toList(),
    );

/// Builds table rows from exchange rate data.
List<TableRow> _buildTableRows(
    ExchangeRatesEntity exchangeRatesModel, ExchangeRatesCubit exchangeCubit) {
  List<TableRow> rows = [];

  for (var entry in exchangeRatesModel.quotes.entries) {
    String date = entry.key;
    var quoteValues = entry.value;

    if (quoteValues == null || quoteValues.isEmpty) {
      rows.add(
        TableRow(
          decoration: BoxDecoration(
            color: rows.length % 2 == 0 ? Colors.white30 : Colors.black12,
          ),
          children: [
            _buildTableCell(date),
            _buildTableCell('-'),
            _buildTableCell('-'),
            _buildTableCell('-'),
          ],
        ),
      );
      continue;
    }

    double usdToEgp = quoteValues['USDEGP'] ?? 0.0;
    rows.add(
      TableRow(
        decoration: BoxDecoration(
          color: rows.length % 2 == 0 ? Colors.white30 : Colors.black12,
        ),
        children: [
          _buildTableCell(date),
          _buildTableCell(exchangeCubit.fromCurrency),
          _buildTableCell(exchangeCubit.toCurrency),
          _buildTableCell(usdToEgp.toStringAsFixed(2)),
        ],
      ),
    );
  }

  return rows;
}

Widget _buildTableCell(String text, {bool isHeader = false}) {
  return TableCell(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.bold,
        ),
      ),
    ),
  );
}
