import 'package:flutter/material.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/models/project_model.dart';

class ProjectMockupGraphic extends StatelessWidget {
  final ProjectModel project;
  final bool isHero;

  const ProjectMockupGraphic({
    super.key,
    required this.project,
    this.isHero = false,
  });

  @override
  Widget build(BuildContext context) {
    final id = project.id.toLowerCase();
    final title = project.title.toLowerCase();

    if (id.contains('ndy') || title.contains('ndy')) {
      return _buildChatMockup(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E1B4B), Color(0xFF0F2428), Color(0xFF064E3B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        accentColor: WebColors.greenBright,
        secondaryColor: WebColors.cyanAccent,
        icon: Icons.chat_bubble_outline_rounded,
        tag: 'REAL-TIME MESSAGING',
      );
    } else if (id.contains('turame') || title.contains('turame')) {
      return _buildHealthcareMockup(
        gradient: const LinearGradient(
          colors: [Color(0xFF042F2E), Color(0xFF0D3D3A), Color(0xFF08272C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        accentColor: WebColors.cyanAccent,
        secondaryColor: WebColors.greenBright,
        icon: Icons.medical_services_outlined,
        tag: 'HEALTHCARE & TELEHEALTH',
      );
    } else if (id.contains('inhale') || title.contains('pilates')) {
      return _buildFitnessMockup(
        gradient: const LinearGradient(
          colors: [Color(0xFF2A1B0E), Color(0xFF1B231D), Color(0xFF063327)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        accentColor: WebColors.warning,
        secondaryColor: WebColors.greenBright,
        icon: Icons.fitness_center_rounded,
        tag: 'STUDIO BOOKING & PAYMENTS',
      );
    } else if (id.contains('mechat') || title.contains('mechat')) {
      return _buildChatMockup(
        gradient: const LinearGradient(
          colors: [Color(0xFF111827), Color(0xFF1A2744), Color(0xFF064E3B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        accentColor: WebColors.greenBright,
        secondaryColor: const Color(0xFF60A5FA),
        icon: Icons.forum_rounded,
        tag: 'CROSS-PLATFORM CHAT',
      );
    } else if (id.contains('real') || title.contains('estate')) {
      return _buildRealEstateMockup(
        gradient: const LinearGradient(
          colors: [Color(0xFF0F172A), Color(0xFF132738), Color(0xFF064E3B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        accentColor: const Color(0xFF38BDF8),
        secondaryColor: WebColors.greenBright,
        icon: Icons.apartment_rounded,
        tag: 'PROPERTY LISTINGS',
      );
    }

    // Generic modern fallback
    return _buildGenericMockup();
  }

  Widget _buildChatMockup({
    required LinearGradient gradient,
    required Color accentColor,
    required Color secondaryColor,
    required IconData icon,
    required String tag,
  }) {
    return Container(
      decoration: BoxDecoration(gradient: gradient),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background ambient circular glow
          Positioned(
            right: -30,
            top: -20,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [accentColor.withValues(alpha: 0.25), Colors.transparent],
                ),
              ),
            ),
          ),
          Positioned(
            left: -20,
            bottom: -20,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [secondaryColor.withValues(alpha: 0.2), Colors.transparent],
                ),
              ),
            ),
          ),

          // Central stylized device silhouette / card showcase
          Center(
            child: Container(
              width: isHero ? 340 : 210,
              padding: EdgeInsets.all(isHero ? 20 : 12),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.55),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.12),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Mockup Header bar
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: accentColor.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(icon, color: accentColor, size: isHero ? 18 : 14),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              project.title,
                              style: TextStyle(
                                fontFamily: 'SpaceGrotesk',
                                fontSize: isHero ? 15 : 12,
                                fontWeight: FontWeight.w700,
                                color: WebColors.textPrimary,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'Active now · End-to-End',
                              style: TextStyle(
                                fontFamily: 'SpaceGrotesk',
                                fontSize: isHero ? 11 : 9,
                                color: WebColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: accentColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: isHero ? 14 : 10),

                  // Chat bubble 1 (Received)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: isHero ? 12 : 8, vertical: isHero ? 8 : 5),
                      decoration: BoxDecoration(
                        color: WebColors.bgCardHover,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
                      ),
                      child: Text(
                        'Hey! Can we review the new build?',
                        style: TextStyle(
                          fontFamily: 'SpaceGrotesk',
                          fontSize: isHero ? 12 : 9.5,
                          color: WebColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: isHero ? 8 : 6),

                  // Chat bubble 2 (Sent - Glowing Mint)
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: isHero ? 12 : 8, vertical: isHero ? 8 : 5),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [WebColors.greenDark, WebColors.greenPrimary.withValues(alpha: 0.8)],
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Yes, 60fps Flutter build is live! 🚀',
                            style: TextStyle(
                              fontFamily: 'SpaceGrotesk',
                              fontSize: isHero ? 12 : 9.5,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(Icons.done_all_rounded, size: isHero ? 14 : 11, color: WebColors.greenBright),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Tag Pill Badge at top-right
          Positioned(
            top: 14,
            right: 14,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: accentColor.withValues(alpha: 0.4)),
              ),
              child: Text(
                tag,
                style: TextStyle(
                  fontFamily: 'SpaceGrotesk',
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  color: accentColor,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthcareMockup({
    required LinearGradient gradient,
    required Color accentColor,
    required Color secondaryColor,
    required IconData icon,
    required String tag,
  }) {
    return Container(
      decoration: BoxDecoration(gradient: gradient),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            right: -20,
            bottom: -20,
            child: Container(
              width: 170,
              height: 170,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [accentColor.withValues(alpha: 0.2), Colors.transparent],
                ),
              ),
            ),
          ),

          // Telehealth / Caregiver dashboard preview card
          Center(
            child: Container(
              width: isHero ? 340 : 210,
              padding: EdgeInsets.all(isHero ? 20 : 12),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: accentColor.withValues(alpha: 0.3)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.video_call_rounded, color: secondaryColor, size: isHero ? 20 : 16),
                          const SizedBox(width: 6),
                          Text(
                            'ZegoCloud Telehealth',
                            style: TextStyle(
                              fontFamily: 'SpaceGrotesk',
                              fontSize: isHero ? 13 : 10.5,
                              fontWeight: FontWeight.w700,
                              color: WebColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: WebColors.greenPrimary.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'Stripe Paid',
                          style: TextStyle(
                            fontFamily: 'SpaceGrotesk',
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            color: WebColors.greenBright,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: isHero ? 12 : 8),

                  // Health metrics row
                  Container(
                    padding: EdgeInsets.all(isHero ? 10 : 8),
                    decoration: BoxDecoration(
                      color: WebColors.bgCardHover,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _metricItem('Heart Rate', '74 bpm', Icons.favorite_rounded, const Color(0xFFF43F5E)),
                        _metricItem('Caregiver', 'Dr. Sarah', Icons.verified_user_rounded, accentColor),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: 14,
            right: 14,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: accentColor.withValues(alpha: 0.4)),
              ),
              child: Text(
                tag,
                style: TextStyle(
                  fontFamily: 'SpaceGrotesk',
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  color: accentColor,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _metricItem(String label, String value, IconData icon, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: isHero ? 16 : 13),
        const SizedBox(width: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontFamily: 'SpaceGrotesk',
                fontSize: isHero ? 9 : 8,
                color: WebColors.textMuted,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontFamily: 'SpaceGrotesk',
                fontSize: isHero ? 11 : 9.5,
                fontWeight: FontWeight.w700,
                color: WebColors.textPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFitnessMockup({
    required LinearGradient gradient,
    required Color accentColor,
    required Color secondaryColor,
    required IconData icon,
    required String tag,
  }) {
    return Container(
      decoration: BoxDecoration(gradient: gradient),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: Container(
              width: isHero ? 340 : 210,
              padding: EdgeInsets.all(isHero ? 20 : 12),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: accentColor.withValues(alpha: 0.3)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Class Pass Confirmed',
                        style: TextStyle(
                          fontFamily: 'SpaceGrotesk',
                          fontSize: isHero ? 14 : 11,
                          fontWeight: FontWeight.w700,
                          color: WebColors.textPrimary,
                        ),
                      ),
                      Icon(Icons.check_circle_rounded, color: secondaryColor, size: isHero ? 18 : 14),
                    ],
                  ),
                  SizedBox(height: isHero ? 8 : 6),
                  Text(
                    'Reformer Pilates · 10:00 AM',
                    style: TextStyle(
                      fontFamily: 'SpaceGrotesk',
                      fontSize: isHero ? 12 : 9.5,
                      color: WebColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: isHero ? 10 : 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: WebColors.bgCard,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.payment_rounded, color: accentColor, size: 12),
                        const SizedBox(width: 4),
                        Text(
                          'Mollie Gateway Verified',
                          style: TextStyle(
                            fontFamily: 'SpaceGrotesk',
                            fontSize: 9,
                            color: WebColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 14,
            right: 14,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: accentColor.withValues(alpha: 0.4)),
              ),
              child: Text(
                tag,
                style: TextStyle(
                  fontFamily: 'SpaceGrotesk',
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  color: accentColor,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRealEstateMockup({
    required LinearGradient gradient,
    required Color accentColor,
    required Color secondaryColor,
    required IconData icon,
    required String tag,
  }) {
    return Container(
      decoration: BoxDecoration(gradient: gradient),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: Container(
              width: isHero ? 340 : 210,
              padding: EdgeInsets.all(isHero ? 20 : 12),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: accentColor.withValues(alpha: 0.3)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Modern Glass Villa',
                        style: TextStyle(
                          fontFamily: 'SpaceGrotesk',
                          fontSize: isHero ? 14 : 11,
                          fontWeight: FontWeight.w700,
                          color: WebColors.textPrimary,
                        ),
                      ),
                      Text(
                        '\$850,000',
                        style: TextStyle(
                          fontFamily: 'SpaceGrotesk',
                          fontSize: isHero ? 13 : 10.5,
                          fontWeight: FontWeight.bold,
                          color: secondaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: isHero ? 8 : 4),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, color: accentColor, size: isHero ? 14 : 11),
                      const SizedBox(width: 4),
                      Text(
                        'Prime Sunset Valley, CA',
                        style: TextStyle(
                          fontFamily: 'SpaceGrotesk',
                          fontSize: isHero ? 11 : 9,
                          color: WebColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: isHero ? 8 : 6),
                  Row(
                    children: [
                      _badge('4 Beds'),
                      const SizedBox(width: 6),
                      _badge('3 Baths'),
                      const SizedBox(width: 6),
                      _badge('3,200 sqft'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 14,
            right: 14,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: accentColor.withValues(alpha: 0.4)),
              ),
              child: Text(
                tag,
                style: TextStyle(
                  fontFamily: 'SpaceGrotesk',
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  color: accentColor,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _badge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: WebColors.bgCardHover,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'SpaceGrotesk',
          fontSize: isHero ? 10 : 8,
          color: WebColors.textPrimary,
        ),
      ),
    );
  }

  Widget _buildGenericMockup() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0F172A), Color(0xFF064E3B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: WebColors.greenPrimary.withValues(alpha: 0.2),
                border: Border.all(color: WebColors.greenBright.withValues(alpha: 0.4)),
              ),
              child: const Icon(
                Icons.phone_android_rounded,
                color: WebColors.greenBright,
                size: 32,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              project.title,
              style: const TextStyle(
                fontFamily: 'SpaceGrotesk',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: WebColors.textPrimary,
              ),
            ),
            Text(
              project.category,
              style: const TextStyle(
                fontFamily: 'SpaceGrotesk',
                fontSize: 12,
                color: WebColors.greenBright,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
