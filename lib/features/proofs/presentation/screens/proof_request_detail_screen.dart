import 'package:flutter/material.dart';

class ProofRequestDetailScreen extends StatelessWidget {
  final String requestId;
  final String title;
  final String description;
  final String status;
  final String submittedDate;
  final String assignedAgent;
  final List<Map<String, dynamic>> attachedFiles;
  final List<Map<String, dynamic>> activities;

  const ProofRequestDetailScreen({
    Key? key,
    this.requestId = '#1024',
    this.title = 'Update Website Homepage Banner',
    this.description = 'Please update the main hero banner on the homepage with the new "Summer Sale" creative.',
    this.status = 'New',
    this.submittedDate = 'Dec 22, 2023',
    this.assignedAgent = 'Mark Johnson',
    this.attachedFiles = const [],
    this.activities = const [],
  }) : super(key: key);

  Color _getStatusColor() {
    switch (status.toLowerCase()) {
      case 'new':
        return const Color(0xFF50E3C2);
      case 'in progress':
        return const Color(0xFFF5A623);
      case 'completed':
        return const Color(0xFF10B981);
      case 'rejected':
        return const Color(0xFFEF4444);
      default:
        return const Color(0xFF9B9B9B);
    }
  }

  IconData _getFileIcon(String fileName) {
    final extension = fileName.split('.').last.toLowerCase();
    switch (extension) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'jpg':
      case 'jpeg':
      case 'png':
        return Icons.image;
      case 'doc':
      case 'docx':
        return Icons.description;
      default:
        return Icons.insert_drive_file;
    }
  }

  Color _getFileIconColor(String fileName) {
    final extension = fileName.split('.').last.toLowerCase();
    switch (extension) {
      case 'pdf':
        return const Color(0xFFEF4444);
      case 'jpg':
      case 'jpeg':
      case 'png':
        return const Color(0xFF3B82F6);
      case 'doc':
      case 'docx':
        return const Color(0xFF1173D4);
      default:
        return const Color(0xFF64748B);
    }
  }

  Color _getFileIconBgColor(String fileName) {
    final extension = fileName.split('.').last.toLowerCase();
    switch (extension) {
      case 'pdf':
        return const Color(0xFFFEE2E2);
      case 'jpg':
      case 'jpeg':
      case 'png':
        return const Color(0xFFDBEAFE);
      case 'doc':
      case 'docx':
        return const Color(0xFFE0F2FE);
      default:
        return const Color(0xFFF1F5F9);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF1E293B), size: 20),
            onPressed: () => Navigator.pop(context),
            padding: EdgeInsets.zero,
          ),
        ),
        title: const Text(
          'Request Details',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1E293B),
            letterSpacing: -0.3,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(Icons.more_vert, color: Color(0xFF1E293B), size: 20),
              onPressed: () {
                // TODO: Show options menu
              },
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Main Request Card
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Container(
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
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF1173D4).withOpacity(0.08),
                            blurRadius: 20,
                            offset: const Offset(0, 4),
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title with icon
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      const Color(0xFF1173D4),
                                      const Color(0xFF0EA5E9),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF1173D4).withOpacity(0.3),
                                      blurRadius: 12,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.description,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  title,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF1E293B),
                                    height: 1.3,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          
                          // Description
                          Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8FAFC),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xFFE2E8F0),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              description,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Color(0xFF64748B),
                                height: 1.6,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          
                          // Divider with gradient
                          Container(
                            height: 1,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  const Color(0xFFE2E8F0),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          
                          // Info Grid with enhanced styling
                          Column(
                            children: [
                              _buildInfoRow(
                                Icons.tag,
                                'Request ID',
                                requestId,
                              ),
                              const SizedBox(height: 12),
                              _buildInfoRow(
                                Icons.calendar_today,
                                'Submitted',
                                submittedDate,
                              ),
                              const SizedBox(height: 12),
                              _buildInfoRow(
                                Icons.person,
                                'Assigned Agent',
                                assignedAgent,
                              ),
                              const SizedBox(height: 12),
                              _buildStatusRow(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  // Attached Files Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    const Color(0xFF10B981),
                                    const Color(0xFF059669),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.attach_file,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Attached Files',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1E293B),
                                letterSpacing: -0.3,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ...List.generate(
                          attachedFiles.isEmpty ? 2 : attachedFiles.length,
                          (index) {
                            final file = attachedFiles.isEmpty
                                ? {
                                    'name': index == 0
                                        ? 'homepage_banner_v1.pdf'
                                        : 'Summer_Sale_Creative.jpg',
                                    'size': index == 0 ? '1.2 MB' : '856 KB',
                                  }
                                : attachedFiles[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: _buildFileCard(file),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Activity Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    const Color(0xFFF59E0B),
                                    const Color(0xFFD97706),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.history,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Activity Timeline',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1E293B),
                                letterSpacing: -0.3,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(18),
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
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFF59E0B).withOpacity(0.08),
                                blurRadius: 16,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              _buildActivityItem(
                                Icons.person_add,
                                'Mark Johnson',
                                'was assigned to this request.',
                                '2 min ago',
                                showDivider: true,
                              ),
                              _buildActivityItem(
                                Icons.article,
                                'Sarah Day',
                                'created this request.',
                                '5 min ago',
                                showDivider: false,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Bottom Action Buttons with enhanced design
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: const Color(0xFFE2E8F0),
                  width: 1,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  // Add Comment Button
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF1173D4).withOpacity(0.15),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: OutlinedButton.icon(
                        onPressed: () {
                          // TODO: Add comment functionality
                        },
                        icon: const Icon(Icons.add_comment, size: 20),
                        label: const Text(
                          'Comment',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          side: const BorderSide(color: Color(0xFF1173D4), width: 2),
                          foregroundColor: const Color(0xFF1173D4),
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  
                  // Mark as Reviewed Button
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF1173D4),
                            const Color(0xFF0EA5E9),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF1173D4).withOpacity(0.4),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // TODO: Mark as reviewed functionality
                        },
                        icon: const Icon(Icons.check_circle, size: 20),
                        label: const Text(
                          'Reviewed',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.white,
                          shadowColor: Colors.transparent,
                          elevation: 0,
                        ),
                      ),
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

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Icon(icon, size: 16, color: const Color(0xFF617589)),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF617589),
                ),
              ),
            ],
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF111418),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusRow() {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Icon(Icons.hourglass_top, size: 16, color: const Color(0xFF617589)),
              const SizedBox(width: 8),
              const Text(
                'Status',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF617589),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: _getStatusColor(),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              status,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: _getStatusColor(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFileCard(Map<String, dynamic> file) {
    final fileName = file['name'] ?? 'Unknown';
    final fileSize = file['size'] ?? '0 KB';
    
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            const Color(0xFFFAFBFC),
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: _getFileIconColor(fileName).withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // File Icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _getFileIconBgColor(fileName),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              _getFileIcon(fileName),
              color: _getFileIconColor(fileName),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          
          // File Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fileName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111418),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  fileSize,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF617589),
                  ),
                ),
              ],
            ),
          ),
          
          // Action Buttons
          IconButton(
            icon: const Icon(Icons.download, size: 20),
            color: const Color(0xFF617589),
            onPressed: () {
              // TODO: Download file
            },
          ),
          IconButton(
            icon: const Icon(Icons.visibility, size: 20),
            color: const Color(0xFF617589),
            onPressed: () {
              // TODO: Preview file
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(
    IconData icon,
    String actor,
    String action,
    String time, {
    required bool showDivider,
  }) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 20,
                color: const Color(0xFF617589),
              ),
            ),
            const SizedBox(width: 12),
            
            // Activity Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF111418),
                      ),
                      children: [
                        TextSpan(
                          text: actor,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        TextSpan(text: ' $action'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    time,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF9B9B9B),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        if (showDivider) ...[
          const SizedBox(height: 16),
          const Divider(color: Color(0xFFE5E7EB)),
          const SizedBox(height: 16),
        ],
      ],
    );
  }
}
