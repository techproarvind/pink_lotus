import 'package:flutter/material.dart';

class CameraFormPage extends StatelessWidget {
  const CameraFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    final inputDecoration = InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );

    Widget buildFieldWithLabel(
      String label,
      Widget field, {
      bool isRequired = false,
    }) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: label,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              children:
                  isRequired
                      ? [
                        const TextSpan(
                          text: '*',
                          style: TextStyle(color: Colors.red),
                        ),
                      ]
                      : [],
            ),
          ),
          const SizedBox(height: 6),
          field,
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left side (Camera preview + Left form fields)
          Expanded(
            flex: 1,
            child: Column(
              children: [
                // Camera preview
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/godavan.png', // Replace with your camera stream
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 16),

                // Left side form fields
                buildFieldWithLabel(
                  'Camera_IP',
                  TextFormField(decoration: inputDecoration),
                  isRequired: true,
                ),
                const SizedBox(height: 16),

                buildFieldWithLabel(
                  'Functionality',
                  DropdownButtonFormField<String>(
                    decoration: inputDecoration,
                    items: const [
                      DropdownMenuItem(
                        value: 'Occupancycam',
                        child: Text('Occupancycam'),
                      ),
                    ],
                    onChanged: (value) {},
                  ),
                ),
                const SizedBox(height: 16),

                buildFieldWithLabel(
                  'Category',
                  TextFormField(decoration: inputDecoration),
                ),
                const SizedBox(height: 16),

                buildFieldWithLabel(
                  'Campos',
                  TextFormField(decoration: inputDecoration),
                ),
                const SizedBox(height: 16),

                buildFieldWithLabel(
                  'Camera_NO',
                  TextFormField(decoration: inputDecoration),
                  isRequired: true,
                ),
              ],
            ),
          ),
          const SizedBox(width: 24),

          // Right side (Right form fields)
          Expanded(
            flex: 1,
            child: Column(
              children: [
                // Framerate field
                buildFieldWithLabel(
                  'Framerate',
                  TextFormField(decoration: inputDecoration),
                  isRequired: true,
                ),
                const SizedBox(height: 16),

                // Region and Brand row
                Row(
                  children: [
                    Expanded(
                      child: buildFieldWithLabel(
                        'Region',
                        DropdownButtonFormField<String>(
                          decoration: inputDecoration,
                          items: const [
                            DropdownMenuItem(
                              value: 'Standard Reagents',
                              child: Text('Standard Reagents'),
                            ),
                          ],
                          onChanged: (value) {},
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: buildFieldWithLabel(
                        'Brand',
                        DropdownButtonFormField<String>(
                          decoration: inputDecoration,
                          items: const [
                            DropdownMenuItem(
                              value: 'Standard Reagents',
                              child: Text('Standard Reagents'),
                            ),
                          ],
                          onChanged: (value) {},
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Location and Zone row
                Row(
                  children: [
                    Expanded(
                      child: buildFieldWithLabel(
                        'Location',
                        DropdownButtonFormField<String>(
                          decoration: inputDecoration,
                          items: const [
                            DropdownMenuItem(
                              value: 'Standard Reagents',
                              child: Text('Standard Reagents'),
                            ),
                          ],
                          onChanged: (value) {},
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: buildFieldWithLabel(
                        'Zone',
                        DropdownButtonFormField<String>(
                          decoration: inputDecoration,
                          items: const [
                            DropdownMenuItem(
                              value: 'Zone A',
                              child: Text('Zone A'),
                            ),
                          ],
                          onChanged: (value) {},
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Section and Live_URL row
                Row(
                  children: [
                    Expanded(
                      child: buildFieldWithLabel(
                        'Section',
                        DropdownButtonFormField<String>(
                          decoration: inputDecoration,
                          items: const [
                            DropdownMenuItem(
                              value: 'Packing',
                              child: Text('Packing'),
                            ),
                          ],
                          onChanged: (value) {},
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: buildFieldWithLabel(
                        'Live_URL',
                        TextFormField(decoration: inputDecoration),
                        isRequired: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // ROI field with refresh icon
                buildFieldWithLabel(
                  'ROI',
                  TextFormField(
                    decoration: inputDecoration.copyWith(
                      suffixIcon: const Icon(Icons.refresh),
                    ),
                  ),
                  isRequired: true,
                ),
                const SizedBox(height: 16),

                // Shift and Camera Status row
                Row(
                  children: [
                    Expanded(
                      child: buildFieldWithLabel(
                        'Shift',
                        DropdownButtonFormField<String>(
                          decoration: inputDecoration,
                          items: const [
                            DropdownMenuItem(
                              value: 'Shift 1',
                              child: Text('Shift 1'),
                            ),
                          ],
                          onChanged: (value) {},
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: buildFieldWithLabel(
                        'Camera Status',
                        DropdownButtonFormField<String>(
                          decoration: inputDecoration,
                          items: const [
                            DropdownMenuItem(
                              value: 'Online',
                              child: Text('Online'),
                            ),
                          ],
                          onChanged: (value) {},
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Appliedfunctions field with edit icon
                buildFieldWithLabel(
                  'Appliedfunctions',
                  TextFormField(
                    decoration: inputDecoration.copyWith(
                      suffixIcon: const Icon(Icons.edit),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Save and Clear buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        backgroundColor: const Color(0xFFFF7CBA),
                      ),
                      child: const Text(
                        'SAVE',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 24),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'CLEAR',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
