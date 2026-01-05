import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'colors.dart';
import 'screens/add_expense.dart';
import 'screens/add_income.dart';

class FinancesGoalsScreen extends StatefulWidget {
  const FinancesGoalsScreen({super.key});

  @override
  State<FinancesGoalsScreen> createState() => _FinancesGoalsScreenState();
}

class _FinancesGoalsScreenState extends State<FinancesGoalsScreen> {
  // State variables
  String _activeTab = 'finances'; // finances or goals
  String _financeView = 'income'; // income or expenses

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Income data
    final incomeData = [
      {'date': 'Nov 10, 2025', 'source': 'TechCorp Inc.', 'amount': 5000, 'type': 'Invoice Payment'},
      {'date': 'Nov 08, 2025', 'source': 'Design Studio LLC', 'amount': 3200, 'type': 'Project Completion'},
      {'date': 'Nov 05, 2025', 'source': 'Global Tech', 'amount': 6500, 'type': 'Monthly Retainer'},
    ];

    // Expense data
    final expenseData = [
      {'date': 'Nov 11, 2025', 'description': 'Adobe Creative Cloud', 'amount': 52.99, 'category': 'Software'},
      {'date': 'Nov 10, 2025', 'description': 'Office Rent', 'amount': 1500.0, 'category': 'Rent'},
      {'date': 'Nov 08, 2025', 'description': 'Figma Professional', 'amount': 15.0, 'category': 'Software'},
    ];

    // Goals data
    final goals = [
      {
        'title': 'Monthly Revenue Target',
        'current': 45800,
        'target': 55000,
        'progress': 83,
        'category': 'Revenue',  // ← Just this!
        'daysRemaining': 18,
        'deadline': 'Nov 30, 2025',
        'onTrack': true,
      },
      {
        'title': 'Emergency Fund',
        'current': 12000,
        'target': 20000,
        'progress': 60,
        'category': 'Savings',  // ← Just this!
        'daysRemaining': 49,
        'deadline': 'Dec 31, 2025',
        'onTrack': true,
      },
    ];

    // Completed goals data
    final completedGoals = [
      {
        'title': 'Q3 Revenue Target',
        'completedDate': 'Sep 30, 2025',
        'amount': '\$120,000',
      },
      {
        'title': 'Website Redesign Fund',
        'completedDate': 'Oct 15, 2025',
        'amount': '\$5,000',
      },
    ];

    // Calculate totals
    final totalIncome = incomeData.fold<num>(0, (sum, item) => sum + (item['amount'] as num));
    final totalExpenses = expenseData.fold<num>(0, (sum, item) => sum + (item['amount'] as num));
    final netProfit = totalIncome - totalExpenses;

    // Chart data
    final chartData = [
      {'month': 'Jun', 'income': 22500, 'expenses': 2100},
      {'month': 'Jul', 'income': 24800, 'expenses': 2250},
      {'month': 'Aug', 'income': 21300, 'expenses': 2400},
      {'month': 'Sep', 'income': 26100, 'expenses': 2150},
      {'month': 'Oct', 'income': 28900, 'expenses': 2350},
      {'month': 'Nov', 'income': 25500, 'expenses': 2213},
    ];

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: MediaQuery.removePadding(
        context: context,
        removeBottom: true,
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            overscroll: false,
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 120),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header
                          Text(
                            'Finances & Goals',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: isDark ? AppColors.darkText : AppColors.lightText,
                            ),
                          ),
                          const SizedBox(height: 6),

                          // Tab switcher
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                // Finances tab
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _activeTab = 'finances';
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                      decoration: BoxDecoration(
                                        color: _activeTab == 'finances'
                                            ? (isDark ? AppColors.darkCard : AppColors.lightCard)
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        'Finances',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: _activeTab == 'finances'
                                              ? (isDark ? AppColors.darkText : AppColors.lightText)
                                              : (isDark ? AppColors.darkSecondaryText : AppColors.lightSecondaryText),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                // Goals tab
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _activeTab = 'goals';
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                      decoration: BoxDecoration(
                                        color: _activeTab == 'goals'
                                            ? (isDark ? AppColors.darkCard : AppColors.lightCard)
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        'Goals',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: _activeTab == 'goals'
                                              ? (isDark ? AppColors.darkText : AppColors.lightText)
                                              : (isDark ? AppColors.darkSecondaryText : AppColors.lightSecondaryText),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Content based on active tab
                          if (_activeTab == 'finances') ...[
                            // Income vs Expenses Chart Card
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: isDark ? AppColors.darkCard : AppColors.lightCard,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 10,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Header with legend
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Income vs Expenses',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: isDark ? AppColors.darkText : AppColors.lightText,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          // Income legend
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                decoration: BoxDecoration(
                                                  color: AppColors.green,
                                                  borderRadius: BorderRadius.circular(2),
                                                ),
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                'Income',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: isDark ? AppColors.darkTertiaryText : AppColors.lightTertiaryText,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(width: 12),
                                          // Expense legend
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                decoration: BoxDecoration(
                                                  color: AppColors.orange,
                                                  borderRadius: BorderRadius.circular(2),
                                                ),
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                'Expenses',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: isDark ? AppColors.darkTertiaryText : AppColors.lightTertiaryText,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  
                                  // Chart bars
                                  ...chartData.map((data) {
                                    final month = data['month'] as String;
                                    final income = data['income'] as int;
                                    final expenses = data['expenses'] as int;

                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 10),
                                      child: Column(
                                        children: [
                                          // Month name and amount
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: 32,
                                                child: Text(
                                                  month,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: isDark ? AppColors.darkSecondaryText : AppColors.lightSecondaryText,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                '\$${(income / 1000).toStringAsFixed(1)}k',
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  color: isDark ? AppColors.darkTertiaryText : AppColors.lightTertiaryText,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 4),
                                          // Bars
                                          Row(
                                            children: [
                                              Flexible(
                                                flex: income,
                                                child: Container(
                                                  height: 28,
                                                  decoration: BoxDecoration(
                                                    color: AppColors.green,
                                                    borderRadius: BorderRadius.circular(4),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 4),
                                              Flexible(
                                                flex: expenses,
                                                child: Container(
                                                  height: 28,
                                                  decoration: BoxDecoration(
                                                    color: AppColors.orange,
                                                    borderRadius: BorderRadius.circular(4),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),

                                  // Divider
                                  const SizedBox(height: 12),
                                  Container(
                                    height: 1,
                                    color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                                  ),
                                  const SizedBox(height: 12),

                                  // Net Profit
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Net Profit (This Month)',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: isDark ? AppColors.darkSecondaryText : AppColors.lightSecondaryText,
                                        ),
                                      ),
                                      Text(
                                        '\$${netProfit.toStringAsFixed(0)}',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Monthly/Yearly Total Cards (Side by Side)
                            Row(
                              children: [
                                // Income Card (Green Gradient)
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Color(0xFF34C759),
                                          Color(0xFF30D158),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.green.withOpacity(0.3),
                                          blurRadius: 10,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Icon and label
                                        Row(
                                          children: [
                                            Container(
                                              width: 28,
                                              height: 28,
                                              decoration: BoxDecoration(
                                                color: Colors.white.withOpacity(0.2),
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.trending_up,
                                                size: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(width: 6),
                                            const Expanded(
                                              child: Text(
                                                'Income',
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  color: Colors.white70,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 12),
                                        // Amount
                                        Text(
                                          '\$${totalIncome.toStringAsFixed(0)}',
                                          style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        // Yearly
                                        Text(
                                          'Yearly: \$${(totalIncome * 12).toStringAsFixed(0)}',
                                          style: const TextStyle(
                                            fontSize: 11,
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                
                                // Expenses Card (Orange Gradient)
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Color(0xFFFF9500),
                                          Color(0xFFFFB340),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.orange.withOpacity(0.3),
                                          blurRadius: 10,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Icon and label
                                        Row(
                                          children: [
                                            Container(
                                              width: 28,
                                              height: 28,
                                              decoration: BoxDecoration(
                                                color: Colors.white.withOpacity(0.2),
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.trending_down,
                                                size: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(width: 6),
                                            const Expanded(
                                              child: Text(
                                                'Expenses',
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  color: Colors.white70,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 12),
                                        // Amount
                                        Text(
                                          '\$${totalExpenses.toStringAsFixed(0)}',
                                          style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        // Yearly
                                        Text(
                                          'Yearly: \$${(totalExpenses * 12).toStringAsFixed(0)}',
                                          style: const TextStyle(
                                            fontSize: 11,
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            // Income/Expense Toggle
                            Row(
                              children: [
                                // Income Button
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _financeView = 'income';
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                      decoration: BoxDecoration(
                                        color: _financeView == 'income' 
                                            ? AppColors.green 
                                            : (isDark ? AppColors.darkCard : AppColors.lightCard),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        'Income',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: _financeView == 'income' 
                                              ? Colors.white 
                                              : (isDark ? AppColors.darkSecondaryText : AppColors.lightSecondaryText),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                
                                // Expenses Button
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _financeView = 'expenses';
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                      decoration: BoxDecoration(
                                        color: _financeView == 'expenses' 
                                            ? AppColors.orange 
                                            : (isDark ? AppColors.darkCard : AppColors.lightCard),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        'Expenses',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: _financeView == 'expenses' 
                                              ? Colors.white 
                                              : (isDark ? AppColors.darkSecondaryText : AppColors.lightSecondaryText),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            // Income/Expense
                            GestureDetector(
                              onTap: () {
                                if (_financeView == 'income') {
                                  // navigate to add income
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddIncomeScreen(
                                        onBack: () => Navigator.pop(context),
                                        onSave: (incomeData) {
                                          print('Income saved: $incomeData');
                                          // TODO: Save to backend/local storage
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                  );
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddExpenseScreen(
                                        onBack: () => Navigator.pop(context),
                                        onSave: (expenseData) {
                                          print('Expense saved: $expenseData');
                                          // TODO: Save to backend/local storage
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: isDark ? AppColors.darkCard : AppColors.lightCard,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 10,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: (_financeView == 'income' ? AppColors.green : AppColors.orange).withOpacity(0.1),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        size: 20,
                                        color: _financeView == 'income' ? AppColors.green : AppColors.orange,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      'Log ${_financeView == 'income' ? 'Income' : 'Expense'}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: isDark ? AppColors.darkText : AppColors.lightText,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Income/Expense List
                            if (_financeView == 'income') ...[
                              // Income list 
                              ...incomeData.map((income) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: _buildIncomeCard(income, isDark),
                                );
                              }).toList(),
                            ] else ...[
                              // Expense list 
                              ...expenseData.map((expense) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: _buildExpenseCard(expense, isDark),
                                );
                              })
                            ],
                          ] else ...[
                            // Goals tab content
                            GestureDetector(
                              onTap: () {
                                // TODO: Navigate to create goal
                              },
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: AppColors.green,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 10,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.1),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      'Create New Goal',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Active goals
                            Text(
                              'Active Goals',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: isDark ? AppColors.darkText : AppColors.lightText,
                              ),
                            ),
                            const SizedBox(height: 16),

                            // active goals cards
                            ...goals.map((goal) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: _buildGoalCard(goal, isDark),
                              );
                            }).toList(),
                            const SizedBox(height: 24),

                            // completed goals
                            Text(
                              'Completed Goals',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: isDark ? AppColors.darkText : AppColors.lightText,
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Completed goals cards
                            ...completedGoals.map((goal) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: _buildCompletedGoalCard(goal, isDark),
                              );
                            }).toList(),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),    
    );
  }
  
  Widget _buildIncomeCard(Map<String, dynamic>incomeData, bool isDark) {
    final date = incomeData['date'] as String;
    final source = incomeData['source'] as String;
    final amount = incomeData['amount'] as int;
    final type = incomeData['type'] as String;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.green.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.attach_money_outlined,
              size: 20,
              color: AppColors.green,
            ),
          ),
          const SizedBox(width: 12),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  source,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.darkText : AppColors.lightText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  type,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? AppColors.darkSecondaryText : AppColors.lightSecondaryText,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 11,
                    color: isDark ? AppColors.darkTertiaryText : AppColors.lightTertiaryText,
                  ),
                ),
              ],
            ),
          ),

          // amount
          Text(
            '+\$${amount.toStringAsFixed(0)}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.green,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseCard(Map<String, dynamic>expenseData, bool isDark) {
    final date = expenseData['date'] as String;
    final description = expenseData['description'] as String;
    final amount = expenseData['amount'] as double;
    final category = expenseData['category'] as String;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _getCategoryColor(category).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.trending_down,
              size: 20,
              color: _getCategoryColor(category),
            ),
          ),
          const SizedBox(width: 12),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.darkText : AppColors.lightText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  category,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? AppColors.darkSecondaryText : AppColors.lightSecondaryText,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 11,
                    color: isDark ? AppColors.darkTertiaryText : AppColors.lightTertiaryText,
                  ),
                ),
              ],
            ),
          ),

          // amount
          Text(
            '-\$${amount.toStringAsFixed(0)}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.orange,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalCard(Map<String, dynamic>goals, bool isDark) {
    final title = goals['title'] as String;
    final target = goals['target'] as int;
    final current = goals['current'] as int;
    final progress = goals['progress'] as int;
    final category = goals['category'] as String;
    final goalIcon = _getGoalIcon(category); 
    final daysRemaining = goals['daysRemaining'] as int;
    final deadline = goals['deadline'] as String;
    final onTrack = goals['onTrack'] as bool;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    // Icon
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: goalIcon['bg'],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        goalIcon['icon'],
                        size: 24,
                        color: goalIcon['color'],
                      ),
                    ),
                    const SizedBox(width: 12),

                    // title + category
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // title
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isDark ? AppColors.darkText : AppColors.lightText,
                            ),
                          ),
                          // category
                          Text(
                            category,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isDark ? AppColors.darkSecondaryText: AppColors.lightSecondaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Right side - chevron
              Icon(
                Icons.chevron_right,
                size: 20,
                color: isDark ? AppColors.darkTertiaryText : AppColors.lightTertiaryText,
              ),
            ]
          ),
          const SizedBox(height: 16),

          // middle row 
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // amount so far
              Text(
                _formatAmount(current),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: goalIcon['color'],
                ),
              ),

              //  goal amount
              Text(
                _formatAmount(target),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.darkTertiaryText : AppColors.lightTertiaryText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // progress bar
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              widthFactor: progress / 100,
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: BoxDecoration(
                  color: goalIcon['color'],
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // day counter + state
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // calendar icon
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 12,
                    color: isDark ? AppColors.darkTertiaryText : AppColors.lightTertiaryText,
                  ),
                  const SizedBox(width: 4),

                  // days left
                  Text(
                    '$daysRemaining days left',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: isDark ? AppColors.darkTertiaryText : AppColors.lightTertiaryText,
                    ),
                  ),
                ],
              ),

              // Right group: Status
              Row(
                children: [
                  Icon(
                    onTrack ? Icons.check_circle : Icons.warning,
                    size: 12,
                    color: onTrack ? AppColors.green : AppColors.orange,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    onTrack ? 'On Track' : 'Behind',
                    style: TextStyle(
                      fontSize: 11,
                      color: onTrack ? AppColors.green : AppColors.orange,
                    ),
                  ),
                ],
              ),              
            ],
          ),

          const SizedBox(height: 16),

          // divider
          Container(
            height: 1,
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          ),
          const SizedBox(height: 4),

          // date
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Due: $deadline',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isDark ? AppColors.darkTertiaryText : AppColors.lightTertiaryText,
                ),
              )
            ],
          ),
        ],       
      ),
    );

  }

  Widget _buildCompletedGoalCard(Map<String, dynamic> goal, bool isDark) {
    final title = goal['title'] as String;
    final completedDate = goal['completedDate'] as String;
    final amount = goal['amount'] as String;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark 
            ? [
                AppColors.green.withOpacity(0.15),
                AppColors.green.withOpacity(0.1),
              ]
            : [
                const Color(0xFFF0FDF4),  // Light green
                const Color(0xFFDCFCE7),  // Lighter green
              ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Check icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.green,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle_outline_outlined,
              size: 20,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 12),
          
          // Title and date
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.darkText : AppColors.lightText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Completed $completedDate',
                  style: TextStyle(
                    fontSize: 11,
                    color: isDark ? AppColors.darkSecondaryText : AppColors.lightSecondaryText,
                  ),
                ),
              ],
            ),
          ),
          
          // Amount
          Text(
            amount,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.green,
            ),
          ),
        ],
      ),
    );
  }

  String _formatAmount(int amount) {
    final formatter = NumberFormat('#,###');
    return '\$${formatter.format(amount)}';
  }

  Color _getCategoryColor(String category) {
    // List of available colors
    final colors = [
      AppColors.blue,
      AppColors.orange,
      AppColors.purple,
      AppColors.green,
      AppColors.red,
      const Color(0xFF5856D6),  // Indigo
      const Color(0xFFFF2D55),  // Pink
      const Color(0xFF32ADE6), 
    ];
    
    // Use category name's hash to pick a color
    // Same category = same color every time!
    final index = category.hashCode.abs() % colors.length;
    return colors[index];
  }

  Map<String, dynamic> _getGoalIcon(String category) {
    final categoryLower = category.toLowerCase();
    
    // Try smart keyword matching first
    if (categoryLower.contains('revenue') || categoryLower.contains('income')) {
      return {
        'icon': Icons.attach_money,
        'color': AppColors.green,
        'bg': AppColors.green.withOpacity(0.1),
      };
    }
    
    if (categoryLower.contains('saving') || categoryLower.contains('fund')) {
      return {
        'icon': Icons.savings,
        'color': AppColors.blue,
        'bg': AppColors.blue.withOpacity(0.1),
      };
    }
    
    if (categoryLower.contains('reduce') || categoryLower.contains('expense')) {
      return {
        'icon': Icons.trending_down,
        'color': AppColors.orange,
        'bg': AppColors.orange.withOpacity(0.1),
      };
    }
    
    if (categoryLower.contains('client') || categoryLower.contains('customer')) {
      return {
        'icon': Icons.trending_up,
        'color': AppColors.purple,
        'bg': AppColors.purple.withOpacity(0.1),
      };
    }
    
    // Fallback to hash-based for unknown categories
    final iconSets = [
      {'icon': Icons.flag, 'color': AppColors.green},
      {'icon': Icons.star, 'color': AppColors.blue},
      {'icon': Icons.bookmark, 'color': AppColors.purple},
      {'icon': Icons.bolt, 'color': AppColors.orange},
    ];
    
    final index = category.hashCode.abs() % iconSets.length;
    final iconSet = iconSets[index];
    
    return {
      'icon': iconSet['icon'],
      'color': iconSet['color'],
      'bg': (iconSet['color'] as Color).withOpacity(0.1),
    };
  }
}