import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

const kAccent = Color(0xFFFFFFFF);
const kBg = Color(0xFF000000);
const kSurface = Color(0xFF0A0A0A);
const kBorder = Color(0xFF1A1A1A);
const kTextPrimary = Color(0xFFFFFFFF);
const kTextMuted = Color(0xFF8A8A8A);
const kFill = Color(0xFF0E0E0E);

void main() {
  runApp(const DataDraftApp());
}

class DataDraftApp extends StatelessWidget {
  const DataDraftApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Draft',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: kAccent, brightness: Brightness.dark),
        scaffoldBackgroundColor: kBg,
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: kFill,
          labelStyle: GoogleFonts.inter(color: kTextMuted),
          hintStyle: GoogleFonts.inter(color: kTextMuted.withValues(alpha: 0.6)),
          prefixIconColor: kTextMuted,
          suffixIconColor: kTextMuted,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: kBorder),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: kBorder),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: kTextPrimary, width: 1.2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: kAccent, width: 1.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: kTextPrimary, width: 1.2),
          ),
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: kAccent,
          selectionColor: kTextPrimary.withValues(alpha: 0.15),
          selectionHandleColor: kAccent,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class FieldDef {
  final String label;
  final String key;
  final TextInputType? keyboard;
  final bool isDate;

  const FieldDef(this.label, this.key,
      {this.keyboard, this.isDate = false});
}

class SectionDef {
  final String title;
  final List<FieldDef> fields;
  const SectionDef(this.title, this.fields);
}

const sections = <SectionDef>[
  SectionDef('Personal Details', [
    FieldDef('Full Name', 'fullName'),
    FieldDef('Name as per official government document', 'officialName'),
    FieldDef('Date of Birth', 'dob', isDate: true),
    FieldDef('Gender', 'gender'),
    FieldDef('Place of Birth', 'placeOfBirth'),
    FieldDef("Father's Full Name", 'fatherName'),
    FieldDef("Mother's Full Name", 'motherName'),
    FieldDef('Marital Status', 'maritalStatus'),
    FieldDef('Nationality', 'nationality'),
  ]),
  SectionDef('Identity Documents', [
    FieldDef('Aadhaar Number', 'aadhaar', keyboard: TextInputType.number),
    FieldDef('PAN Number', 'pan'),
    FieldDef('Voter ID / EPIC Number', 'voterId'),
    FieldDef('Passport Number', 'passportNo'),
    FieldDef('Driving Licence Number', 'dlNumber'),
    FieldDef('Ration Card Number', 'rationCard'),
    FieldDef('Other Government-issued ID', 'otherId'),
  ]),
  SectionDef('Address Details', [
    FieldDef('Current Residential Address', 'currentAddress'),
    FieldDef('Permanent Address', 'permanentAddress'),
    FieldDef('House/Flat/Building Number', 'houseNumber'),
    FieldDef('Street/Area', 'streetArea'),
    FieldDef('Village/Town/City', 'city'),
    FieldDef('District', 'district'),
    FieldDef('State/UT', 'state'),
    FieldDef('PIN Code', 'pinCode', keyboard: TextInputType.number),
    FieldDef('Country', 'country'),
    FieldDef('Address Proof Document', 'addressProof'),
  ]),
  SectionDef('Contact Details', [
    FieldDef('Mobile Number', 'mobile', keyboard: TextInputType.phone),
    FieldDef('Alternate Mobile Number', 'altMobile',
        keyboard: TextInputType.phone),
    FieldDef('Email Address', 'email', keyboard: TextInputType.emailAddress),
    FieldDef('Emergency Contact Name', 'emergencyName'),
    FieldDef('Emergency Contact Relationship', 'emergencyRelation'),
    FieldDef('Emergency Contact Phone Number', 'emergencyPhone',
        keyboard: TextInputType.phone),
  ]),
  SectionDef('Family Details', [
    FieldDef("Father's Name", 'familyFatherName'),
    FieldDef("Mother's Name", 'familyMotherName'),
    FieldDef("Spouse's Name, if applicable", 'spouseName'),
    FieldDef('Number of Children', 'childrenCount', keyboard: TextInputType.number),
    FieldDef("Children's Details, if applicable", 'childrenDetails'),
    FieldDef('Other Dependent Family Members', 'otherDependents'),
  ]),
  SectionDef('Education', [
    FieldDef('Highest Educational Qualification', 'education'),
    FieldDef('School/College/University Name', 'institution'),
    FieldDef('Course/Degree', 'course'),
    FieldDef('Specialization', 'specialization'),
    FieldDef('Year of Completion', 'yearCompletion', keyboard: TextInputType.number),
    FieldDef('Percentage/CGPA', 'percentage'),
    FieldDef('Educational Certificates', 'eduCertificates'),
  ]),
  SectionDef('Employment', [
    FieldDef('Employment Status', 'employmentStatus'),
    FieldDef('Occupation', 'occupation'),
    FieldDef('Employer/Company Name', 'company'),
    FieldDef('Designation', 'designation'),
    FieldDef('Work Address', 'workAddress'),
    FieldDef('Work Experience', 'experience'),
    FieldDef('Annual Income', 'income', keyboard: TextInputType.number),
  ]),
  SectionDef('Bank Details', [
    FieldDef('Bank Account Holder Name', 'accountHolder'),
    FieldDef('Bank Name', 'bankName'),
    FieldDef('Account Number', 'accountNumber',
        keyboard: TextInputType.number),
    FieldDef('IFSC Code', 'ifsc'),
    FieldDef('Branch Name', 'branchName'),
    FieldDef('Account Type', 'accountType'),
  ]),
  SectionDef('Tax / Financial Details', [
    FieldDef('PAN', 'taxPan'),
    FieldDef('Income Source', 'incomeSource'),
    FieldDef('Annual Income', 'taxAnnualIncome',
        keyboard: TextInputType.number),
    FieldDef('Tax-related Information, if required', 'taxInfo'),
    FieldDef('GSTIN, if applicable', 'gstin'),
  ]),
  SectionDef('Supporting Documents', [
    FieldDef('Signature', 'signature'),
    FieldDef('Identity Proof', 'idProof'),
    FieldDef('Address Proof', 'docAddressProof'),
    FieldDef('Date-of-birth Proof', 'dobProof'),
    FieldDef('Educational Certificates', 'docEduCertificates'),
    FieldDef('Income Certificate', 'incomeCertificate'),
    FieldDef('Caste/Community Certificate, if applicable', 'casteCertificate'),
    FieldDef('Disability Certificate, if applicable', 'disabilityCertificate'),
    FieldDef('Birth Certificate', 'birthCertificate'),
    FieldDef('Other Supporting Documents', 'otherDocuments'),
  ]),
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controllers = <String, TextEditingController>{};
  int _current = 0;
  final _pageController = PageController();

  @override
  void initState() {
    super.initState();
    for (final s in sections) {
      for (final f in s.fields) {
        _controllers[_key(s, f)] = TextEditingController();
      }
    }
  }

  String _key(SectionDef s, FieldDef f) => '${s.title}|${f.key}';

  @override
  void dispose() {
    _pageController.dispose();
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  void _goTo(int index) {
    setState(() => _current = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutCubic,
    );
  }

  bool _validate(SectionDef s) {
    for (final f in s.fields) {
      final c = _controllers[_key(s, f)]!;
      if (c.text.trim().isEmpty) {
        _showSnack('Please fill in "${f.label}" before continuing.', red: true);
        return false;
      }
      if (f.key == 'email' &&
          !RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(c.text.trim())) {
        _showSnack('Please enter a valid email address.', red: true);
        return false;
      }
    }
    return true;
  }

  void _showSnack(String msg, {bool red = false}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Row(
          children: [
            Icon(red ? Icons.info_outline : Icons.check_circle,
                color: red ? kTextMuted : kAccent, size: 20),
            const SizedBox(width: 10),
            Expanded(
                child: Text(msg, style: GoogleFonts.inter(color: kTextPrimary))),
          ],
        ),
        backgroundColor: kSurface,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: red ? kTextPrimary : kBorder, width: 1.5),
        ),
      ));
  }

  String _fmt(String? v) => (v == null || v.trim().isEmpty) ? 'Not provided' : v;

  String _buildText() {
    const border = '=======================================================';
    const thin = '-------';
    final b = StringBuffer();
    b.writeln(border);
    b.writeln('PERSONAL DATA COLLECTION');
    b.writeln('Generated: ${DateTime.now()}');
    b.writeln(border);
    for (final s in sections) {
      b.writeln('\n${s.title.toUpperCase()}');
      b.writeln(thin);
      for (final f in s.fields) {
        b.writeln('${f.label}: ${_fmt(_controllers[_key(s, f)]!.text)}');
      }
    }
    b.writeln('\n$border');
    b.writeln('END OF REPORT');
    return b.toString();
  }

  Future<Uint8List> _buildPdf() async {
    final doc = pw.Document(title: 'Personal Data');
    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        header: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('DRAFT',
                style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.grey800)),
            pw.Text(
              'Personal Data Collection Report',
              style: const pw.TextStyle(
                  fontSize: 12, color: PdfColors.grey600),
            ),
            pw.SizedBox(height: 10),
            pw.Divider(color: PdfColors.grey400),
          ],
        ),
        footer: (context) => pw.Align(
          alignment: pw.Alignment.centerRight,
          child: pw.Text(
            'Generated by Draft',
            style: const pw.TextStyle(
                fontSize: 9, color: PdfColors.grey500),
          ),
        ),
        build: (context) => [
          for (final s in sections) ...[
            pw.Padding(
              padding: const pw.EdgeInsets.only(top: 18, bottom: 6),
              child: pw.Text(s.title.toUpperCase(),
                  style: pw.TextStyle(
                      fontSize: 13,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.black)),
            ),
            for (final f in s.fields)
              pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 4),
                child: pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Expanded(
                      flex: 2,
                      child: pw.Text(f.label,
                          style: const pw.TextStyle(
                              fontSize: 11,
                              color: PdfColors.grey700)),
                    ),
                    pw.Expanded(
                      flex: 3,
                      child: pw.Text(
                        _fmt(_controllers[_key(s, f)]!.text),
                        style: pw.TextStyle(
                            fontSize: 11,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.black),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ],
      ),
    );
    return doc.save();
  }

  Future<void> _saveFile() async {
    final Uint8List bytes;
    try {
      bytes = await _buildPdf();
    } catch (e) {
      _showSnack('Could not create PDF: $e', red: true);
      return;
    }

    try {
      final path = await FilePicker.platform.saveFile(
        dialogTitle: 'Save your data',
        fileName: 'personal-data.pdf',
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        bytes: bytes,
      );
      if (path == null) {
        _showSnack('Save cancelled.', red: true);
      } else {
        _showSnack('File saved: $path');
      }
    } catch (e) {
      debugPrint('saveFile failed: $e');
      try {
        final dir = await getAppDocumentsDir();
        final file = File('$dir/personal-data.pdf');
        await file.writeAsBytes(bytes);
        _showSnack('Saved to: ${file.path}');
      } catch (e2) {
        _showSnack('Could not save file: $e2', red: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Draft', style: GoogleFonts.inter(fontWeight: FontWeight.w700, color: kTextPrimary)),
        backgroundColor: kBg,
        elevation: 0,
        foregroundColor: kTextPrimary,
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            _ProgressHeader(current: _current, total: sections.length),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: sections.length + 1,
                itemBuilder: (context, index) {
                  if (index == sections.length) {
                    return _buildReview();
                  }
                  return _SectionForm(
                    key: PageStorageKey('section_$index'),
                    section: sections[index],
                    controllers: _controllers,
                    onNext: () {
                      if (!_validate(sections[index])) return;
                      _goTo(index + 1);
                    },
                    onBack: index > 0 ? () => _goTo(index - 1) : null,
                    isLast: index == sections.length - 1,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReview() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _AnimatedEntrance(
            delay: const Duration(milliseconds: 60),
            child: _GlassCard(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.rate_review, color: kAccent),
                      const SizedBox(width: 10),
                      Text('Review & Download',
                          style: GoogleFonts.inter(
                              fontSize: 20, fontWeight: FontWeight.w700, color: kTextPrimary)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Review everything below. To edit a section, use Previous.',
                    style: GoogleFonts.inter(
                        fontSize: 13, color: kTextMuted),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _AnimatedEntrance(
            delay: const Duration(milliseconds: 180),
            child: _GlassCard(
              padding: const EdgeInsets.all(16),
              child: SelectableText(
                _buildText(),
                style: GoogleFonts.inter(
                    fontSize: 13, height: 1.5, color: kTextPrimary),
              ),
            ),
          ),
          const SizedBox(height: 24),
          _AnimatedEntrance(
            delay: const Duration(milliseconds: 300),
            child: Row(
              children: [
                Expanded(
                  child: _GlassButton.outlined(
                    onTap: () => _goTo(sections.length - 1),
                    icon: Icons.arrow_back,
                    label: 'Edit',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _GlassButton.filled(
                    onTap: _saveFile,
                    icon: Icons.download,
                    label: 'Download PDF',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),
          Column(
            children: [
              Text('Draft',
                  style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: kTextMuted)),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => _openEmail(),
                    borderRadius: BorderRadius.circular(6),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 4),
                      child: Text('Support',
                          style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: kAccent)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text('·',
                      style: GoogleFonts.inter(
                          fontSize: 15, color: kTextMuted)),
                  const SizedBox(width: 12),
                  InkWell(
                    onTap: () => _openWebsite(),
                    borderRadius: BorderRadius.circular(6),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 4),
                      child: Text('Bhuvy',
                          style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: kAccent)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _openEmail() async {
    final uri = Uri(
      scheme: 'mailto',
      path: 'iambhuvanesh.a@gmail.com',
      query: 'subject=${Uri.encodeQueryComponent('Support')}',
    );
    try {
      final ok = await launchUrl(uri);
      if (!ok) _showSnack('Could not open email app.', red: true);
    } catch (e) {
      _showSnack('Could not open email app.', red: true);
    }
  }

  Future<void> _openWebsite() async {
    final uri = Uri.parse('https://imbhuvanesh.github.io/dev/');
    try {
      final ok = await launchUrl(uri,
          mode: LaunchMode.externalApplication);
      if (!ok) _showSnack('Could not open link.', red: true);
    } catch (e) {
      _showSnack('Could not open link.', red: true);
    }
  }

  Future<String> getAppDocumentsDir() async {
    return Directory.systemTemp.path;
  }
}

class _GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;
  const _GlassCard({
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.radius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: kSurface,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: kBorder),
      ),
      child: child,
    );
  }
}

class _GlassButton extends StatelessWidget {
  final VoidCallback? onTap;
  final IconData icon;
  final String label;
  final bool filled;
  const _GlassButton.filled({required this.onTap, required this.icon, required this.label})
      : filled = true;
  const _GlassButton.outlined({required this.onTap, required this.icon, required this.label})
      : filled = false;

  @override
  Widget build(BuildContext context) {
    final fill = filled ? kAccent : kSurface;
    final fg = filled ? const Color(0xFF000000) : kTextPrimary;
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          color: fill,
          borderRadius: BorderRadius.circular(8),
          border: filled ? null : Border.all(color: kBorder),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: fg, size: 20),
                const SizedBox(width: 8),
                Text(label,
                    style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: fg)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AnimatedEntrance extends StatefulWidget {
  final Widget child;
  final Duration delay;
  const _AnimatedEntrance({required this.child, this.delay = Duration.zero});

  @override
  State<_AnimatedEntrance> createState() => _AnimatedEntranceState();
}

class _AnimatedEntranceState extends State<_AnimatedEntrance>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<Offset> _slide;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _opacity = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slide = Tween(begin: const Offset(0, 0.08), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _timer = Timer(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(
        position: _slide,
        child: widget.child,
      ),
    );
  }
}

class _ProgressHeader extends StatelessWidget {
  final int current;
  final int total;
  const _ProgressHeader({required this.current, required this.total});

  @override
  Widget build(BuildContext context) {
    final done = current >= total;
    final shown = done ? total : current;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: total == 0 ? 0 : shown / total),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
      builder: (context, value, _) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 4,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: kBorder,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: FractionallySizedBox(
                    widthFactor: value,
                    child: Container(
                      color: kAccent,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                done
                    ? 'All steps completed!'
                    : 'Step ${current + 1} of $total · ${sections[current].title}',
                style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: kTextPrimary),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SectionForm extends StatefulWidget {
  final SectionDef section;
  final Map<String, TextEditingController> controllers;
  final VoidCallback onNext;
  final VoidCallback? onBack;
  final bool isLast;

  const _SectionForm({
    super.key,
    required this.section,
    required this.controllers,
    required this.onNext,
    this.onBack,
    required this.isLast,
  });

  @override
  State<_SectionForm> createState() => _SectionFormState();
}

class _SectionFormState extends State<_SectionForm> {
  final _formKey = GlobalKey<FormState>();

  String _key(FieldDef f) => '${widget.section.title}|${f.key}';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _GlassCard(
              padding: const EdgeInsets.all(20),
              radius: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _AnimatedEntrance(
                    delay: const Duration(milliseconds: 40),
                    child: Text(
                      widget.section.title,
                      style: GoogleFonts.inter(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: kTextPrimary),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Enter your details below.',
                    style: GoogleFonts.inter(
                        fontSize: 13, color: kTextMuted),
                  ),
                  const SizedBox(height: 18),
                  for (var i = 0; i < widget.section.fields.length; i++)
                    _AnimatedEntrance(
                      delay: Duration(milliseconds: 80 + (i % 4) * 70),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: _field(widget.section.fields[i], i),
                      ),
                    ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      if (widget.onBack != null)
                        _GlassInlineButton(
                          onTap: widget.onBack,
                          icon: Icons.arrow_back,
                          label: 'Previous',
                          filled: false,
                        ),
                      const Spacer(),
                      _GlassInlineButton(
                        onTap: () {
                          if (_formKey.currentState!.validate()) widget.onNext();
                        },
                        icon: widget.isLast ? Icons.rate_review : Icons.arrow_forward,
                        label: widget.isLast ? 'Review' : 'Next',
                        filled: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(FieldDef f, int index) {
    final c = widget.controllers[_key(f)]!;
    return _GlassField(
      sectionTitle: widget.section.title,
      field: f,
      controller: c,
      onDateTap: () => _pickDate(f, c),
      key: PageStorageKey('${widget.section.title}_${f.key}'),
    );
  }

  Future<void> _pickDate(FieldDef f, TextEditingController c) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      c.text =
          '${picked.year.toString().padLeft(4, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
    }
  }
}

class _GlassField extends StatelessWidget {
  final String sectionTitle;
  final FieldDef field;
  final TextEditingController controller;
  final VoidCallback onDateTap;

  const _GlassField({
    super.key,
    required this.sectionTitle,
    required this.field,
    required this.controller,
    required this.onDateTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDate = field.isDate;
    return isDate
        ? TextFormField(
            controller: controller,
            onTap: onDateTap,
            readOnly: true,
            decoration: InputDecoration(
              labelText: field.label,
              prefixIcon: const Icon(Icons.calendar_today, size: 20),
            ),
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Required' : null,
          )
        : TextFormField(
            controller: controller,
            keyboardType: field.keyboard,
            decoration: InputDecoration(labelText: field.label),
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Required' : null,
          );
  }
}

class _GlassInlineButton extends StatelessWidget {
  final VoidCallback? onTap;
  final IconData icon;
  final String label;
  final bool filled;
  const _GlassInlineButton({
    required this.onTap,
    required this.icon,
    required this.label,
    required this.filled,
  });

  @override
  Widget build(BuildContext context) {
    final fg = filled ? const Color(0xFF000000) : kTextPrimary;
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          color: filled ? kAccent : kSurface,
          borderRadius: BorderRadius.circular(8),
          border: filled ? null : Border.all(color: kBorder),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 13),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: fg, size: 19),
                const SizedBox(width: 8),
                Text(label,
                    style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: fg)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
