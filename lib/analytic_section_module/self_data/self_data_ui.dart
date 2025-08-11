import 'package:flutter/material.dart';
import 'package:pinklotus/analytic_section_module/self_data/dialog_self_image.dart';
import 'self_data_model.dart';

class SelfDataTableScreen extends StatefulWidget {
  final List<Data> dataList;

  const SelfDataTableScreen({super.key, required this.dataList});
  @override
  _SelfDataTableScreenState createState() => _SelfDataTableScreenState();
}

class _SelfDataTableScreenState extends State<SelfDataTableScreen> {
  late Future<SelfDataModel?> futureData;

  @override
  void initState() {
    super.initState();
  }

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height,
      width: MediaQuery.sizeOf(context).width,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child:
            widget.dataList.isEmpty
                ? Column(
                  children: [
                    tableDataShow(),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        'Please apply a filter to see the data',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                )
                : CustomDataTable(dataList: widget.dataList),
      ),
    );
  }

  Widget tableDataShow() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: DataTable(
        headingTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        clipBehavior: Clip.antiAlias,

        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        border: TableBorder(
          borderRadius: BorderRadius.all(Radius.elliptical(12, 14)),
          verticalInside: BorderSide(color: Colors.black87, width: 0.5),
        ),
        columns: const [
          DataColumn(
            label: Text('No'),
            headingRowAlignment: MainAxisAlignment.center,
          ),
          DataColumn(
            label: Text('Date'),
            headingRowAlignment: MainAxisAlignment.center,
          ),
          DataColumn(
            label: Text('Hour of Day'),
            headingRowAlignment: MainAxisAlignment.center,
          ),
          DataColumn(
            label: Text('Zone'),
            headingRowAlignment: MainAxisAlignment.center,
          ),
          DataColumn(
            label: Text('Shelf ID'),
            headingRowAlignment: MainAxisAlignment.center,
          ),
          DataColumn(
            label: Text('Number of Hits'),
            headingRowAlignment: MainAxisAlignment.center,
          ),
        ],
        rows: [],
      ),
    );
  }
}

class CustomDataTable extends StatefulWidget {
  final List<dynamic> dataList;
  const CustomDataTable({super.key, required this.dataList});

  @override
  State<CustomDataTable> createState() => _CustomDataTableState();
}

class _CustomDataTableState extends State<CustomDataTable> {
  late MyDataTableSource _dataSource;

  @override
  void initState() {
    super.initState();
    _dataSource = MyDataTableSource(widget.dataList, context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          border: Border.all(color: Colors.black87, width: 0.5),
        ),
        child: PaginatedDataTable(
          showCheckboxColumn: false,
          headingRowHeight: 50,
          dataRowMinHeight: 48,
          columnSpacing: 20,
          availableRowsPerPage: const [10, 20, 50, 100],
          onRowsPerPageChanged: (rows) => setState(() {}),
          rowsPerPage: 10,
          columns: const [
            DataColumn(
              label: Center(
                child: Text(
                  'No',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
            DataColumn(
              label: Center(
                child: Text(
                  'Date',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
            DataColumn(
              label: Center(
                child: Text(
                  'Hour of Day',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
            DataColumn(
              label: Center(
                child: Text(
                  'Zone',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
            DataColumn(
              label: Center(
                child: Text(
                  'Shelf ID',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
            DataColumn(
              label: Center(
                child: Text(
                  'Number of Hits',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
          ],
          source: _dataSource,
        ),
      ),
    );
  }
}

class MyDataTableSource extends DataTableSource {
  final List<dynamic> dataList;
  final BuildContext context;
  MyDataTableSource(this.dataList, this.context);

  @override
  DataRow? getRow(int index) {
    if (index >= dataList.length) return null;
    final data = dataList[index];

    return DataRow(
      cells: [
        DataCell(Text((index + 1).toString())),
        DataCell(Text(data.dATE.toString())),
        DataCell(Text(data.hOUROFDAY.toString())),
        DataCell(Text(data.zONE.toString())),
        DataCell(
          GestureDetector(
            onTap: () => showShelfImageDialog(context, data.sHELFID.toString()),
            child: Text(
              data.sHELFID.toString(),
              style: const TextStyle(
                color: Colors.pinkAccent,
                decoration: TextDecoration.underline,
                decorationColor: Colors.pink,
              ),
            ),
          ),
        ),
        DataCell(Center(child: Text(data.numberofHits.toString()))),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => dataList.length;
  @override
  int get selectedRowCount => 0;
}
