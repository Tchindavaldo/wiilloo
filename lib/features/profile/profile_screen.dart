import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wiilloo/features/profile/edit_profile_screen.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF3B82F6);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: primary,
        elevation: 0,
        surfaceTintColor: Colors.white,
        title: const Text('Profil'),
      ),
      body: const ProfileContent(),
    );
  }
}

class ProfileContent extends StatefulWidget {
  const ProfileContent({Key? key}) : super(key: key);

  @override
  State<ProfileContent> createState() => _ProfileContentState();
}

class _ProfileContentState extends State<ProfileContent> {
  String _userName = 'Utilisateur';
  String _userPhone = '+237 6X XX XX XX';
  File? _avatarFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    try {
      final picked = await _picker.pickImage(source: source, imageQuality: 85);
      if (picked != null) {
        setState(() {
          _avatarFile = File(picked.path);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Impossible d\'ouvrir ${source == ImageSource.camera ? 'la caméra' : 'la galerie'}: $e')),
        );
      }
    }
  }

  Future<void> _changeAvatar() async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        const primary = Color(0xFF3B82F6);
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library_rounded, color: primary),
                title: const Text(
                  'Choisir depuis la galerie',
                  style: TextStyle(color: primary, fontWeight: FontWeight.w600),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera_rounded, color: primary),
                title: const Text(
                  'Prendre une photo',
                  style: TextStyle(color: primary, fontWeight: FontWeight.w600),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _openEditProfile() {
    return Navigator.push<Map<String, dynamic>?>(
      context,
      MaterialPageRoute(
        builder: (_) => EditProfileScreen(
          name: _userName,
          phone: _userPhone,
          avatar: _avatarFile,
        ),
      ),
    ).then((result) {
      if (result == null) return;
      setState(() {
        if (result['name'] is String && (result['name'] as String).trim().isNotEmpty) {
          _userName = (result['name'] as String).trim();
        }
        if (result['phone'] is String && (result['phone'] as String).trim().isNotEmpty) {
          _userPhone = (result['phone'] as String).trim();
        }
        if (result['avatarPath'] is String) {
          _avatarFile = File(result['avatarPath'] as String);
        }
      });
    });
  }

  Future<void> _confirmLogout() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        const primary = Color(0xFF3B82F6);
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text(
            'Déconnexion',
            style: TextStyle(
              color: primary,
              fontWeight: FontWeight.w800,
            ),
          ),
          content: Text(
            'Voulez-vous vraiment vous déconnecter ?'
          ),
          actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          actions: [
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: primary,
                side: const BorderSide(color: primary),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Annuler'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Se déconnecter'),
            ),
          ],
        );
      },
    );
    if (result == true) {
      // TODO: intégrer la logique de déconnexion
    }
  }

  @override
  Widget build(BuildContext context) {
    final primary = const Color(0xFF3B82F6);
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 48, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    primary,
                    const Color(0xFF2563EB),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: primary.withOpacity(0.35),
                    blurRadius: 24,
                    offset: const Offset(0, 10),
                  ),
                ],
                border: Border.all(color: Colors.white.withOpacity(0.08)),
              ),
              child: Row(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.15),
                        ),
                        child: ClipOval(
                          child: _avatarFile != null
                              ? Image.file(_avatarFile!, fit: BoxFit.cover)
                              : const Icon(Icons.person, size: 38, color: Colors.white),
                        ),
                      ),

                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _userName,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: -0.2,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _userPhone,
                          style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.85)),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.edit_rounded, color: Colors.white),
                    onPressed: _openEditProfile,
                    tooltip: 'Modifier',
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),
            _ProfileSection(
              children: [
                _ProfileTile(
                  icon: Icons.monetization_on_outlined,
                  title: 'Abonnement',
                  subtitle: 'Consultez votre abonnement',
                  onTap: () {},
                ),
                _ProfileTile(
                  icon: Icons.history_rounded,
                  title: 'Historique',
                  subtitle: 'Consultez votre historique de paiement',
                  onTap: () {},
                ),
                _ProfileTile(
                  icon: Icons.translate_rounded,
                  title: 'Langue',
                  subtitle: 'Français',
                  onTap: () {},
                ),
                _ProfileTile(
                  icon: Icons.dark_mode_rounded,
                  title: 'Apparence',
                  subtitle: 'Système',
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 12),
            _ProfileSection(
              children: [
                _ProfileTile(
                  icon: Icons.help_center_rounded,
                  title: " A propos de l'application",
                  onTap: () {},
                ),
                _ProfileTile(
                  icon: Icons.mail_rounded,
                  title: 'Aide & FAQ',
                  onTap: () {},
                ),
                _ProfileTile(
                  icon: Icons.logout_rounded,
                  title: 'Se déconnecter',
                  onTap: _confirmLogout,
                  color: Colors.red,
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _ProfileSection extends StatelessWidget {
  final List<Widget> children;
  const _ProfileSection({required this.children});

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF3B82F6);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(color: primary.withOpacity(0.08)),
      ),
      child: Column(children: children),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final Color? color;
  const _ProfileTile({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF3B82F6);
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      leading: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color ?? primary,
              (color ?? primary).withOpacity(0.8),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: (color ?? primary).withOpacity(0.18),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.white),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
      ),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: const Icon(Icons.chevron_right_rounded, color: Color(0xFF3B82F6)),
      onTap: onTap,
    );
  }
}
