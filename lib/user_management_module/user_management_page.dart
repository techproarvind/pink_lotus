import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserManagementScreen extends StatefulWidget {
  final Function(int) callBack;
  const UserManagementScreen({Key? key, required this.callBack})
    : super(key: key);

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _employeeIdController = TextEditingController();
  final TextEditingController _employeeNameController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();

  String? _selectedLocation;

  final List<String> _locations = ['Location 1', 'Location 2', 'Location 3'];

  final Map<String, bool> _menuAccess = {
    'Dashboard': false,
    'Alerts': false,
    'Alert Videos': false,
    'Employee Tracking': false,
    'Cameras': false,
    'Analytics': false,
    'User Management': false,
    'Support Center': false,
  };

  void _clearForm() {
    _formKey.currentState?.reset();
    _employeeIdController.clear();
    _employeeNameController.clear();
    _designationController.clear();
    setState(() {
      _selectedLocation = null;
      _menuAccess.updateAll((key, value) => false);
    });
  }

  void _saveForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // You can handle form submission here
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Form saved successfully!')));
    }
  }

  @override
  void dispose() {
    _employeeIdController.dispose();
    _employeeNameController.dispose();
    _designationController.dispose();
    super.dispose();
  }

  Widget _buildLabel(String text, {bool required = false}) {
    return RichText(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Color(0xFF1A1A1A),
        ),
        children:
            required
                ? [
                  TextSpan(
                    text: ' *',
                    style: GoogleFonts.oxygen(color: Colors.pink),
                  ),
                ]
                : [],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // For dropdown arrow color
    final iconColor = const Color(0xFF1A1A1A);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    widget.callBack.call(1);
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.black,
                    size: 16,
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  'Camera List',
                  style: GoogleFonts.oxygen(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1A1A1A),
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            width: MediaQuery.sizeOf(context).width,

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Grid with 2 columns on wide screens, 1 column on narrow
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final isWide = constraints.maxWidth >= 600;
                        return Wrap(
                          runSpacing: 24,
                          spacing: 40,
                          children: [
                            SizedBox(
                              width:
                                  isWide
                                      ? (constraints.maxWidth / 2) - 20
                                      : constraints.maxWidth,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildLabel('Employee ID', required: true),
                                  const SizedBox(height: 6),
                                  TextFormField(
                                    controller: _employeeIdController,
                                    decoration: const InputDecoration(
                                      fillColor: Color(0xffC1C5D3),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        borderSide: BorderSide(
                                          color: Colors.pinkAccent,
                                          width: 1,
                                        ),
                                      ),
                                      hintText: "Employee ID",
                                    ),

                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFF1A1A1A),
                                    ),
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'Employee ID is required';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width:
                                  isWide
                                      ? (constraints.maxWidth / 2) - 20
                                      : constraints.maxWidth,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildLabel('Employee Name', required: true),
                                  const SizedBox(height: 6),
                                  TextFormField(
                                    controller: _employeeNameController,
                                    decoration: const InputDecoration(
                                      fillColor: Color(0xffC1C5D3),

                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        borderSide: BorderSide(
                                          color: Colors.pinkAccent,
                                          width: 1,
                                        ),
                                      ),
                                      hintText: "Employee Name",
                                    ),

                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFF1A1A1A),
                                    ),
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'Employee Name is required';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width:
                                  isWide
                                      ? (constraints.maxWidth / 2) - 20
                                      : constraints.maxWidth,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildLabel('Designation', required: true),
                                  const SizedBox(height: 6),
                                  TextFormField(
                                    controller: _designationController,
                                    decoration: const InputDecoration(
                                      fillColor: Color(0xffC1C5D3),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        borderSide: BorderSide(
                                          color: Colors.pinkAccent,
                                          width: 1,
                                        ),
                                      ),
                                      hintText: "Designation",
                                    ),

                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFF1A1A1A),
                                    ),
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'Designation is required';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width:
                                  isWide
                                      ? (constraints.maxWidth / 2) - 20
                                      : constraints.maxWidth,

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildLabel('Access List', required: true),
                                  const SizedBox(height: 6),
                                  InputDecorator(
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 14,
                                          ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                          color: Color(0xFFE5E7EB),
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                          color: Color(0xFFE5E7EB),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                          color: Color(0xFFF48FB1),
                                          width: 2,
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: const Color(0xFFF9FAFF),
                                    ),
                                    child: SizedBox(
                                      height: 20,
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          isExpanded: true,
                                          hint: Text(
                                            'Select Location',
                                            style: GoogleFonts.oxygen(
                                              fontSize: 13,
                                              color: Color(0xFFA1A1A1),
                                            ),
                                          ),
                                          value: _selectedLocation,
                                          icon: Icon(
                                            Icons.keyboard_arrow_down,
                                            color: iconColor,
                                          ),
                                          items:
                                              _locations
                                                  .map(
                                                    (loc) => DropdownMenuItem<
                                                      String
                                                    >(
                                                      value: loc,
                                                      child: Text(
                                                        loc,
                                                        style: const TextStyle(
                                                          fontSize: 13,
                                                          color: Color(
                                                            0xFF1A1A1A,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              _selectedLocation = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (_selectedLocation == null)
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 6,
                                        left: 12,
                                      ),
                                      child: Text(
                                        'Access List is required',
                                        style: GoogleFonts.oxygen(
                                          fontSize: 11,
                                          color: Colors.red.shade700,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  // Menu Access
                  Container(
                    margin: const EdgeInsets.only(top: 32),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _buildLabel('Menu Access', required: true),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width / 1.5,
                          child: Wrap(
                            spacing: 12,
                            runSpacing: 10,
                            alignment: WrapAlignment.start,
                            direction: Axis.horizontal,
                            crossAxisAlignment: WrapCrossAlignment.start,
                            children:
                                _menuAccess.keys.map((key) {
                                  return SizedBox(
                                    width: 160,
                                    child: CheckboxListTile(
                                      contentPadding: EdgeInsets.zero,
                                      dense: true,
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      title: Text(
                                        key,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: Color(0xFF1A1A1A),
                                        ),
                                      ),
                                      value: _menuAccess[key],
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _menuAccess[key] = value ?? false;
                                        });
                                      },
                                      activeColor: const Color(0xFFF48FB1),
                                      checkColor: Colors.white,
                                    ),
                                  );
                                }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Buttons
                  Container(
                    margin: const EdgeInsets.only(top: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _saveForm,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 40,
                                vertical: 14,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(9999),
                              ),
                              elevation: 0,
                              textStyle: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                              // Gradient background
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                            ),
                            child: Ink(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFFE83E7D),
                                    Color(0xFFF48FB1),
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(9999),
                                ),
                              ),
                              child: Container(
                                constraints: const BoxConstraints(
                                  minWidth: 100,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'SAVE',
                                  style: GoogleFonts.oxygen(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 24),
                        OutlinedButton(
                          onPressed: _clearForm,
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9999),
                            ),
                            side: const BorderSide(
                              color: Color(0xFF4B5563),
                            ), // gray-600
                            textStyle: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF4B5563),
                            ),
                          ),
                          child: Text(
                            'CLEAR',
                            style: GoogleFonts.oxygen(color: Color(0xFF4B5563)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
