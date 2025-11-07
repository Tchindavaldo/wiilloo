import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/chat_message.dart';

class AiChatScreen extends StatelessWidget {
  const AiChatScreen({Key? key}) : super(key: key);

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
        body: Column(
          children: [
            // Sticky Header
            Container(
              color: Colors.white,
              child: SafeArea(
                bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Wilia',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.history, size: 24),
                          color: const Color(0xFF6B7280),
                          onPressed: () {},
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                        const SizedBox(width: 16),
                        IconButton(
                          icon: const Icon(Icons.edit, size: 24),
                          color: const Color(0xFF1173d4),
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
          
          // Chat Messages
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ChatMessage(
                  isAi: true,
                  message: "Of course. I've analyzed your document. Here are my suggestions organized by category:",
                  sections: [
                    MessageSection(
                      title: 'Grammar Fixes',
                      items: [
                        '"Effect" should be "affect" in paragraph 2.',
                        'Corrected a subject-verb agreement error in the last sentence.',
                      ],
                    ),
                    MessageSection(
                      title: 'Punctuation Suggestions',
                      items: [
                        'Added a comma after "Furthermore" in paragraph 3.',
                        'Replaced a semicolon with a period for clarity.',
                      ],
                    ),
                    MessageSection(
                      title: 'Style Improvements',
                      items: [
                        'Replaced "a lot of" with "numerous" for a more formal tone.',
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const ChatMessage(
                  isAi: false,
                  message: 'Great, please proceed.',
                ),
                const SizedBox(height: 24),
                ChatMessage(
                  isAi: true,
                  message: "I've made all the suggested changes. Here's a summary:",
                  sections: [
                    MessageSection(
                      title: 'Grammar Corrections',
                      items: [
                        'Fixed 3 subject-verb agreement errors',
                        'Corrected word choice in 2 instances',
                      ],
                    ),
                    MessageSection(
                      title: 'Style Enhancements',
                      items: [
                        'Improved formal tone throughout',
                        'Enhanced clarity in complex sentences',
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const ChatMessage(
                  isAi: false,
                  message: 'Perfect! Can you also check the formatting?',
                ),
                const SizedBox(height: 24),
                ChatMessage(
                  isAi: true,
                  message: "Absolutely! I've reviewed the formatting:",
                  sections: [
                    MessageSection(
                      title: 'Formatting Issues Found',
                      items: [
                        'Inconsistent heading styles in sections 2-4',
                        'Line spacing needs adjustment in paragraph 3',
                        'Bullet points formatting could be improved',
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
          
          // Input Area
          SafeArea(
            top: false,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(44),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.upload_file, color: Color(0xFF6B7280)),
                      onPressed: () {},
                    ),
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Ask Wilia...',
                          hintStyle: TextStyle(color: Color(0xFF6B7280)),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 8),
                        ),
                        maxLines: null,
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1173d4),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(Icons.arrow_upward, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }
}
