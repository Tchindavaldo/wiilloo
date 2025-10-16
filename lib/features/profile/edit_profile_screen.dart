import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  final String name;
  final String phone;
  final String? email;
  final String? dob; // dd/MM/yyyy
  final String? address;
  final File? avatar;

  const EditProfileScreen({
    super.key,
    required this.name,
    required this.phone,
    this.email,
    this.dob,
    this.address,
    this.avatar,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  static const primary = Color(0xFF3B82F6);

  late final TextEditingController _nameCtrl;
  late final TextEditingController _emailCtrl;
  late final TextEditingController _phoneCtrl;
  late final TextEditingController _dobCtrl;
  late final TextEditingController _addressCtrl;

  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();
  File? _avatarFile;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.name);
    _emailCtrl = TextEditingController(text: widget.email ?? '');
    _phoneCtrl = TextEditingController(text: widget.phone);
    _dobCtrl = TextEditingController(text: widget.dob ?? '');
    _addressCtrl = TextEditingController(text: widget.address ?? '');
    _avatarFile = widget.avatar;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _dobCtrl.dispose();
    _addressCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickAvatar() async {
    try {
      final picked = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
      if (picked != null) setState(() => _avatarFile = File(picked.path));
    } catch (_) {}
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final initial = DateTime.tryParse(_toIsoFromFr(_dobCtrl.text)) ?? DateTime(now.year - 18, now.month, now.day);
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime(now.year + 1),
      initialDate: initial,
    );
    if (date != null) {
      _dobCtrl.text = _formatFr(date);
      setState(() {});
    }
  }

  String _formatFr(DateTime d) => '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
  String _toIsoFromFr(String fr) {
    // dd/MM/yyyy -> yyyy-MM-dd
    final parts = fr.split('/');
    if (parts.length == 3) {
      return '${parts[2]}-${parts[1].padLeft(2, '0')}-${parts[0].padLeft(2, '0')}';
    }
    return fr;
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.pop(context, {
      'name': _nameCtrl.text.trim(),
      'phone': _phoneCtrl.text.trim(),
      if (_emailCtrl.text.trim().isNotEmpty) 'email': _emailCtrl.text.trim(),
      if (_dobCtrl.text.trim().isNotEmpty) 'dob': _dobCtrl.text.trim(),
      if (_addressCtrl.text.trim().isNotEmpty) 'address': _addressCtrl.text.trim(),
      if (_avatarFile != null) 'avatarPath': _avatarFile!.path,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F6FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        foregroundColor: Colors.white,
        title: const Text('Edit Profile'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: _save,
            child: const Text(
              'Enregistrer',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 16.5,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 28, 20, 32),
            children: [
              Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      radius: 58,
                      backgroundColor: Colors.white,
                      child: ClipOval(
                        child: SizedBox(
                          width: 116,
                          height: 116,
                          child: _avatarFile != null
                              ? Image.file(_avatarFile!, fit: BoxFit.cover)
                              : const Icon(Icons.person, size: 56, color: primary),
                        ),
                      ),
                    ),
                    Positioned(
                      right: -2,
                      bottom: -4,
                      child: InkWell(
                        onTap: _pickAvatar,
                        borderRadius: BorderRadius.circular(18),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: primary,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(color: primary.withOpacity(0.35), blurRadius: 14, offset: const Offset(0, 6)),
                            ],
                          ),
                          child: const Icon(Icons.camera_alt_rounded, color: Colors.white, size: 19),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 28),
              _FieldTile(label: 'Username', controller: _nameCtrl, keyboardType: TextInputType.name, validator: (v) => v==null||v.trim().isEmpty ? 'Obligatoire' : null),
              _FieldTile(label: 'Email', controller: _emailCtrl, keyboardType: TextInputType.emailAddress),
              _FieldTile(label: 'Phone', controller: _phoneCtrl, keyboardType: TextInputType.phone),
              _FieldTile(label: 'Date of birth', controller: _dobCtrl, readOnly: true, onTap: _pickDate, suffix: const Icon(Icons.calendar_today_rounded, color: primary, size: 18)),
              _FieldTile(label: 'Address', controller: _addressCtrl, keyboardType: TextInputType.streetAddress),
            ],
          ),
        ),
      ),
    );
  }
}

class _FieldTile extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool readOnly;
  final VoidCallback? onTap;
  final Widget? suffix;

  const _FieldTile({
    required this.label,
    required this.controller,
    this.keyboardType,
    this.validator,
    this.readOnly = false,
    this.onTap,
    this.suffix,
  });

  static const primary = Color(0xFF3B82F6);

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black87, fontWeight: FontWeight.w600);
    final valueStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black87);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          // soft ambient
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 2)),
          // stronger bottom shadow
          BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 22, offset: const Offset(0, 12)),
        ],
        border: Border.all(color: primary.withOpacity(0.05)),
      ),
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      child: Row(
        children: [
          Expanded(
            flex: 7,
            child: Text(label, style: labelStyle?.copyWith(fontSize: 15)),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 11,
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              validator: validator,
              readOnly: readOnly,
              onTap: onTap,
              decoration: const InputDecoration(
                isDense: true,
                border: InputBorder.none,
              ),
              style: valueStyle?.copyWith(fontSize: 15.5),
              textAlign: TextAlign.right,
            ),
          ),
          if (suffix != null) ...[
            const SizedBox(width: 8),
            suffix!,
          ]
        ],
      ),
    );
  }
}
