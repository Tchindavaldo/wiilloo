import 'package:flutter/material.dart';

class ProofStep3UploadImages extends StatefulWidget {
  final Map<String, dynamic> formData;
  final Function(String, dynamic) onDataChanged;

  const ProofStep3UploadImages({
    Key? key,
    required this.formData,
    required this.onDataChanged,
  }) : super(key: key);

  @override
  State<ProofStep3UploadImages> createState() => _ProofStep3UploadImagesState();
}

class _ProofStep3UploadImagesState extends State<ProofStep3UploadImages> {
  List<String> _uploadedImages = [];

  @override
  void initState() {
    super.initState();
    _uploadedImages = List<String>.from(widget.formData['proofImages'] ?? []);
  }

  void _addImage() {
    // TODO: Implement image picker
    setState(() {
      _uploadedImages.add('https://via.placeholder.com/300');
    });
    widget.onDataChanged('proofImages', _uploadedImages);
  }

  void _removeImage(int index) {
    setState(() {
      _uploadedImages.removeAt(index);
    });
    widget.onDataChanged('proofImages', _uploadedImages);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Proof Images',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1E293B),
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Upload images of your proof document',
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 24),
        
        // Upload Area
        GestureDetector(
          onTap: _addImage,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 48),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF4A90E2).withOpacity(0.08),
                  const Color(0xFF357ABD).withOpacity(0.12),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
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
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF4A90E2).withOpacity(0.3),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.upload_file,
                    color: Colors.white,
                    size: 36,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
                    ),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF4A90E2).withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Text(
                    'Upload Proof Image',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'or drag & drop',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFFA0A0A0),
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Supports: JPG, PNG, PDF',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFFA0A0A0),
                  ),
                ),
              ],
            ),
          ),
        ),
        
        if (_uploadedImages.isNotEmpty) ...[
          const SizedBox(height: 32),
          
          // Uploaded Images Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1,
            ),
            itemCount: _uploadedImages.length,
            itemBuilder: (context, index) {
              return _buildImageCard(index);
            },
          ),
        ],
      ],
    );
  }

  Widget _buildImageCard(int index) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFFE2E8F0),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              _uploadedImages[index],
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: const Color(0xFFF7F8FC),
                  child: const Center(
                    child: Icon(
                      Icons.image,
                      color: Color(0xFF94A3B8),
                      size: 32,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        
        // Remove button
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: () => _removeImage(index),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
