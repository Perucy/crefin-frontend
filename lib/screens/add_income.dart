import 'package:flutter/material.dart';
import '../colors.dart';

class AddIncomeScreen extends StatefulWidget {
  final VoidCallback onBack;
  final Function(Map<String, dynamic>) onSave;

  const AddIncomeScreen({
    super.key,
    required this.onBack,
    required this.onSave,
  });

  @override
  State<AddIncomeScreen> createState() => _AddIncomeScreenState();
}

class _AddIncomeScreenState extends State<AddIncomeScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _projectNameController = TextEditingController();
  final TextEditingController _hoursController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _clientSearchController = TextEditingController();
  final TextEditingController _skillSearchController = TextEditingController();

  String _selectedClient = 'Select a client';
  String _selectedSkill = 'Select a skill';
  DateTime _selectedDate = DateTime.now();
  bool _showClientDropdown = false;
  bool _showSkillDropdown = false;

  final Map<String, String> _errors = {};

  final List<String> _clients = [
    'Select a client',
    'TechCorp Inc.',
    'StartupXYZ',
    'DesignCo',
    'ClientCo LLC',
    'MegaBrand Agency',
  ];

  final List<String> _skills = [
    'Select a skill',
    'Web Development',
    'Mobile Development',
    'UI/UX Design',
    'Graphic Design',
    'Content Writing',
    'Video Editing',
    'Consulting',
    'Photography',
  ];

  @override
  void dispose() {
    _amountController.dispose();
    _projectNameController.dispose();
    _hoursController.dispose();
    _rateController.dispose();
    _notesController.dispose();
    _clientSearchController.dispose();
    _skillSearchController.dispose();
    super.dispose();
  }

  void _calculateAmount() {
    if (_hoursController.text.isNotEmpty && _rateController.text.isNotEmpty) {
      final hours = double.tryParse(_hoursController.text);
      final rate = double.tryParse(_rateController.text);
      if (hours != null && rate != null) {
        setState(() {
          _amountController.text = (hours * rate).toStringAsFixed(2);
        });
      }
    }
  }

  bool _validateForm() {
    setState(() {
      _errors.clear();

      if (_amountController.text.isEmpty ||
          double.tryParse(_amountController.text) == null ||
          double.parse(_amountController.text) <= 0) {
        _errors['amount'] = 'Amount is required';
      }
    });

    return _errors.isEmpty;
  }

  void _handleSave() {
    if (_validateForm()) {
      widget.onSave({
        'amount': _amountController.text,
        'projectName': _projectNameController.text,
        'client': _selectedClient == _clients[0] ? null : _selectedClient,
        'skill': _selectedSkill == _skills[0] ? null : _selectedSkill,
        'hours': _hoursController.text,
        'ratePerHour': _rateController.text,
        'notes': _notesController.text,
        'date': _selectedDate.toIso8601String(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final cardBg = isDark ? AppColors.darkCard : AppColors.lightCard;
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;
    final secondaryText = isDark ? AppColors.darkSecondaryText : AppColors.lightSecondaryText;
    final tertiaryText = isDark ? AppColors.darkTertiaryText : AppColors.lightTertiaryText;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final green = const Color(0xFF34C759);
    final greenBg = green.withOpacity(0.1);
    final blue = const Color(0xFF007AFF);
    final blueBg = blue.withOpacity(0.1);
    final red = const Color(0xFFFF3B30);

    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          // Everything Scrollable (Header + Form)
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: widget.onBack,
                          child: Container(
                            width: 40,
                            height: 40,
                            child: Icon(
                              Icons.arrow_back,
                              color: textColor,
                              size: 20,
                            ),
                          ),
                        ),
                        Text(
                          'Log Income',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 40),
                      ],
                    ),
                    const SizedBox(height: 6),

                    // Amount Input - Featured
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Amount ',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            children: [
                              TextSpan(
                                text: '*',
                                style: TextStyle(color: red),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: cardBg,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: _errors.containsKey('amount') ? red : borderColor,
                              width: _errors.containsKey('amount') ? 2 : 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: greenBg,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Icon(
                                  Icons.attach_money,
                                  color: green,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextField(
                                  controller: _amountController,
                                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: '0.00',
                                    hintStyle: TextStyle(color: tertiaryText),
                                    border: InputBorder.none,
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                  onChanged: (_) {
                                    if (_errors.containsKey('amount')) {
                                      setState(() {
                                        _errors.remove('amount');
                                      });
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (_errors.containsKey('amount'))
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              _errors['amount']!,
                              style: TextStyle(color: red, fontSize: 12),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Project Name
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Project Name',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.fromLTRB(12, 16, 16, 16),
                          decoration: BoxDecoration(
                            color: cardBg,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: borderColor),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.work_outline, color: tertiaryText, size: 20),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextField(
                                  controller: _projectNameController,
                                  style: TextStyle(color: textColor, fontSize: 16),
                                  decoration: InputDecoration(
                                    hintText: 'e.g., Website Redesign',
                                    hintStyle: TextStyle(color: tertiaryText),
                                    border: InputBorder.none,
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Client Selector
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Client',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 6),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _showClientDropdown = !_showClientDropdown;
                              _showSkillDropdown = false;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(12, 16, 16, 16),
                            decoration: BoxDecoration(
                              color: cardBg,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: borderColor),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.search, color: tertiaryText, size: 20),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    _selectedClient,
                                    style: TextStyle(
                                      color: _selectedClient == _clients[0]
                                          ? tertiaryText
                                          : textColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Icon(
                                  _showClientDropdown
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down,
                                  color: tertiaryText,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (_showClientDropdown)
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            decoration: BoxDecoration(
                              color: cardBg,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: borderColor),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                // Search Input
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: bgColor,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.search, color: tertiaryText, size: 16),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: TextField(
                                            controller: _clientSearchController,
                                            autofocus: true,
                                            style: TextStyle(color: textColor, fontSize: 14),
                                            decoration: InputDecoration(
                                              hintText: 'Search clients...',
                                              hintStyle: TextStyle(color: tertiaryText),
                                              border: InputBorder.none,
                                              isDense: true,
                                              contentPadding: EdgeInsets.zero,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // Client List
                                Container(
                                  constraints: const BoxConstraints(maxHeight: 200),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: _clients.length,
                                    itemBuilder: (context, index) {
                                      final client = _clients[index];
                                      final isSelected = _selectedClient == client;
                                      if (_clientSearchController.text.isNotEmpty &&
                                          !client.toLowerCase().contains(
                                              _clientSearchController.text.toLowerCase())) {
                                        return const SizedBox.shrink();
                                      }
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            _selectedClient = client;
                                            _showClientDropdown = false;
                                            _clientSearchController.clear();
                                          });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 14,
                                          ),
                                          color: isSelected ? blueBg : Colors.transparent,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                client,
                                                style: TextStyle(
                                                  color: textColor,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              if (isSelected)
                                                Icon(Icons.check, color: blue, size: 20),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                if (_clientSearchController.text.isNotEmpty)
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _selectedClient = _clientSearchController.text;
                                        _showClientDropdown = false;
                                        _clientSearchController.clear();
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: greenBg,
                                        border: Border(
                                          top: BorderSide(color: borderColor),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(Icons.add, color: green, size: 20),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Text(
                                              'Add "${_clientSearchController.text}" as new client',
                                              style: TextStyle(
                                                color: green,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Skill Selector
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Skill',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 6),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _showSkillDropdown = !_showSkillDropdown;
                              _showClientDropdown = false;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(12, 16, 16, 16),
                            decoration: BoxDecoration(
                              color: cardBg,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: borderColor),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.search, color: tertiaryText, size: 20),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    _selectedSkill,
                                    style: TextStyle(
                                      color: _selectedSkill == _skills[0]
                                          ? tertiaryText
                                          : textColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Icon(
                                  _showSkillDropdown
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down,
                                  color: tertiaryText,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (_showSkillDropdown)
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            decoration: BoxDecoration(
                              color: cardBg,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: borderColor),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                // Search Input
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: bgColor,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.search, color: tertiaryText, size: 16),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: TextField(
                                            controller: _skillSearchController,
                                            autofocus: true,
                                            style: TextStyle(color: textColor, fontSize: 14),
                                            decoration: InputDecoration(
                                              hintText: 'Search skills...',
                                              hintStyle: TextStyle(color: tertiaryText),
                                              border: InputBorder.none,
                                              isDense: true,
                                              contentPadding: EdgeInsets.zero,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // Skill List
                                Container(
                                  constraints: const BoxConstraints(maxHeight: 200),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: _skills.length,
                                    itemBuilder: (context, index) {
                                      final skill = _skills[index];
                                      final isSelected = _selectedSkill == skill;
                                      if (_skillSearchController.text.isNotEmpty &&
                                          !skill.toLowerCase().contains(
                                              _skillSearchController.text.toLowerCase())) {
                                        return const SizedBox.shrink();
                                      }
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            _selectedSkill = skill;
                                            _showSkillDropdown = false;
                                            _skillSearchController.clear();
                                          });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 14,
                                          ),
                                          color: isSelected ? blueBg : Colors.transparent,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                skill,
                                                style: TextStyle(
                                                  color: textColor,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              if (isSelected)
                                                Icon(Icons.check, color: blue, size: 20),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                if (_skillSearchController.text.isNotEmpty)
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _selectedSkill = _skillSearchController.text;
                                        _showSkillDropdown = false;
                                        _skillSearchController.clear();
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: greenBg,
                                        border: Border(
                                          top: BorderSide(color: borderColor),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(Icons.add, color: green, size: 20),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Text(
                                              'Add "${_skillSearchController.text}" as new skill',
                                              style: TextStyle(
                                                color: green,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Hours and Rate side by side
                    Row(
                      children: [
                        // Hours
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hours',
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.fromLTRB(12, 16, 16, 16),
                                decoration: BoxDecoration(
                                  color: cardBg,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: borderColor),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.access_time, color: tertiaryText, size: 20),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: TextField(
                                        controller: _hoursController,
                                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                        style: TextStyle(color: textColor, fontSize: 16),
                                        decoration: InputDecoration(
                                          hintText: '0',
                                          hintStyle: TextStyle(color: tertiaryText),
                                          border: InputBorder.none,
                                          isDense: true,
                                          contentPadding: EdgeInsets.zero,
                                        ),
                                        onChanged: (_) => _calculateAmount(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Rate per hour
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Rate/Hour',
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.fromLTRB(12, 16, 16, 16),
                                decoration: BoxDecoration(
                                  color: cardBg,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: borderColor),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.attach_money, color: tertiaryText, size: 20),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: TextField(
                                        controller: _rateController,
                                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                        style: TextStyle(color: textColor, fontSize: 16),
                                        decoration: InputDecoration(
                                          hintText: '0',
                                          hintStyle: TextStyle(color: tertiaryText),
                                          border: InputBorder.none,
                                          isDense: true,
                                          contentPadding: EdgeInsets.zero,
                                        ),
                                        onChanged: (_) => _calculateAmount(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Date Picker
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Date',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 6),
                        GestureDetector(
                          onTap: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: _selectedDate,
                              firstDate: DateTime(2000),
                              lastDate: DateTime.now(),
                            );
                            if (date != null) {
                              setState(() {
                                _selectedDate = date;
                              });
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(12, 16, 16, 16),
                            decoration: BoxDecoration(
                              color: cardBg,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: borderColor),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.calendar_today_outlined, color: tertiaryText, size: 20),
                                const SizedBox(width: 12),
                                Text(
                                  '${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}',
                                  style: TextStyle(color: textColor, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Notes
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Notes',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.fromLTRB(12, 16, 16, 16),
                          decoration: BoxDecoration(
                            color: cardBg,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: borderColor),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: Icon(Icons.notes_outlined, color: tertiaryText, size: 20),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextField(
                                  controller: _notesController,
                                  maxLines: 3,
                                  style: TextStyle(color: textColor, fontSize: 16),
                                  decoration: InputDecoration(
                                    hintText: 'Add any additional notes...',
                                    hintStyle: TextStyle(color: tertiaryText),
                                    border: InputBorder.none,
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Floating Buttons at Bottom
          Positioned(
            left: 24,
            right: 24,
            bottom: 24,
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 56,
                      decoration: BoxDecoration(
                        color: cardBg,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: borderColor, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: widget.onBack,
                          borderRadius: BorderRadius.circular(16),
                          child: Center(
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: textColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF34C759), Color(0xFF2FB350)],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: green.withOpacity(0.4),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: _handleSave,
                          borderRadius: BorderRadius.circular(16),
                          child: const Center(
                            child: Text(
                              'Save Income',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}