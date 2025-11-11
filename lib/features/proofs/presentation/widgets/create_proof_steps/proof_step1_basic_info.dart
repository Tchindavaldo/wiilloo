import 'package:flutter/material.dart';

class ProofStep1BasicInfo extends StatefulWidget {
  final Map<String, dynamic> formData;
  final Function(String, dynamic) onDataChanged;

  const ProofStep1BasicInfo({
    Key? key,
    required this.formData,
    required this.onDataChanged,
  }) : super(key: key);

  @override
  State<ProofStep1BasicInfo> createState() => _ProofStep1BasicInfoState();
}

class _ProofStep1BasicInfoState extends State<ProofStep1BasicInfo> {
  final _titleController = TextEditingController();
  final _fieldController = TextEditingController();
  final _schoolController = TextEditingController();
  String? _selectedLevel;
  String? _selectedClass;
  bool _isCorrection = false;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.formData['title'] ?? '';
    _fieldController.text = widget.formData['field'] ?? '';
    _schoolController.text = widget.formData['school'] ?? '';
    _selectedLevel = widget.formData['level'];
    _selectedClass = widget.formData['class'];
    _isCorrection = widget.formData['isCorrection'] ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Basic Information',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1E293B),
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 24),
        
        // Proof Title
        _buildTextField(
          label: 'Proof Title*',
          controller: _titleController,
          placeholder: 'e.g., Mid-term Exam, 2024',
          onChanged: (value) => widget.onDataChanged('title', value),
        ),
        const SizedBox(height: 20),
        
        // Level
        _buildDropdown(
          label: 'Level*',
          value: _selectedLevel,
          placeholder: 'Select level',
          items: const [
            {'value': 'high_school', 'label': 'High School'},
            {'value': 'undergraduate', 'label': 'Undergraduate'},
            {'value': 'graduate', 'label': 'Graduate'},
          ],
          onChanged: (value) {
            setState(() => _selectedLevel = value);
            widget.onDataChanged('level', value);
          },
        ),
        const SizedBox(height: 20),
        
        // Class
        _buildDropdown(
          label: 'Class*',
          value: _selectedClass,
          placeholder: 'Select class',
          items: const [
            {'value': 'class_10', 'label': 'Class 10'},
            {'value': 'class_11', 'label': 'Class 11'},
            {'value': 'class_12', 'label': 'Class 12'},
          ],
          onChanged: (value) {
            setState(() => _selectedClass = value);
            widget.onDataChanged('class', value);
          },
        ),
        const SizedBox(height: 20),
        
        // Field
        _buildTextField(
          label: 'Field',
          controller: _fieldController,
          placeholder: 'e.g., Mathematics',
          onChanged: (value) => widget.onDataChanged('field', value),
        ),
        const SizedBox(height: 20),
        
        // School
        _buildTextField(
          label: 'School',
          controller: _schoolController,
          placeholder: 'e.g., Central High School',
          onChanged: (value) => widget.onDataChanged('school', value),
        ),
        const SizedBox(height: 20),
        
        // Is Correction Toggle
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFFE2E8F0),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: const Text(
                  'This is a correction of a previous proof',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1E293B),
                  ),
                ),
              ),
              Switch(
                value: _isCorrection,
                onChanged: (value) {
                  setState(() => _isCorrection = value);
                  widget.onDataChanged('isCorrection', value);
                },
                activeColor: const Color(0xFF4A90E2),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String placeholder,
    required Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: const TextStyle(
              color: Color(0xFFA0A0A0),
              fontSize: 15,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF4A90E2), width: 2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required String placeholder,
    required List<Map<String, String>> items,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: DropdownButtonFormField<String>(
            value: value,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              border: InputBorder.none,
              hintText: placeholder,
              hintStyle: const TextStyle(
                color: Color(0xFFA0A0A0),
                fontSize: 15,
              ),
            ),
            icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF64748B)),
            items: items.map((item) {
              return DropdownMenuItem<String>(
                value: item['value'],
                child: Text(
                  item['label']!,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color(0xFF1E293B),
                  ),
                ),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _fieldController.dispose();
    _schoolController.dispose();
    super.dispose();
  }
}
