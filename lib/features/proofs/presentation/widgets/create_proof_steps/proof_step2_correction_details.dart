import 'package:flutter/material.dart';

class ProofStep2CorrectionDetails extends StatefulWidget {
  final Map<String, dynamic> formData;
  final Function(String, dynamic) onDataChanged;

  const ProofStep2CorrectionDetails({
    Key? key,
    required this.formData,
    required this.onDataChanged,
  }) : super(key: key);

  @override
  State<ProofStep2CorrectionDetails> createState() => _ProofStep2CorrectionDetailsState();
}

class _ProofStep2CorrectionDetailsState extends State<ProofStep2CorrectionDetails> {
  List<Map<String, dynamic>> _corrections = [];
  int _selectedCorrectionIndex = 0;

  @override
  void initState() {
    super.initState();
    _corrections = List<Map<String, dynamic>>.from(
      widget.formData['corrections'] ?? [_createEmptyCorrection()],
    );
  }

  Map<String, dynamic> _createEmptyCorrection() {
    return {
      'correctorName': '',
      'correctionYear': '',
      'correctionLevel': '',
      'image': null,
    };
  }

  void _addCorrection() {
    setState(() {
      _corrections.add(_createEmptyCorrection());
      _selectedCorrectionIndex = _corrections.length - 1;
    });
    widget.onDataChanged('corrections', _corrections);
  }

  void _updateCorrection(String key, dynamic value) {
    setState(() {
      _corrections[_selectedCorrectionIndex][key] = value;
    });
    widget.onDataChanged('corrections', _corrections);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Correction Details',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1E293B),
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 16),
        
        // Correction Tabs
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0xFFF7F8FC),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...List.generate(_corrections.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: _buildCorrectionTab(index),
                  );
                }),
                _buildAddCorrectionButton(),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        
        // Current Correction Form
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                const Color(0xFFFAFBFC),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFFE2E8F0),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              _buildTextField(
                label: 'Corrector Name',
                value: _corrections[_selectedCorrectionIndex]['correctorName'] ?? '',
                placeholder: 'e.g. John Doe',
                onChanged: (value) => _updateCorrection('correctorName', value),
              ),
              const SizedBox(height: 20),
              
              _buildTextField(
                label: 'Correction Year',
                value: _corrections[_selectedCorrectionIndex]['correctionYear'] ?? '',
                placeholder: 'e.g. 2023',
                onChanged: (value) => _updateCorrection('correctionYear', value),
              ),
              const SizedBox(height: 20),
              
              _buildTextField(
                label: 'Correction Level',
                value: _corrections[_selectedCorrectionIndex]['correctionLevel'] ?? '',
                placeholder: 'e.g. Minor',
                onChanged: (value) => _updateCorrection('correctionLevel', value),
              ),
              const SizedBox(height: 20),
              
              // Upload Correction Image
              GestureDetector(
                onTap: () {
                  // TODO: Implement image picker
                  _updateCorrection('image', 'placeholder_image.jpg');
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF4A90E2).withOpacity(0.1),
                        const Color(0xFF357ABD).withOpacity(0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFF4A90E2).withOpacity(0.5),
                      width: 2,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF4A90E2).withOpacity(0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.cloud_upload,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Upload Correction Image',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF4A90E2),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCorrectionTab(int index) {
    final isSelected = _selectedCorrectionIndex == index;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCorrectionIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
                  colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
                )
              : null,
          color: isSelected ? null : const Color(0xFFF7F8FC),
          borderRadius: BorderRadius.circular(8),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF4A90E2).withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Text(
          'Correction ${index + 1}',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : const Color(0xFF64748B),
          ),
        ),
      ),
    );
  }

  Widget _buildAddCorrectionButton() {
    return GestureDetector(
      onTap: _addCorrection,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF4A90E2).withOpacity(0.2),
              const Color(0xFF357ABD).withOpacity(0.2),
            ],
          ),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.add,
          color: Color(0xFF4A90E2),
          size: 20,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String value,
    required String placeholder,
    required Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: TextEditingController(text: value),
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: const TextStyle(
              color: Color(0xFFA0A0A0),
              fontSize: 15,
            ),
            filled: true,
            fillColor: const Color(0xFFF7F8FC),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
}
