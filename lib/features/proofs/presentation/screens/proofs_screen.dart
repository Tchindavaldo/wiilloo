import 'package:flutter/material.dart';
import '../widgets/stat_card.dart';
import '../widgets/proof_card.dart';
import '../widgets/create_type_selection_modal.dart';
import 'create_proof_request_screen.dart';
import 'create_proof_screen.dart';
import 'proof_request_detail_screen.dart';

class ProofsScreen extends StatelessWidget {
  const ProofsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await showModalBottomSheet<String>(
            context: context,
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            builder: (context) => const CreateTypeSelectionModal(),
          );
          
          if (result != null && context.mounted) {
            if (result == 'proof') {
              // Navigate to Create Proof screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateProofScreen(),
                ),
              );
            } else if (result == 'correction') {
              // Navigate to Create Correction Request screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateProofRequestScreen(),
                ),
              );
            }
          }
        },
        backgroundColor: const Color(0xFF005A9C),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      body: CustomScrollView(
        slivers: [
          // Sticky Header
          SliverAppBar(
            pinned: true,
            floating: false,
            backgroundColor: Colors.white,
            elevation: 0,
            toolbarHeight: 64,
            automaticallyImplyLeading: false,
            flexibleSpace: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Dashboard',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.search, size: 24),
                          color: const Color(0xFF6B7280),
                          onPressed: () {},
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.favorite, size: 24),
                          color: const Color(0xFF6B7280),
                          onPressed: () {},
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.filter_list, size: 24),
                          color: const Color(0xFF6B7280),
                          onPressed: () {},
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          
          // Stats Cards
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: const [
                  Expanded(
                    child: StatCard(
                      label: 'Active requests',
                      value: '15',
                      change: '5',
                      isIncrease: true,
                      progress: 0.75,
                      textColor: Color(0xFF065F46),
                      bgColor: Color(0xFFD1FAE5),
                      progressBgColor: Color(0xFFA7F3D0),
                      progressColor: Color(0xFF10B981),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: StatCard(
                      label: 'Pending requests',
                      value: '8',
                      change: '2',
                      isIncrease: false,
                      progress: 0.40,
                      textColor: Color(0xFF92400E),
                      bgColor: Color(0xFFFEF3C7),
                      progressBgColor: Color(0xFFFDE68A),
                      progressColor: Color(0xFFF59E0B),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: StatCard(
                      label: 'Overdue requests',
                      value: '3',
                      change: '1',
                      isIncrease: true,
                      progress: 0.15,
                      textColor: Color(0xFF991B1B),
                      bgColor: Color(0xFFFEE2E2),
                      progressBgColor: Color(0xFFFECACA),
                      progressColor: Color(0xFFEF4444),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
          
          // Proof Cards Grid
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.25,
              ),
              delegate: SliverChildListDelegate([
                ProofCard(
                  title: 'Annual Report 2024',
                  type: 'Text Correction',
                  priority: 'High Priority',
                  priorityColor: const Color(0xFFEF4444),
                  estimate: '2h',
                  comments: 8,
                  deadline: '1 day left',
                  deadlineColor: const Color(0xFFEF4444),
                  hasImage: true,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProofRequestDetailScreen(
                          requestId: '#1024',
                          title: 'Annual Report 2024',
                          description: 'Text correction needed for the annual report 2024.',
                          status: 'In Progress',
                          submittedDate: 'Dec 22, 2023',
                          assignedAgent: 'Mark Johnson',
                        ),
                      ),
                    );
                  },
                ),
                ProofCard(
                  title: 'Marketing Brochure Q3',
                  type: 'Image Replacement',
                  priority: 'Medium Priority',
                  priorityColor: const Color(0xFFF59E0B),
                  estimate: '4h',
                  comments: 3,
                  deadline: '3 days left',
                  deadlineColor: const Color(0xFF10B981),
                  hasImage: false,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProofRequestDetailScreen(
                          requestId: '#1025',
                          title: 'Marketing Brochure Q3',
                          description: 'Image replacement needed for Q3 marketing brochure.',
                          status: 'New',
                          submittedDate: 'Dec 23, 2023',
                          assignedAgent: 'Sarah Day',
                        ),
                      ),
                    );
                  },
                ),
                const ProofCard(
                  title: 'Social Media Graphics',
                  type: 'Typo Fix',
                  priority: 'Low Priority',
                  priorityColor: Color(0xFF6B7280),
                  estimate: '30m',
                  comments: 1,
                  deadline: '12 days left',
                  deadlineColor: Color(0xFF6B7280),
                  hasImage: false,
                ),
                const ProofCard(
                  title: 'Website UX Mockups',
                  type: 'Layout Adjustment',
                  priority: 'High Priority',
                  priorityColor: Color(0xFFEF4444),
                  estimate: '8h',
                  comments: 15,
                  deadline: '8 days left',
                  deadlineColor: Color(0xFFF59E0B),
                  hasImage: true,
                ),
                const ProofCard(
                  title: 'Product Catalog',
                  type: 'Layout Review',
                  priority: 'High Priority',
                  priorityColor: Color(0xFFEF4444),
                  estimate: '6h',
                  comments: 12,
                  deadline: '2 days left',
                  deadlineColor: Color(0xFFEF4444),
                  hasImage: true,
                ),
                const ProofCard(
                  title: 'Website Banner',
                  type: 'Color Correction',
                  priority: 'Medium Priority',
                  priorityColor: Color(0xFFF59E0B),
                  estimate: '1h',
                  comments: 5,
                  deadline: '3 days left',
                  deadlineColor: Color(0xFFF59E0B),
                  hasImage: true,
                ),
                const ProofCard(
                  title: 'Email Newsletter',
                  type: 'Text Correction',
                  priority: 'Low Priority',
                  priorityColor: Color(0xFF6B7280),
                  estimate: '45m',
                  comments: 2,
                  deadline: '7 days left',
                  deadlineColor: Color(0xFF6B7280),
                  hasImage: false,
                ),
                const ProofCard(
                  title: 'Presentation Slides',
                  type: 'Content Review',
                  priority: 'High Priority',
                  priorityColor: Color(0xFFEF4444),
                  estimate: '3h',
                  comments: 9,
                  deadline: '1 day left',
                  deadlineColor: Color(0xFFEF4444),
                  hasImage: true,
                ),
                const ProofCard(
                  title: 'Infographic Design',
                  type: 'Layout Fix',
                  priority: 'Medium Priority',
                  priorityColor: Color(0xFFF59E0B),
                  estimate: '2h',
                  comments: 4,
                  deadline: '4 days left',
                  deadlineColor: Color(0xFFF59E0B),
                  hasImage: true,
                ),
              ]),
            ),
          ),
          
          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
    );
  }
}
