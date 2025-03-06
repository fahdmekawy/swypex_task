import 'package:flutter/material.dart';

class ExchangeRatesTable extends StatelessWidget {
  const ExchangeRatesTable({super.key});

  @override
  Widget build(BuildContext context) {
    const List<String> tableHeaderContents = ['Date', 'From', 'To', 'Price'];
    return Table(
      border: TableBorder.all(color: Colors.white30),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        _buildTableHeader(tableHeaderContents),
        ..._buildTableRows(),
      ],
    );
  }
}

TableRow _buildTableHeader(List<String> tableHeaderContents) => TableRow(
      decoration: BoxDecoration(color: Colors.black26),
      children: tableHeaderContents
          .map(
            (e) => TableCell(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  e,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
          .toList(),
    );

List<TableRow> _buildTableRows() {
  return List.generate(
    10,
    (index) => TableRow(
      decoration: BoxDecoration(
        color: index % 2 == 0 ? Colors.white30 : Colors.black12,
      ),
      children: [
        TableCell(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Data'),
          ),
        ),
        TableCell(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Data'),
          ),
        ),
        TableCell(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Data'),
          ),
        ),
        TableCell(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Title 3',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    ),
  );
}
