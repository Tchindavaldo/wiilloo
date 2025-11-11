import 'package:flutter/material.dart';

class Step3ReviewConfirm extends StatelessWidget {
  final Map<String, dynamic> formData;

  const Step3ReviewConfirm({
    Key? key,
    required this.formData,
  }) : super(key: key);

  String _getQualityLabel(String quality) {
    switch (quality) {
      case 'minimal':
        return 'Qualité Minimale (Gratuit)';
      case 'standard':
        return 'Qualité Standard (2,500 CFA)';
      case 'premium':
        return 'Qualité Premium (5,000 CFA)';
      default:
        return quality;
    }
  }

  IconData _getFileIcon(String type) {
    switch (type.toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'doc':
      case 'docx':
        return Icons.description;
      case 'jpg':
      case 'jpeg':
      case 'png':
        return Icons.image;
      default:
        return Icons.insert_drive_file;
    }
  }

  @override
  Widget build(BuildContext context) {
    final files = formData['files'] as List<Map<String, dynamic>>? ?? [];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Request Details Card with modern design
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFFE2E8F0),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow('Request Title', formData['title'] ?? 'N/A'),
              const SizedBox(height: 16),
              const Divider(height: 1, color: Color(0xFFDBE0E6)),
              const SizedBox(height: 16),
              _buildDetailRow('Detailed Description', formData['description'] ?? 'N/A'),
              const SizedBox(height: 16),
              const Divider(height: 1, color: Color(0xFFDBE0E6)),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildDetailRow('Due Date', formData['dueDate'] ?? 'N/A'),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildDetailRow('Priority', formData['priority'] ?? 'N/A'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(height: 1, color: Color(0xFFDBE0E6)),
              const SizedBox(height: 16),
              _buildDetailRow('Quality Level', _getQualityLabel(formData['quality'] ?? 'minimal')),
            ],
          ),
        ),
        
        if (files.isNotEmpty) ...[
          const SizedBox(height: 24),
          Text(
            'Attached Files (${files.length})',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 12),
          
          // Files List
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: files.length,
            itemBuilder: (context, index) {
              final file = files[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFDBE0E6)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F2F4),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Icon(
                        _getFileIcon(file['type']),
                        color: const Color(0xFF333333),
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            file['name'],
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF333333),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            file['size'],
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF617589),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
        
        const SizedBox(height: 24),
        
        // Info Box with modern design
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFFEFF6FF),
                const Color(0xFFDBEAFE),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFF93C5FD).withOpacity(0.5),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF1173D4).withOpacity(0.1),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF1173D4),
                      const Color(0xFF0EA5E9),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF1173D4).withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.info_outline,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Review Your Request',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1E40AF),
                        letterSpacing: -0.2,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Please review all the information carefully before proceeding to payment.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF3B82F6),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: 4,
              decoration: const BoxDecoration(
                color: Color(0xFF1173D4),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF64748B),
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1E293B),
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
