import 'package:flutter/material.dart';

/// A horizontal scrollable section with infinite scroll capability
/// Handles loading more items when reaching the end
class HorizontalScrollSection extends StatefulWidget {
  final String groupId;
  final String title;
  final List<Widget> children;
  final bool hasMore;
  final bool isLoading;
  final VoidCallback onLoadMore;
  final VoidCallback? onSeeAll;
  final double itemSpacing;
  final EdgeInsets? padding;

  const HorizontalScrollSection({
    Key? key,
    required this.groupId,
    required this.title,
    required this.children,
    required this.hasMore,
    required this.isLoading,
    required this.onLoadMore,
    this.onSeeAll,
    this.itemSpacing = 16.0,
    this.padding,
  }) : super(key: key);

  @override
  State<HorizontalScrollSection> createState() => _HorizontalScrollSectionState();
}

class _HorizontalScrollSectionState extends State<HorizontalScrollSection> {
  late ScrollController _scrollController;
  bool _isLoadingTriggered = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    // Don't trigger if already loading or no more items
    if (widget.isLoading || !widget.hasMore) return;

    // Calculate if we're near the end (90% scrolled)
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    final threshold = maxScroll * 0.9;

    // Check if we've reached the threshold
    final isNearEnd = currentScroll >= threshold && maxScroll > 0;

    // Check if we've scrolled back (below 80%)
    final hasScrolledBack = currentScroll < maxScroll * 0.8;

    if (isNearEnd && !_isLoadingTriggered) {
      // Trigger load more
      _isLoadingTriggered = true;
      widget.onLoadMore();
    } else if (hasScrolledBack) {
      // Reset the trigger when user scrolls back
      _isLoadingTriggered = false;
    }
  }

  @override
  void didUpdateWidget(HorizontalScrollSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // Reset loading trigger when loading completes
    if (oldWidget.isLoading && !widget.isLoading) {
      _isLoadingTriggered = false;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: widget.padding ?? const EdgeInsets.fromLTRB(20, 24, 20, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              if (widget.onSeeAll != null)
                TextButton(
                  onPressed: widget.onSeeAll,
                  child: const Text(
                    'Voir tout',
                    style: TextStyle(
                      color: Color(0xFF3B82F6),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ),
        
        // Horizontal scrollable list
        SizedBox(
          height: _calculateHeight(),
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: widget.children.length + (widget.hasMore || widget.isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              // Show children
              if (index < widget.children.length) {
                return Padding(
                  padding: EdgeInsets.only(
                    right: index < widget.children.length - 1 || widget.hasMore || widget.isLoading
                        ? widget.itemSpacing
                        : 0,
                  ),
                  child: widget.children[index],
                );
              }
              
              // Show loader at the end if loading or has more
              if (widget.isLoading) {
                return _buildLoader();
              } else if (widget.hasMore) {
                // Show a placeholder that will trigger loading
                return const SizedBox(width: 20);
              }
              
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }

  double _calculateHeight() {
    // Return a reasonable default height based on content
    // This can be customized based on the widget type
    return 280; // Default height for cards
  }

  Widget _buildLoader() {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 32,
              height: 32,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Chargement...',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
