import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  String _selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Color(0xFF1E3A8A),
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
        slivers: [
          // Sticky Header
          SliverAppBar(
            pinned: true,
            floating: false,
            backgroundColor: Colors.white,
            elevation: 0,
            toolbarHeight: 120,
            automaticallyImplyLeading: false,
            flexibleSpace: SafeArea(
              child: Column(
                children: [
                  // Title and Icon
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Alerts & Updates',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.done_all, size: 24),
                          color: const Color(0xFF6B7280),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  // Filter Chips
                  Container(
                    height: 44,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildFilterChip('All'),
                        const SizedBox(width: 8),
                        _buildFilterChip('Unread'),
                        const SizedBox(width: 8),
                        _buildFilterChip('Mentions'),
                        const SizedBox(width: 8),
                        _buildFilterChip('Updates'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Notifications List
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildNotificationItem(
                  icon: Icons.check_circle,
                  iconColor: const Color(0xFF10B981),
                  title: 'Document \'Contract_2024.pdf\' was approved',
                  subtitle: 'Status Change',
                  time: '5m',
                  isUnread: true,
                ),
                const SizedBox(height: 12),
                _buildNotificationItem(
                  icon: Icons.comment,
                  iconColor: const Color(0xFF3B82F6),
                  title: 'New comment on \'Project_Proposal.docx\'',
                  subtitle: 'Sarah mentioned you',
                  time: '1h',
                  isUnread: true,
                ),
                const SizedBox(height: 12),
                _buildNotificationItem(
                  icon: Icons.task_alt,
                  iconColor: const Color(0xFF10B981),
                  title: '\'Brochure_V3.pdf\' was updated to \'Approved\'',
                  subtitle: 'Status Change',
                  time: '2h',
                ),
                const SizedBox(height: 12),
                _buildNotificationItem(
                  icon: Icons.hourglass_top,
                  iconColor: const Color(0xFFF59E0B),
                  title: 'Deadline approaching for \'Annual_Report.pdf\'',
                  subtitle: 'Due in 2 days',
                  time: '1d',
                  isUnread: true,
                  isWarning: true,
                ),
                const SizedBox(height: 12),
                _buildNotificationItem(
                  icon: Icons.person_add,
                  iconColor: const Color(0xFF3B82F6),
                  title: 'You\'ve been added to review \'Q3_Marketing_Plan.docx\'',
                  subtitle: 'New Assignment',
                  time: '3d',
                ),
                const SizedBox(height: 12),
                _buildNotificationItem(
                  icon: Icons.upload_file,
                  iconColor: const Color(0xFF8B5CF6),
                  title: 'New version uploaded: \'Budget_2024.xlsx\'',
                  subtitle: 'Document Update',
                  time: '4d',
                ),
                const SizedBox(height: 12),
                _buildNotificationItem(
                  icon: Icons.thumb_up,
                  iconColor: const Color(0xFF10B981),
                  title: 'Your document \'Proposal_Final.pdf\' was approved',
                  subtitle: 'Approval',
                  time: '5d',
                ),
                const SizedBox(height: 12),
                _buildNotificationItem(
                  icon: Icons.share,
                  iconColor: const Color(0xFF3B82F6),
                  title: 'Document shared with you: \'Team_Guidelines.docx\'',
                  subtitle: 'Shared',
                  time: '6d',
                ),
                const SizedBox(height: 12),
                _buildNotificationItem(
                  icon: Icons.edit_note,
                  iconColor: const Color(0xFFF59E0B),
                  title: 'Changes requested on \'Report_Q4.pdf\'',
                  subtitle: 'Review Required',
                  time: '1w',
                ),
                const SizedBox(height: 80),
              ]),
            ),
          ),
        ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedFilter == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = label;
        });
      },
      child: Container(
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1173d4) : const Color(0xFFE5E7EB),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.white : const Color(0xFF1F2937),
              height: 1.5,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String time,
    bool isUnread = false,
    bool isWarning = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isWarning ? const Color(0xFFFEF3C7) : const Color(0xFFE5E7EB),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1F2937),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6B7280),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                time,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF9CA3AF),
                ),
              ),
              if (isUnread) ...[
                const SizedBox(height: 4),
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFF3B82F6),
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
