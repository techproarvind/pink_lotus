import 'package:flutter/material.dart';
import 'package:pinklotus/analytic_section_module/employee_tracking/employee_tracking_model.dart';

class EmployeeTrackingTableScreen extends StatefulWidget {
  final List<Data> dataList;

  const EmployeeTrackingTableScreen({super.key, required this.dataList});

  @override
  _EmployeeTrackingTableScreenState createState() =>
      _EmployeeTrackingTableScreenState();
}

class _EmployeeTrackingTableScreenState
    extends State<EmployeeTrackingTableScreen> {
  late final EmployeeDataSource _dataSource;

  @override
  void initState() {
    super.initState();
    _dataSource = EmployeeDataSource(widget.dataList);
  }

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
                    tableDataWidget(),
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
                :
                 SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: PaginatedDataTable(
                    showCheckboxColumn: false,
                    headingRowHeight: 50,
                    dataRowMinHeight: 48,
                    rowsPerPage: 10,
                    columnSpacing: 20,
                    availableRowsPerPage: const [10, 20, 50, 100],
                    onRowsPerPageChanged: (rows) {
                      setState(() {});
                    },

                    columns: const [
                      DataColumn(
                        label: Text(
                          'Emp ID',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        headingRowAlignment: MainAxisAlignment.center,
                      ),
                      DataColumn(
                        label: Text(
                          'Date',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        headingRowAlignment: MainAxisAlignment.center,
                      ),
                      DataColumn(
                        label: Text(
                          'First In Time',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        headingRowAlignment: MainAxisAlignment.center,
                      ),
                      DataColumn(
                        label: Text(
                          'Last Out Time',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        headingRowAlignment: MainAxisAlignment.center,
                      ),
                      DataColumn(
                        label: Text(
                          'Time on Floor',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        headingRowAlignment: MainAxisAlignment.center,
                      ),
                    ],
                    source: _dataSource,
                  ),
                ),
      ),
    );
  }

  Widget tableDataWidget() {
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
        columns: [
          DataColumn(
            label: Text('Emp Id'),
            headingRowAlignment: MainAxisAlignment.center,
          ),
          DataColumn(
            label: Text('Date'),
            headingRowAlignment: MainAxisAlignment.center,
          ),
          DataColumn(
            label: Text('First in Time'),
            headingRowAlignment: MainAxisAlignment.center,
          ),
          DataColumn(
            label: Text('Last Out Time'),
            headingRowAlignment: MainAxisAlignment.center,
          ),
          DataColumn(
            label: Text('Total time spent on floor'),
            headingRowAlignment: MainAxisAlignment.center,
          ),
        ],
        rows:
            widget.dataList.map((data) {
              return DataRow(
                cells: [
                  DataCell(Center(child: Text(data.eMPID.toString()))),
                  DataCell(Center(child: Text(data.dATE ?? ''))),
                  DataCell(Center(child: Text(data.s1stINTIME.toString()))),
                  DataCell(Center(child: Text(data.lastOUTTIME.toString()))),
                  DataCell(
                    Center(child: Text(data.tOTALTIMESPENTONFLOOR.toString())),
                  ),
                ],
              );
            }).toList(),
      ),
    );
  }
}

class EmployeeDataSource extends DataTableSource {
  final List<Data> _data;

  EmployeeDataSource(this._data);

  @override
  DataRow getRow(int index) {
    if (index >= _data.length) return const DataRow(cells: []);

    final employee = _data[index];

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Center(child: Text(employee.eMPID.toString()))),
        DataCell(Center(child: Text(employee.dATE ?? ''))),
        DataCell(Center(child: Text(employee.s1stINTIME ?? ''))),
        DataCell(Center(child: Text(employee.lastOUTTIME ?? ''))),
        DataCell(Center(child: Text(employee.tOTALTIMESPENTONFLOOR ?? ''))),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0;
}
