import 'package:flutter/material.dart';
import '../colors.dart';

class AIInsightsScreen extends StatelessWidget {
  const AIInsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Quick stats data
    final quickStats = [
      {
        'label': 'Most Reliable',
        'value': 'TechCorp Inc.',
        'metric': 'Avg 12 days',
      },
      {
        'label': 'Riskiest',
        'value': 'SlowPay Corp',
        'metric': 'Risk Score: 85',
      },
      {
        'label': 'Fastest Payer',
        'value': 'Design Studio',
        'metric': 'Avg 8 days',
      },
    ];

    // Payment predictions
    final predictions = [
      {
        'invoice': 'INV-003',
        'client': 'StartupXYZ',
        'amount': 4500,
        'predictedDate': 'Nov 22, 2025',
        'confidence': 87,
        'warning': null,
      },
      {
        'invoice': 'INV-005',
        'client': 'Global Tech',
        'amount': 6500,
        'predictedDate': 'Nov 17, 2025',
        'confidence': 92,
        'warning': null,
      },
      {
        'invoice': 'INV-008',
        'client': 'RetailCo',
        'amount': 3200,
        'predictedDate': 'Dec 28, 2025',
        'confidence': 65,
        'warning': 'Holiday season - expect delays',
      },
    ];

    // Risk alerts
    final riskAlerts = [
      {
        'client': 'SlowPay Corp',
        'riskScore': 85,
        'issue': 'Consistently pays 30-45 days late',
        'recommendation': 'Request 50% upfront payment for new projects',
        'trend': 'worsening',
      },
      {
        'client': 'Budget Startup',
        'riskScore': 72,
        'issue': 'Payment times increasing over last 3 invoices',
        'recommendation': 'Follow up 1 week before due date',
        'trend': 'worsening',
      },
      {
        'client': 'Unreliable LLC',
        'riskScore': 68,
        'issue': '3 late payments in past 6 months',
        'recommendation': 'Consider tighter payment terms',
        'trend': 'stable',
      },
    ];

    // Smart recommendations
    final recommendations = [
      {
        'title': '2 Invoices Overdue',
        'description': 'SlowPay Corp and Budget Startup invoices are past due',
        'action': 'Send payment reminder',
        'icon': Icons.warning,
        'color': AppColors.red,
      },
      {
        'title': 'Follow Up Early',
        'description': 'Creative Agency paid 15 days late last time',
        'action': 'Contact 1 week early',
        'icon': Icons.schedule,
        'color': AppColors.orange,
      },
      {
        'title': 'Below Revenue Goal',
        'description': 'You\'re trending 18% below your monthly target',
        'action': 'Review pricing strategy',
        'icon': Icons.trending_down,
        'color': AppColors.purple,
      },
      {
        'title': 'Holiday Season Alert',
        'description': '3 invoices due during Thanksgiving week',
        'action': 'Expect 5-10 day delays',
        'icon': Icons.calendar_today,
        'color': AppColors.blue,
      },
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
                    Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFFAF52DE),  // Purple
                                Color(0xFF007AFF),  // Blue
                              ],
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.psychology,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'AI Insights',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: isDark ? AppColors.darkText : AppColors.lightText,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),

                    // Quick Stats
                    ...quickStats.map((stat) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _buildQuickStats(stat, isDark),
                      );
                    }).toList(),
                    const SizedBox(height: 16),

                    // Payment Predictions Section
                    Row(
                      children: [
                        Icon(
                          Icons.auto_awesome,
                          size: 20,
                          color: AppColors.green,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Payment Predictions',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isDark ? AppColors.darkText : AppColors.lightText,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Payment Predictions Cards
                    ...predictions.map((prediction) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _buildPredictionCard(prediction, isDark),
                      );
                    }).toList(),
                    const SizedBox(height: 16),

                    // Risk Alerts Section
                    Row(
                      children: [
                        Icon(
                          Icons.warning_amber,
                          size: 20,
                          color: AppColors.red,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Risk Alerts',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isDark ? AppColors.darkText : AppColors.lightText,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Risk Alert Cards
                    ...riskAlerts.map((alert) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _buildRiskAlertCard(alert, isDark),
                      );
                    }).toList(),
                    const SizedBox(height: 16),

                    // Smart Recommendations Section
                    Row(
                      children: [
                        Icon(
                          Icons.lightbulb,
                          size: 20,
                          color: AppColors.purple,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Smart Recommendations',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isDark ? AppColors.darkText : AppColors.lightText,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Recommendation Cards
                    ...recommendations.map((rec) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _buildRecommendationCard(rec, isDark),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickStats(Map<String, dynamic> quickStats, bool isDark) {
    final label = quickStats['label'] as String;
    final value = quickStats['value'] as String;
    final metric = quickStats['metric'] as String;
    
    // Get dynamic style based on label
    final style = _getStatStyle(label);
    final color = style['color'] as Color;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark 
            ? [
                color.withOpacity(0.15),
                color.withOpacity(0.1),
              ]
            : [
                color.withOpacity(0.08),
                color.withOpacity(0.05),
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
          // Icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: style['bg'],
              shape: BoxShape.circle,
            ),
            child: Icon(
              style['icon'],
              size: 24,
              color: style['color'],
            ),
          ),
          const SizedBox(width: 12),
          
          // Text info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    color: isDark ? AppColors.darkTertiaryText : AppColors.lightTertiaryText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.darkText : AppColors.lightText,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  metric,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? AppColors.darkSecondaryText : AppColors.lightSecondaryText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPredictionCard(Map<String, dynamic> prediction, bool isDark) {
    final invoice = prediction['invoice'] as String;
    final client = prediction['client'] as String;
    final amount = prediction['amount'] as int;
    final predictedDate = prediction['predictedDate'] as String;
    final confidence = prediction['confidence'] as int;
    final warning = prediction['warning'] as String?;

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
          // Top row: Invoice + Confidence + Amount
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    invoice,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: isDark ? AppColors.darkTertiaryText : AppColors.lightTertiaryText,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: confidence > 85 
                          ? AppColors.green.withOpacity(0.1)
                          : AppColors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '$confidence% confident',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: confidence > 85 ? AppColors.green : AppColors.orange,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                '\$${amount.toStringAsFixed(0)}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isDark ? AppColors.darkText : AppColors.lightText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Client name
          Text(
            client,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDark ? AppColors.darkText : AppColors.lightText,
            ),
          ),
          const SizedBox(height: 4),

          // Predicted date
          Text(
            'Predicted: $predictedDate',
            style: TextStyle(
              fontSize: 13,
              color: isDark ? AppColors.darkSecondaryText : AppColors.lightSecondaryText,
            ),
          ),

          // Warning (if exists)
          if (warning != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning_amber,
                    size: 16,
                    color: AppColors.orange,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      warning,
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.orange,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRiskAlertCard(Map<String, dynamic> alert, bool isDark) {
    final client = alert['client'] as String;
    final riskScore = alert['riskScore'] as int;
    final issue = alert['issue'] as String;
    final recommendation = alert['recommendation'] as String;
    final trend = alert['trend'] as String;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(16),
        border: Border(
          left: BorderSide(
            color: AppColors.red,
            width: 4,
          ),
        ),
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
          // Client + Risk Score
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  client,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.darkText : AppColors.lightText,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Risk: $riskScore',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.red,
                  ),
                ),
              ),
            ],
          ),
          
          if (trend == 'worsening') ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.trending_down,
                  size: 14,
                  color: AppColors.red,
                ),
                const SizedBox(width: 4),
                Text(
                  'Worsening',
                  style: TextStyle(
                    fontSize: 10,
                    color: AppColors.red,
                  ),
                ),
              ],
            ),
          ],
          
          const SizedBox(height: 12),

          // Issue
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.info_outline,
                size: 16,
                color: isDark ? AppColors.darkTertiaryText : AppColors.lightTertiaryText,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  issue,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? AppColors.darkSecondaryText : AppColors.lightSecondaryText,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Recommendation
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.auto_awesome,
                  size: 16,
                  color: AppColors.green,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    recommendation,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.green,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationCard(Map<String, dynamic> rec, bool isDark) {
    final title = rec['title'] as String;
    final description = rec['description'] as String;
    final action = rec['action'] as String;
    final icon = rec['icon'] as IconData;
    final color = rec['color'] as Color;

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
      child: Row(
        children: [
          // Icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 20,
              color: color,
            ),
          ),
          const SizedBox(width: 12),

          // Content
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
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? AppColors.darkSecondaryText : AppColors.lightSecondaryText,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    action,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> _getStatStyle(String label) {
    switch (label) {
      case 'Most Reliable':
        return {
          'icon': Icons.emoji_events,
          'color': AppColors.green,
          'bg': AppColors.green.withOpacity(0.1),
        };
      case 'Riskiest':
        return {
          'icon': Icons.warning_amber,
          'color': AppColors.red,
          'bg': AppColors.red.withOpacity(0.1),
        };
      case 'Fastest Payer':
        return {
          'icon': Icons.bolt,
          'color': AppColors.blue,
          'bg': AppColors.blue.withOpacity(0.1),
        };
      default:
        return {
          'icon': Icons.analytics,
          'color': AppColors.purple,
          'bg': AppColors.purple.withOpacity(0.1),
        };
    }
  }
}