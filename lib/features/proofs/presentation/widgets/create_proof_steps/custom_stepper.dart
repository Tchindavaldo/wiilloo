import 'package:flutter/material.dart';

class CustomStepper extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final List<String> stepLabels;

  const CustomStepper({
    Key? key,
    required this.currentStep,
    required this.totalSteps,
    required this.stepLabels,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            const Color(0xFFF8FAFC),
          ],
        ),
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFFE2E8F0),
            width: 1.5,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: List.generate(totalSteps * 2 - 1, (index) {
          if (index.isEven) {
            // Step indicator
            final stepIndex = index ~/ 2;
            final isCompleted = stepIndex < currentStep;
            final isCurrent = stepIndex == currentStep;
            
            return Expanded(
              child: Column(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: isCurrent ? 32 : 28,
                    height: isCurrent ? 32 : 28,
                    decoration: BoxDecoration(
                      gradient: isCompleted || isCurrent
                          ? LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                const Color(0xFF1173D4),
                                const Color(0xFF0EA5E9),
                              ],
                            )
                          : null,
                      color: isCompleted || isCurrent
                          ? null
                          : Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isCompleted || isCurrent
                            ? Colors.transparent
                            : const Color(0xFFCBD5E1),
                        width: 2,
                      ),
                      boxShadow: isCompleted || isCurrent ? [
                        BoxShadow(
                          color: const Color(0xFF1173D4).withOpacity(0.3),
                          blurRadius: isCurrent ? 12 : 8,
                          offset: const Offset(0, 2),
                        ),
                      ] : null,
                    ),
                    child: Center(
                      child: isCompleted
                          ? const Icon(
                              Icons.check_rounded,
                              size: 16,
                              color: Colors.white,
                            )
                          : Text(
                              '${stepIndex + 1}',
                              style: TextStyle(
                                fontSize: isCurrent ? 14 : 12,
                                fontWeight: FontWeight.bold,
                                color: isCurrent
                                    ? Colors.white
                                    : const Color(0xFF64748B),
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    stepLabels[stepIndex],
                    style: TextStyle(
                      fontSize: isCurrent ? 11 : 10,
                      fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w500,
                      color: isCurrent
                          ? const Color(0xFF1173D4)
                          : isCompleted
                              ? const Color(0xFF64748B)
                              : const Color(0xFF94A3B8),
                      letterSpacing: 0.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          } else {
            // Connector line with gradient
            final stepIndex = index ~/ 2;
            final isCompleted = stepIndex < currentStep;
            
            return Expanded(
              child: Container(
                height: 3,
                margin: const EdgeInsets.only(bottom: 22),
                decoration: BoxDecoration(
                  gradient: isCompleted
                      ? LinearGradient(
                          colors: [
                            const Color(0xFF1173D4),
                            const Color(0xFF0EA5E9),
                          ],
                        )
                      : null,
                  color: isCompleted ? null : const Color(0xFFE2E8F0),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            );
          }
        }),
      ),
    );
  }
}
