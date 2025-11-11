import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final bool isAi;
  final String message;
  final List<MessageSection>? sections;
  final List<String>? attachedFiles;

  const ChatMessage({
    Key? key,
    required this.isAi,
    required this.message,
    this.sections,
    this.attachedFiles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isAi) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // AI Header
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF005A9C),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Wilia\'s Analysis',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1F2937),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // AI Message
          Text(
            message,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFF1F2937),
              height: 1.5,
            ),
          ),
          // Sections
          if (sections != null && sections!.isNotEmpty) ...[
            const SizedBox(height: 16),
            ...sections!.map((section) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    section.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...section.items.map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 8, left: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '• ',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF6B7280),
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            )),
          ],
        ],
      );
    } else {
      // User Message - rounded-2xl (16px)
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(33),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Response',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 8),
            // Attached files
            if (attachedFiles != null && attachedFiles!.isNotEmpty) ...[
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: attachedFiles!.map((fileName) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFF1173d4).withOpacity(0.3)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.insert_drive_file,
                          size: 14,
                          color: Color(0xFF1173d4),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          fileName,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF1173d4),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 8),
            ],
            Text(
              message,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFF1F2937),
                height: 1.5,
              ),
            ),
          ],
        ),
      );
    }
  }
}

class MessageSection {
  final String title;
  final List<String> items;

  MessageSection({
    required this.title,
    required this.items,
  });
}
