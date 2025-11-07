import 'package:flutter/material.dart';

class ProofCard extends StatelessWidget {
  final String title;
  final String type;
  final String priority;
  final Color priorityColor;
  final String estimate;
  final int comments;
  final String deadline;
  final Color deadlineColor;
  final bool hasImage;

  const ProofCard({
    Key? key,
    required this.title,
    required this.type,
    required this.priority,
    required this.priorityColor,
    required this.estimate,
    required this.comments,
    required this.deadline,
    required this.deadlineColor,
    required this.hasImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top row: Priority/Estimate + Image
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Priority and Estimate
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        priority,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: priorityColor,
                        ),
                      ),
                      Text(
                        'Est. $estimate',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                  // Image or placeholder
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: hasImage ? const Color(0xFFF3F4F6) : const Color(0xFFF9FAFB),
                      borderRadius: BorderRadius.circular(6),
                      border: hasImage
                          ? null
                          : Border.all(
                              color: const Color(0xFFD1D5DB),
                              width: 1,
                            ),
                    ),
                    child: Center(
                      child: hasImage
                          ? const Icon(Icons.image, size: 20, color: Color(0xFF9CA3AF))
                          : const Icon(Icons.attach_file, size: 20, color: Color(0xFF9CA3AF)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              // Title
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF111827),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              // Type
              Text(
                type,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF6B7280),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          const SizedBox(height: 7),
          // Bottom row: Comments + Deadline
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Comments
              Row(
                children: [
                  const Icon(Icons.comment, size: 16, color: Color(0xFF6B7280)),
                  const SizedBox(width: 4),
                  Text(
                    comments.toString(),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
              // Deadline badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: deadlineColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(
                  deadline,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: deadlineColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
