import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'colors.dart';
import 'screens/create_invoice.dart';

class InvoicesClientsScreen extends StatefulWidget {
  const InvoicesClientsScreen({super.key});

  @override
  State<InvoicesClientsScreen> createState() => _InvoicesClientsScreenState();
}

class _InvoicesClientsScreenState extends State<InvoicesClientsScreen> {
  // State variables
  String _activeTab = 'invoices'; // invoices or clients as active tab
  String _invoiceFilter = 'all'; // all, sent, paid, overdue
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Sample invoices data
    final invoices = [
      {'id': 'INV-001', 'client': 'TechCorp Inc.', 'amount': 5000, 'status': 'paid', 'dueDate': 'Nov 10, 2025', 'paidDate': 'Nov 08, 2025'},
      {'id': 'INV-002', 'client': 'Design Studio LLC', 'amount': 3200, 'status': 'paid', 'dueDate': 'Nov 05, 2025', 'paidDate': 'Nov 05, 2025'},
      {'id': 'INV-003', 'client': 'StartupXYZ', 'amount': 4500, 'status': 'sent', 'dueDate': 'Nov 20, 2025'},
      {'id': 'INV-004', 'client': 'SlowPay Corp', 'amount': 2800, 'status': 'overdue', 'dueDate': 'Oct 28, 2025'},
      {'id': 'INV-005', 'client': 'Global Tech', 'amount': 6500, 'status': 'sent', 'dueDate': 'Nov 15, 2025'},
    ];

    // Sample clients data
    final clients = [
      {'name': 'TechCorp Inc.', 'riskScore': 15, 'totalRevenue': 24500, 'avgPaymentTime': 12, 'trend': 'up', 'invoiceCount': 8},
      {'name': 'Design Studio LLC', 'riskScore': 22, 'totalRevenue': 18200, 'avgPaymentTime': 15, 'trend': 'stable', 'invoiceCount': 6},
      {'name': 'SlowPay Corp', 'riskScore': 85, 'totalRevenue': 12400, 'avgPaymentTime': 45, 'trend': 'down', 'invoiceCount': 5},
      {'name': 'Global Tech', 'riskScore': 18, 'totalRevenue': 32000, 'avgPaymentTime': 14, 'trend': 'up', 'invoiceCount': 12},
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
                          // header
                          Text(
                            'Invoices & Clients',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: isDark ? AppColors.darkText : AppColors.lightText,
                            ),
                          ),
                          const SizedBox(height: 6),

                          // tab switcher
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                // invoices tab
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _activeTab = 'invoices';
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                      decoration: BoxDecoration(
                                        color: _activeTab == 'invoices'
                                            ? (isDark ? AppColors.darkCard : AppColors.lightCard)
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        'Invoices',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: _activeTab == 'invoices'
                                               ? (isDark ? AppColors.darkText : AppColors.lightText)
                                               : (isDark ? AppColors.darkSecondaryText : AppColors.lightSecondaryText),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                // clients tab
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _activeTab = 'clients';
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                      decoration: BoxDecoration(
                                        color: _activeTab == 'clients'
                                            ? (isDark ? AppColors.darkCard : AppColors.lightCard)
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        'Clients',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: _activeTab == 'clients'
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

                          // search bar
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF2F2F7),
                              borderRadius: BorderRadius.circular(12),
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
                                Icon(
                                  Icons.search,
                                  size: 20,
                                  color: isDark ? AppColors.darkTertiaryText : AppColors.lightTertiaryText,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        _searchQuery = value;
                                      });
                                    },
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: isDark ? AppColors.darkText : AppColors.lightText,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Search $_activeTab...',
                                      hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: isDark ? AppColors.darkTertiaryText : AppColors.lightTertiaryText,
                                      ),
                                      border: InputBorder.none,
                                      isDense: true,
                                      contentPadding: EdgeInsets.zero,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Content based on active tab
                          if (_activeTab == 'invoices') ...[
                            // Filter Buttons
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              child: Row(
                                children: [
                                  _buildFilterButton('all', 'All', isDark),
                                  const SizedBox(width: 8),
                                  _buildFilterButton('sent', 'Sent', isDark),
                                  const SizedBox(width: 8),
                                  _buildFilterButton('paid', 'Paid', isDark),
                                  const SizedBox(width: 8),
                                  _buildFilterButton('overdue', 'Overdue', isDark),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Create Invoice Button
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context, 
                                  MaterialPageRoute(
                                    builder: (context) => CreateInvoiceScreen(
                                      onBack: () => Navigator.pop(context),
                                      onSave: (invoiceData, isDraft) {
                                        if (isDraft) {
                                          print('Invoice saved as draft: $invoiceData');
                                        } else {
                                          print('Invoice created: $invoiceData');
                                        }
                                        // TODO: call API
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                );
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
                                        color: AppColors.green.withOpacity(0.1),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        size: 20,
                                        color: AppColors.green,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      'Create New Invoice',
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

                            // Invoice List
                            ...invoices.where((invoice) {
                              // Filter by status
                              final matchesFilter = _invoiceFilter == 'all' || invoice['status'] == _invoiceFilter;
                              // Filter by search
                              final client = invoice['client'] as String;
                              final id = invoice['id'] as String;
                              final matchesSearch = _searchQuery.isEmpty ||
                                  client.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                                  id.toLowerCase().contains(_searchQuery.toLowerCase());
                              return matchesFilter && matchesSearch;
                            }).map((invoice) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: _buildInvoiceCard(invoice, isDark),
                              );
                            }).toList(),
                          ] else ...[
                            // Clients list
                            ...clients.where((client) {
                              // filter by search
                              final name = client['name'] as String;
                              final matchesSearch = _searchQuery.isEmpty || 
                                  name.toLowerCase().contains(_searchQuery.toLowerCase());
                              return matchesSearch;
                            }).map((client) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: _buildClientCard(client, isDark),
                              );
                            }).toList(),
                          ],
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ),
      ),
    );
  }

  Widget _buildFilterButton(String value, String label, bool isDark) {
    final isSelected = _invoiceFilter == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          _invoiceFilter = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected 
              ? AppColors.green 
              : (isDark ? AppColors.darkCard : AppColors.lightCard),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isSelected 
                ? Colors.white 
                : (isDark ? AppColors.darkSecondaryText : AppColors.lightSecondaryText),
          ),
        ),
      ),
    );
  }

  String _formatCurrency(int amount) {
    final formatter = NumberFormat('#,###');
    return '\$${formatter.format(amount)}';
  }

  Map<String, dynamic> _getRiskColor(int riskScore) {
    if (riskScore < 30) {
      return {
        'bg': const Color(0xFFE8F8EE),  // Light green
        'color': AppColors.green,
        'label': 'Low',
      };
    } else if (riskScore < 60) {
      return {
        'bg': const Color(0xFFFFF3E0),  // Light orange
        'color': AppColors.orange,
        'label': 'Medium',
      };
    } else {
      return {
        'bg': const Color(0xFFFFE5E5),  // Light red
        'color': AppColors.red,
        'label': 'High',
      };
    }
  }

  Widget _buildClientCard(Map<String, dynamic> client, bool isDark) {
    final name = client['name'] as String;
    final riskScore = client['riskScore'] as int;
    final totalRevenue = client['totalRevenue'] as int;
    final avgPaymentTime = client['avgPaymentTime'] as int;
    final trend = client['trend'] as String;
    final invoiceCount = client['invoiceCount'] as int;

    // risk color info
    final riskInfo = _getRiskColor(riskScore);
    // Get trend icon and color
    IconData trendIcon;
    Color trendColor;
    
    if (trend == 'up') {
      trendIcon = Icons.trending_up;
      trendColor = AppColors.green;
    } else if (trend == 'down') {
      trendIcon = Icons.trending_down;
      trendColor = AppColors.red;
    } else {
      trendIcon = Icons.remove;
      trendColor = isDark ? AppColors.darkTertiaryText : AppColors.lightTertiaryText;
    }
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
          // Top Row: client name, risk card, trend icon, chevron
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Client name
                    Row(
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: isDark ? AppColors.darkText : AppColors.lightText,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                
                    // risk badge + trend icon
                    Row(
                      children: [
                        // risk badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: riskInfo['bg'],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${riskInfo['label']} Risk',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: riskInfo['color'],
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),

                        // trend icon
                        Icon(
                          trendIcon,
                          size: 14,
                          color: trendColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                size: 20,
                color: isDark ? AppColors.darkTertiaryText : AppColors.lightTertiaryText,
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // divider
          Container(
            height: 1,
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          ),
          const SizedBox(height: 12),
          

          // Bottom row: total revenue, avg payment, invoices
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              // total revenue
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Revenue',
                    style: TextStyle(
                      fontSize: 10,
                      color: isDark ? AppColors.darkTertiaryText : AppColors.lightTertiaryText,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${(totalRevenue / 1000).toStringAsFixed(1)}k',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isDark ? AppColors.darkText : AppColors.lightText
                    ),
                  ),
                ],
              ),

              // avg payment
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Avg Payment',
                    style: TextStyle(
                      fontSize: 10,
                      color: isDark ? AppColors.darkTertiaryText : AppColors.lightTertiaryText,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${avgPaymentTime}d',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isDark ? AppColors.darkText : AppColors.lightText,
                    ),
                  ),
                ],
              ),

              // Invoices
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Invoices',
                    style: TextStyle(
                      fontSize: 10,
                      color: isDark ? AppColors.darkTertiaryText : AppColors.lightTertiaryText,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$invoiceCount',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isDark ? AppColors.darkText : AppColors.lightText,
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
  Widget _buildInvoiceCard(Map<String, dynamic> invoice, bool isDark) {
    final id = invoice['id'] as String;
    final client = invoice['client'] as String;
    final amount = invoice['amount'] as int;
    final status = invoice['status'] as String;
    final dueDate = invoice['dueDate'] as String;
    final paidDate = invoice['paidDate'] as String?;

    // Get status icon and color
    IconData statusIcon;
    Color statusColor;
    
    switch (status) {
      case 'paid':
        statusIcon = Icons.check_circle;
        statusColor = AppColors.green;
        break;
      case 'sent':
        statusIcon = Icons.access_time;
        statusColor = AppColors.blue;
        break;
      case 'overdue':
        statusIcon = Icons.warning_amber_rounded;
        statusColor = AppColors.red;
        break;
      default:
        statusIcon = Icons.description;
        statusColor = AppColors.blue;
    }

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
          // Top row: ID + status icon, client name, chevron
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Invoice ID + Status Icon
                    Row(
                      children: [
                        Text(
                          id,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: isDark ? AppColors.darkTertiaryText : AppColors.lightTertiaryText,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          statusIcon,
                          size: 16,
                          color: statusColor,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    // Client name
                    Text(
                      client,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: isDark ? AppColors.darkText : AppColors.lightText,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                size: 20,
                color: isDark ? AppColors.darkTertiaryText : AppColors.lightTertiaryText,
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Bottom row: Amount and Due Date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Amount
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Amount',
                    style: TextStyle(
                      fontSize: 11,
                      color: isDark ? AppColors.darkTertiaryText : AppColors.lightTertiaryText,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatCurrency(amount),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isDark ? AppColors.darkText : AppColors.lightText,
                    ),
                  ),
                ],
              ),
              // Due Date
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Due Date',
                    style: TextStyle(
                      fontSize: 11,
                      color: isDark ? AppColors.darkTertiaryText : AppColors.lightTertiaryText,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    dueDate,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: status == 'overdue' ? AppColors.red : (isDark ? AppColors.darkText : AppColors.lightText),
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Paid date (only for paid invoices)
          if (status == 'paid' && paidDate != null) ...[
            const SizedBox(height: 12),
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
              child: Text(
                'Paid on $paidDate',
                style: TextStyle(
                  fontSize: 11,
                  color: isDark ? AppColors.darkTertiaryText : AppColors.lightTertiaryText,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
