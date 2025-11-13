import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'colors.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // sample data
    final revenue = 45800;
    final expenses = 12300;
    final netProfit = revenue - expenses;
    final pendingInvoices = 7;
    final overdueInvoices = 2;

    final chartData = [
      {'month': 'Jun', 'revenue': 38000, 'expenses': 11000},
      {'month': 'Jul', 'revenue': 42000, 'expenses': 10500},
      {'month': 'Aug', 'revenue': 39000, 'expenses': 12000},
      {'month': 'Sep', 'revenue': 44000, 'expenses': 11500},
      {'month': 'Oct', 'revenue': 47000, 'expenses': 13000},
      {'month': 'Nov', 'revenue': 45800, 'expenses': 12300},
    ];

    // Add this goals data
    final activeGoals = [
      {'title': 'Monthly Revenue', 'current': 45800, 'target': 55000, 'progress': 83, 'colorType': 'green'},
      {'title': 'Reduce Payment Time', 'current': 18, 'target': 15, 'progress': 80, 'colorType': 'blue'},
      {'title': 'Client Acquisition', 'current': 7, 'target': 10, 'progress': 70, 'colorType': 'orange'},
    ];

    final upcomingPayments = [
      {'client': 'Acme Corp', 'amount': 6500, 'date': 'Nov 14'},
      {'client': 'Global Tech', 'amount': 3200, 'date': 'Nov 15'},
      {'client': 'Creative Agency', 'amount': 4100, 'date': 'Nov 16'},
    ];

    final recentActivity = [
      {'type': 'invoice', 'client': 'TechCorp Inc.', 'amount': 5000, 'time': '2 hours ago'},
      {'type': 'expense', 'description': 'Adobe Creative Cloud', 'amount': -52, 'time': '5 hours ago'},
      {'type': 'payment', 'client': 'Design Studio LLC', 'amount': 3200, 'time': '1 day ago'},
      {'type': 'invoice', 'client': 'StartupXYZ', 'amount': 4500, 'time': '2 days ago'},
    ];

    // Calculate max value for chart scaling
    final maxValue = chartData
        .map((d) => [d['revenue'] as int, d['expenses'] as int])
        .expand((list) => list)
        .reduce((a, b) => a > b ? a : b);

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
                          // welcome header
                          // TODO: Make it dynamic like Goodmorning, evening,... cool greetings
                          Text(
                            'Hello, Jane',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: isDark ? AppColors.darkText : AppColors.lightText,
                            ),
                          ),
                          const SizedBox(height: 24),

                          // stats grid (2x2)
                          GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 1.1,
                            children: [
                              // revenue card
                              _buildStatCard(
                                context: context, 
                                isDark: isDark, 
                                icon: Icons.trending_up, 
                                iconBgColor: AppColors.green.withOpacity(0.1), 
                                iconColor: AppColors.green, 
                                label: 'Revenue', 
                                value: _formatCurrency(revenue), 
                                subtitle: 'This month',
                                trendText: '+12%',
                                trendColor: AppColors.green,
                              ),

                              // expenses card
                              _buildStatCard(
                                context: context, 
                                isDark: isDark, 
                                icon: Icons.trending_down, 
                                iconBgColor: AppColors.orange.withOpacity(0.1), 
                                iconColor: AppColors.orange, 
                                label: 'Expenses', 
                                value: _formatCurrency(expenses), 
                                subtitle: 'This month',
                                trendText: '+5%',
                                trendColor: AppColors.orange,
                              ),

                              // Net Profit Card
                              _buildStatCard(
                                context: context,
                                isDark: isDark,
                                icon: Icons.attach_money,
                                iconBgColor: AppColors.green.withOpacity(0.1),
                                iconColor: AppColors.green,
                                label: 'Net Profit',
                                value: _formatCurrency(netProfit),
                                subtitle: '+${((netProfit / revenue) * 100).toStringAsFixed(1)}% margin',
                              ),
                              
                              // Pending Invoices Card
                              _buildStatCard(
                                context: context,
                                isDark: isDark,
                                icon: Icons.description,
                                iconBgColor: AppColors.blue.withOpacity(0.1),
                                iconColor: AppColors.blue,
                                label: 'Pending',
                                value: '$pendingInvoices',
                                subtitle: '$overdueInvoices overdue',
                                badge: '$overdueInvoices',
                                badgeColor: AppColors.red,
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // average payment time card
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
                            child: Row(
                              children: [
                                // Icon
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: AppColors.purple.withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.access_time,
                                    size: 20,
                                    color: AppColors.purple,
                                  ),
                                ),
                                const SizedBox(width: 12),

                                // text content
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Average Payment Time',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: isDark ? AppColors.darkText : AppColors.lightText,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Induxstry average
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Industry avg',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: isDark ? AppColors.darkTertiaryText : AppColors.lightTertiaryText,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '30 days',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: isDark ? AppColors.darkSecondaryText : AppColors.lightSecondaryText,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),

                          // high-risk clients alert card
                          Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: isDark
                                  ? [
                                    AppColors.red.withOpacity(0.1),
                                    AppColors.orange.withOpacity(0.1),
                                  ]
                                  : [
                                    const Color(0xFFFEF2F2),
                                    const Color(0xFFFFF7ED),
                                  ],
                              ),
                              borderRadius: BorderRadius.circular(16)
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // warning icon
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: isDark ? AppColors.red.withOpacity(0.2) : const Color(0xFFFEE2E2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.warning_amber_rounded,
                                    size: 20,
                                    color: AppColors.red,
                                  ),
                                ),
                                const SizedBox(width: 12),

                                // Content
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // header
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'High-Risk Clients Alert',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.red,
                                            ),
                                          ),
                                          Text(
                                            'AI Detected',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: AppColors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 12),

                                      // risk list
                                      _buildRiskItem('SlowPay Corp', 'Avg 45 days late', AppColors.red),
                                      const SizedBox(height: 8),

                                      _buildRiskItem('Budget Startup', 'Payment trending down', AppColors.red),
                                      const SizedBox(height: 8),

                                      _buildRiskItem('Unreliable LLC', '3 missed payments', AppColors.red),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),

                          // revenue vs expense card
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
                              children: [
                                // header
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Revenue vs Expenses',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: isDark ? AppColors.darkText : AppColors.lightText,
                                      ),
                                    ),
                                    Text(
                                      'Last 6 months',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: isDark ? AppColors.darkTertiaryText : AppColors.lightTertiaryText,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),

                                // chart bars
                                ...chartData.map((data) {
                                  final month = data['month'] as String;
                                  final rev = data['revenue'] as int;
                                  final exp = data['expenses'] as int;

                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: Column(
                                      children: [
                                        // month and values
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
                                              '\$${(rev / 1000).toStringAsFixed(0)}k / \$${(exp / 1000).toStringAsFixed(0)}k',
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: isDark ? AppColors.darkTertiaryText : AppColors.lightTertiaryText,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                 
                                        // Bars
                                        Row(
                                          children: [
                                            // Revenue bar
                                            Flexible(
                                              flex: rev,
                                              child: Container(
                                                height: 32,
                                                decoration: BoxDecoration(
                                                  color: AppColors.green,
                                                  borderRadius: BorderRadius.circular(4),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            // Expenses bar
                                            Flexible(
                                              flex: exp,
                                              child: Container(
                                                height: 32,
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
                                const SizedBox(height: 12),
                                // Legend (THIS WAS ALSO MISSING)
                                Container(
                                  padding: const EdgeInsets.only(top: 12),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                        color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Revenue legend
                                      Row(
                                        children: [
                                          Container(
                                            width: 12,
                                            height: 12,
                                            decoration: BoxDecoration(
                                              color: AppColors.green,
                                              borderRadius: BorderRadius.circular(2),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            'Revenue',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: isDark ? AppColors.darkSecondaryText : AppColors.lightSecondaryText,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 16),
                                      // Expenses legend
                                      Row(
                                        children: [
                                          Container(
                                            width: 12,
                                            height: 12,
                                            decoration: BoxDecoration(
                                              color: AppColors.orange,
                                              borderRadius: BorderRadius.circular(2),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            'Expenses',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: isDark ? AppColors.darkSecondaryText : AppColors.lightSecondaryText,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),

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
                              children: [
                                // Header
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Active Goals Progress',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: isDark ? AppColors.darkText : AppColors.lightText,
                                      ),
                                    ),
                                    Text(
                                      'View All',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.green,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),

                                // Goals list
                                ...activeGoals.map((goal) {
                                  final title = goal['title'] as String;
                                  final progress = goal['progress'] as int;
                                  final colorType = goal['colorType'] as String;
                                  
                                  // Get the actual color based on colorType
                                  final color = colorType == 'green' 
                                      ? AppColors.green 
                                      : colorType == 'blue' 
                                          ? AppColors.blue 
                                          : AppColors.orange;

                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: Column(
                                      children: [
                                        // title and percentage
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              title,
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                                color: isDark ? AppColors.darkText : AppColors.lightText,
                                              ),
                                            ),
                                            Text(
                                              title,
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                                color: color,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),

                                        // Progress bar
                                        Container(
                                          width: double.infinity,
                                          height: 8,
                                          decoration: BoxDecoration(
                                            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: FractionallySizedBox(
                                            alignment: Alignment.centerLeft,
                                            widthFactor: progress / 100,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: color,
                                                borderRadius: BorderRadius.circular(4),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),

                          // upcoming payments
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
                                // header
                                Text(
                                  'Upcoming This Week',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: isDark ? AppColors.darkText : AppColors.lightText,
                                  ),
                                ),
                                const SizedBox(height: 12),

                                // Payments list
                                ...upcomingPayments.map((payment) {
                                  final client = payment['client'] as String;
                                  final amount = payment['amount'] as int;
                                  final date = payment['date'] as String;

                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        // client and date
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              client,
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                                color: isDark ? AppColors.darkText : AppColors.lightText,
                                              ),
                                            ),
                                            const SizedBox(height: 4),

                                            Text(
                                              date,
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: isDark ? AppColors.darkTertiaryText : AppColors.lightTertiaryText,
                                              ),
                                            ),
                                          ],
                                        ),

                                        // amount
                                        Text(
                                          _formatCurrency(amount),
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.green,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                                
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Recent Activity
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
                                // Header
                                Text(
                                  'Recent Activity',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: isDark ? AppColors.darkText : AppColors.lightText,
                                  ),
                                ),
                                const SizedBox(height: 12),

                                // activity list
                                ...recentActivity.map((activity) {
                                  final type = activity['type'] as String;
                                  final amount = activity['amount'] as int;
                                  final time = activity['time'] as String;

                                  // get display name (client or description)
                                  final displayName = activity.containsKey('client')
                                      ? activity['client'] as String
                                      : activity['description'] as String;

                                  // determine icon and color based on type
                                  IconData icon;
                                  Color iconBg;
                                  Color iconColor;

                                  if (type == 'invoice') {
                                    icon = Icons.description;
                                    iconBg = AppColors.blue.withOpacity(0.1);
                                    iconColor = AppColors.blue;
                                  } else if (type == 'expense') {
                                    icon = Icons.trending_down;
                                    iconBg = AppColors.orange.withOpacity(0.1);
                                    iconColor = AppColors.orange;
                                  } else {
                                    icon = Icons.attach_money;
                                    iconBg = AppColors.green.withOpacity(0.1);
                                    iconColor = AppColors.green;
                                  }

                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: Row(
                                      children: [
                                        // icon
                                        Container(
                                          width: 32,
                                          height: 32,
                                          decoration: BoxDecoration(
                                            color: iconBg,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            icon,
                                            size: 16,
                                            color: iconColor,
                                          ),
                                        ),
                                        const SizedBox(width: 12),

                                        // name and time
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                displayName,
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                  color: isDark ? AppColors.darkText : AppColors.lightText,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                time,
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
                                          amount < 0
                                            ? '-${_formatCurrency(amount.abs())}'
                                            : '+${_formatCurrency(amount)}',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: amount < 0 ? AppColors.orange : AppColors.green,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),

                          // quick actions
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // create invoice button
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    // TODO: Navigate to create invoice
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
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 48,
                                          height: 48,
                                          decoration: BoxDecoration(
                                            color: AppColors.green.withOpacity(0.1),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.add,
                                            size: 24,
                                            color: AppColors.green,
                                          ),
                                        ),
                                        const SizedBox(height: 8),

                                        Text(
                                          'Create Invoice',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: isDark ? AppColors.darkText : AppColors.lightText,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),

                              // log expense button
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    // TODO: Navigate to log expense
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
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 48,
                                          height: 48,
                                          decoration: BoxDecoration(
                                            color: AppColors.orange.withOpacity(0.1),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.trending_down,
                                            size: 24,
                                            color: AppColors.orange,
                                          ),
                                        ),
                                        const SizedBox(height: 8),

                                        Text(
                                          'Log Expense',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: isDark ? AppColors.darkText : AppColors.lightText,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),

                              // add clients button
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    // TODO: Navigate to add client
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
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 48,
                                          height: 48,
                                          decoration: BoxDecoration(
                                            color: AppColors.blue.withOpacity(0.1),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.people_alt_rounded,
                                            size: 24,
                                            color: AppColors.blue,
                                          ),
                                        ),
                                        const SizedBox(height: 8),

                                        Text(
                                          'Add Client',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: isDark ? AppColors.darkText : AppColors.lightText,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                            ],
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
      ),
    );
  }

  Widget _buildStatCard({
    required BuildContext context,
    required bool isDark,
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String label,
    required String value,
    required String subtitle,
    String? badge,
    Color? badgeColor,
    String? trendText,
    Color? trendColor,
  }) {

    return Container(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: iconColor,
                ),
              ),

              // trend indicator
              if (trendText != null)
                Row(
                  children: [
                    Icon(
                      Icons.trending_up,
                      size: 12,
                      color: trendColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      trendText,
                      style: TextStyle(
                        fontSize: 12,
                        color: trendColor,
                      ),
                    ),
                  ],
                ),
                if (badge != null) 
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: badgeColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        badge,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
            ],
          ),
          const SizedBox(height: 8),

          // label
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isDark ? AppColors.darkTertiaryText : AppColors.lightTertiaryText,
            ),
          ),
          const SizedBox(height: 4),

          // value
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: isDark ? AppColors.darkText : AppColors.lightText,
            ),
          ),
          const SizedBox(height: 4),

          // subtitle
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 11,
              color: isDark ? AppColors.darkTertiaryText : AppColors.lightTertiaryText,
            ),
          ),
        ],
      ),
    );
  }

  String _formatCurrency(int amount) {
    final formatter = NumberFormat('#,###');
    return '\$${formatter.format(amount)}';
  }

  Widget _buildRiskItem(String name, String reason, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: color,
          ),
        ),
        Text(
          reason,
          style: TextStyle(
            fontSize: 12,
            color: color,
          ),
        ),
      ],
    );
  }
}