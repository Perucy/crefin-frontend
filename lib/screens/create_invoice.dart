import 'package:flutter/material.dart';
import '../colors.dart';

class CreateInvoiceScreen extends StatefulWidget {
  final VoidCallback onBack;
  final Function(Map<String, dynamic>, bool isDraft) onSave;

  const CreateInvoiceScreen({
    super.key,
    required this.onBack,
    required this.onSave,
  });

  @override
  State<CreateInvoiceScreen> createState() => _CreateInvoiceScreenState();
}

class _CreateInvoiceScreenState extends State<CreateInvoiceScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _paymentTermsController = TextEditingController(
    text: 'Payment due within 30 days of invoice date. Late payments may incur additional fees.',
  );
  final TextEditingController _clientSearchController = TextEditingController();

  String _selectedClient = 'Select a client';
  DateTime? _selectedDueDate;
  bool _showClientDropdown = false;
  
  final Map<String, String> _errors = {};

  final List<String> _clients = [
    'Select a client',
    'TechCorp Inc.',
    'Design Studio LLC',
    'Global Tech',
    'Creative Agency',
    'StartupXYZ',
    'Acme Corp',
    'SlowPay Corp',
    'Budget Startup',
    'Digital Ventures',
  ];

  @override
  void dispose() {
    _descriptionController.dispose();
    _amountController.dispose();
    _notesController.dispose();
    _paymentTermsController.dispose();
    _clientSearchController.dispose();
    super.dispose();
  }

  bool _validateForm() {
    setState(() {
      _errors.clear();
      
      if (_selectedClient == _clients[0]) {
        _errors['client'] = 'Client is required';
      }

      if (_selectedDueDate == null) {
        _errors['dueDate'] = 'Due date is required';
      }

      if (_descriptionController.text.trim().isEmpty) {
        _errors['description'] = 'Description is required';
      }

      if (_amountController.text.isEmpty || 
          double.tryParse(_amountController.text) == null ||
          double.parse(_amountController.text) <= 0) {
        _errors['amount'] = 'Amount is required';
      }
    });

    return _errors.isEmpty;
  }

  void _handleCreateInvoice() {
    if (_validateForm()) {
      widget.onSave({
        'client': _selectedClient,
        'dueDate': _selectedDueDate!.toIso8601String(),
        'description': _descriptionController.text,
        'amount': _amountController.text,
        'notes': _notesController.text,
        'paymentTerms': _paymentTermsController.text,
      }, false);
    }
  }

  void _handleSaveDraft() {
    widget.onSave({
      'client': _selectedClient,
      'dueDate': _selectedDueDate?.toIso8601String() ?? '',
      'description': _descriptionController.text,
      'amount': _amountController.text,
      'notes': _notesController.text,
      'paymentTerms': _paymentTermsController.text,
    }, true);
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
      body: SafeArea(
        child: Stack(
          children: [
            // Everything Scrollable (Header + Form)
            SingleChildScrollView(
              padding: const EdgeInsets.only(
                left: 24,
                right: 24,
                top: 0,
                bottom: 120, // Space for floating buttons
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header (now inside scroll view)
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: borderColor, width: 1),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: widget.onBack,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: cardBg,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.arrow_back,
                              color: textColor,
                              size: 20,
                            ),
                          ),
                        ),
                        Text(
                          'Create Invoice',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 40),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Client Selector
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Client ',
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
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _showClientDropdown = !_showClientDropdown;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: cardBg,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: _errors.containsKey('client') ? red : borderColor,
                              width: _errors.containsKey('client') ? 2 : 1,
                            ),
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
                      if (_errors.containsKey('client'))
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            _errors['client']!,
                            style: TextStyle(color: red, fontSize: 12),
                          ),
                        ),
                      if (_showClientDropdown)
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          decoration: BoxDecoration(
                            color: cardBg,
                            borderRadius: BorderRadius.circular(20),
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
                                constraints: const BoxConstraints(maxHeight: 224),
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
                                          _errors.remove('client');
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
                                      _errors.remove('client');
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

                  // Due Date Picker
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Due Date ',
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
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now().add(const Duration(days: 30)),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(const Duration(days: 365)),
                          );
                          if (date != null) {
                            setState(() {
                              _selectedDueDate = date;
                              _errors.remove('dueDate');
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: cardBg,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: _errors.containsKey('dueDate') ? red : borderColor,
                              width: _errors.containsKey('dueDate') ? 2 : 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.calendar_today_outlined, color: tertiaryText, size: 20),
                              const SizedBox(width: 12),
                              Text(
                                _selectedDueDate != null
                                    ? '${_selectedDueDate!.year}-${_selectedDueDate!.month.toString().padLeft(2, '0')}-${_selectedDueDate!.day.toString().padLeft(2, '0')}'
                                    : 'Select due date',
                                style: TextStyle(
                                  color: _selectedDueDate != null ? textColor : tertiaryText,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (_errors.containsKey('dueDate'))
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            _errors['dueDate']!,
                            style: TextStyle(color: red, fontSize: 12),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Description
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Description ',
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
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: cardBg,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: _errors.containsKey('description') ? red : borderColor,
                            width: _errors.containsKey('description') ? 2 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.description_outlined, color: tertiaryText, size: 20),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TextField(
                                controller: _descriptionController,
                                style: TextStyle(color: textColor, fontSize: 16),
                                decoration: InputDecoration(
                                  hintText: 'e.g., Website Design & Development',
                                  hintStyle: TextStyle(color: tertiaryText),
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                ),
                                onChanged: (_) {
                                  if (_errors.containsKey('description')) {
                                    setState(() {
                                      _errors.remove('description');
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (_errors.containsKey('description'))
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            _errors['description']!,
                            style: TextStyle(color: red, fontSize: 12),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Total Amount - Featured
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Total Amount ',
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
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: cardBg,
                          borderRadius: BorderRadius.circular(20),
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

                  // Notes (Optional)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Notes ',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          children: [
                            TextSpan(
                              text: '(Optional)',
                              style: TextStyle(
                                color: tertiaryText,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: cardBg,
                          borderRadius: BorderRadius.circular(20),
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
                                  hintText: 'Add any additional notes or details...',
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

                  // Payment Terms (Optional)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Payment Terms ',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          children: [
                            TextSpan(
                              text: '(Optional)',
                              style: TextStyle(
                                color: tertiaryText,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: cardBg,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: borderColor),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: Icon(Icons.description_outlined, color: tertiaryText, size: 20),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TextField(
                                controller: _paymentTermsController,
                                maxLines: 2,
                                style: TextStyle(color: textColor, fontSize: 16),
                                decoration: InputDecoration(
                                  hintText: 'Enter payment terms and conditions...',
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

            // Floating Buttons at Bottom
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
                          borderRadius: BorderRadius.circular(20),
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
                            onTap: _handleSaveDraft,
                            borderRadius: BorderRadius.circular(20),
                            child: Center(
                              child: Text(
                                'Save as Draft',
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
                          borderRadius: BorderRadius.circular(20),
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
                            onTap: _handleCreateInvoice,
                            borderRadius: BorderRadius.circular(20),
                            child: const Center(
                              child: Text(
                                'Create Invoice',
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
      ),
    );
  }
}