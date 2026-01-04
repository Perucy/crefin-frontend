import 'package:flutter/material.dart';
import '../colors.dart';

class AddExpenseScreen extends StatefulWidget {
  final VoidCallback onBack;
  final Function(Map<String, dynamic>) onSave;

  const AddExpenseScreen({
    super.key,
    required this.onBack,
    required this.onSave,
  });

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  
  String _selectedCategory = 'Select a category';
  DateTime _selectedDate = DateTime.now();
  String? _receiptFileName;
  bool _taxDeductible = false;
  bool _showCategoryDropdown = false;
  
  final Map<String, String> _errors = {};

  final List<String> _categories = [
    'Select a category',
    'Software & Tools',
    'Office Supplies',
    'Equipment',
    'Marketing & Advertising',
    'Professional Services',
    'Travel & Transportation',
    'Meals & Entertainment',
    'Education & Training',
    'Insurance',
    'Rent & Utilities',
    'Other',
  ];

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  bool _validateForm() {
    setState(() {
      _errors.clear();
      
      if (_amountController.text.isEmpty || 
          double.tryParse(_amountController.text) == null ||
          double.parse(_amountController.text) <= 0) {
        _errors['amount'] = 'Amount is required';
      }

      if (_selectedCategory == _categories[0]) {
        _errors['category'] = 'Category is required';
      }

      if (_descriptionController.text.trim().isEmpty) {
        _errors['description'] = 'Description is required';
      }
    });

    return _errors.isEmpty;
  }

  void _handleSave() {
    if (_validateForm()) {
      widget.onSave({
        'amount': _amountController.text,
        'category': _selectedCategory,
        'description': _descriptionController.text,
        'date': _selectedDate.toIso8601String(),
        'receipt': _receiptFileName,
        'taxDeductible': _taxDeductible,
      });
    }
  }

  Future<void> _pickReceipt() async {
    // Simulate file picker
    setState(() {
      _receiptFileName = 'receipt_${DateTime.now().millisecondsSinceEpoch}.jpg';
    });
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
    final orange = const Color(0xFFFF9500);
    final orangeBg = orange.withOpacity(0.1);
    final blue = const Color(0xFF007AFF);
    final blueBg = blue.withOpacity(0.1);
    final green = const Color(0xFF34C759);
    final greenBg = green.withOpacity(0.1);
    final red = const Color(0xFFFF3B30);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Stack(
          children: [
            // Header + Scrollable Content
            Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
                        'Add Expense',
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

                // Form Content - Scrollable
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(
                      left: 24,
                      right: 24,
                      top: 24,
                      bottom: 120, // Space for floating buttons
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                      color: orangeBg,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Icon(
                                      Icons.attach_money,
                                      color: orange,
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

                        // Category Selector
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'Category ',
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
                                  _showCategoryDropdown = !_showCategoryDropdown;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: cardBg,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: _errors.containsKey('category') ? red : borderColor,
                                    width: _errors.containsKey('category') ? 2 : 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.label_outline, color: tertiaryText, size: 20),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        _selectedCategory,
                                        style: TextStyle(
                                          color: _selectedCategory == _categories[0]
                                              ? tertiaryText
                                              : textColor,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      _showCategoryDropdown
                                          ? Icons.keyboard_arrow_up
                                          : Icons.keyboard_arrow_down,
                                      color: tertiaryText,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (_errors.containsKey('category'))
                              Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Text(
                                  _errors['category']!,
                                  style: TextStyle(color: red, fontSize: 12),
                                ),
                              ),
                            if (_showCategoryDropdown)
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
                                constraints: const BoxConstraints(maxHeight: 256),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: _categories.length,
                                  itemBuilder: (context, index) {
                                    final category = _categories[index];
                                    final isSelected = _selectedCategory == category;
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          _selectedCategory = category;
                                          _showCategoryDropdown = false;
                                          _errors.remove('category');
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 14,
                                        ),
                                        color: isSelected ? orangeBg : Colors.transparent,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              category,
                                              style: TextStyle(
                                                color: textColor,
                                                fontSize: 15,
                                              ),
                                            ),
                                            if (isSelected)
                                              Icon(Icons.check, color: orange, size: 20),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
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
                                        hintText: 'e.g., Adobe Creative Cloud subscription',
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
                            const SizedBox(height: 10),
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
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: cardBg,
                                  borderRadius: BorderRadius.circular(20),
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

                        // Receipt Upload
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Receipt',
                              style: TextStyle(
                                color: textColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: _pickReceipt,
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: cardBg,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: borderColor,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: blueBg,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Icon(
                                        _receiptFileName != null
                                            ? Icons.check
                                            : Icons.camera_alt_outlined,
                                        color: blue,
                                        size: 20,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _receiptFileName ?? 'Add Receipt',
                                            style: TextStyle(
                                              color: _receiptFileName != null ? blue : textColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          if (_receiptFileName == null)
                                            Text(
                                              'Upload photo or file',
                                              style: TextStyle(
                                                color: tertiaryText,
                                                fontSize: 13,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    Icon(Icons.upload_outlined, color: tertiaryText, size: 20),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Tax Deductible Toggle
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: cardBg,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: borderColor),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: _taxDeductible ? greenBg : borderColor.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Icon(
                                  Icons.check,
                                  color: _taxDeductible ? green : tertiaryText,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Tax Deductible',
                                      style: TextStyle(
                                        color: textColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      'Business expense',
                                      style: TextStyle(
                                        color: tertiaryText,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _taxDeductible = !_taxDeductible;
                                  });
                                },
                                child: Container(
                                  width: 51,
                                  height: 31,
                                  decoration: BoxDecoration(
                                    color: _taxDeductible ? green : borderColor,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: AnimatedAlign(
                                    alignment: _taxDeductible
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    duration: const Duration(milliseconds: 200),
                                    child: Container(
                                      width: 27,
                                      height: 27,
                                      margin: const EdgeInsets.all(2),
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 4,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
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
                            onTap: widget.onBack,
                            borderRadius: BorderRadius.circular(20),
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
                            onTap: _handleSave,
                            borderRadius: BorderRadius.circular(20),
                            child: const Center(
                              child: Text(
                                'Save Expense', // or 'Save Income' for income screen
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