import 'dart:math' as math;

import 'package:flutter/material.dart';

void main() {
  runApp(const FinPilotApp());
}

class FinPilotApp extends StatelessWidget {
  const FinPilotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FinPilot AI',
      theme: AppTheme.light(),
      home: const AppShell(),
    );
  }
}

class AppTheme {
  static const ink = Color(0xFF10212B);
  static const muted = Color(0xFF657684);
  static const cloud = Color(0xFFF4F7FA);
  static const card = Color(0xFFFFFFFF);
  static const mint = Color(0xFF20C997);
  static const teal = Color(0xFF0E7C86);
  static const coral = Color(0xFFFF6B6B);
  static const amber = Color(0xFFF4B740);
  static const blue = Color(0xFF4D7CFE);
  static const violet = Color(0xFF7C5CFF);

  static ThemeData light() {
    final scheme = ColorScheme.fromSeed(
      seedColor: teal,
      brightness: Brightness.light,
      primary: teal,
      secondary: mint,
      surface: card,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: cloud,
      fontFamily: 'Roboto',
      textTheme: const TextTheme(
        displaySmall: TextStyle(
          color: ink,
          fontSize: 34,
          fontWeight: FontWeight.w800,
          height: 1.05,
        ),
        headlineMedium: TextStyle(
          color: ink,
          fontSize: 26,
          fontWeight: FontWeight.w800,
        ),
        titleLarge: TextStyle(
          color: ink,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
        titleMedium: TextStyle(
          color: ink,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
        bodyLarge: TextStyle(
          color: ink,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        bodyMedium: TextStyle(
          color: muted,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
      cardTheme: CardThemeData(
        color: card,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Colors.black.withValues(alpha: 0.05)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        hintStyle: const TextStyle(color: muted),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.black.withValues(alpha: 0.08)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.black.withValues(alpha: 0.08)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: teal, width: 1.4),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 72,
        elevation: 0,
        backgroundColor: Colors.white,
        indicatorColor: mint.withValues(alpha: 0.16),
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => TextStyle(
            fontSize: 12,
            fontWeight: states.contains(WidgetState.selected)
                ? FontWeight.w800
                : FontWeight.w600,
            color: states.contains(WidgetState.selected) ? teal : muted,
          ),
        ),
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            size: 24,
            color: states.contains(WidgetState.selected) ? teal : muted,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: teal,
          foregroundColor: Colors.white,
          elevation: 0,
          minimumSize: const Size.fromHeight(50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: ink,
          minimumSize: const Size.fromHeight(50),
          side: BorderSide(color: ink.withValues(alpha: 0.12)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;

  static const _pages = <Widget>[
    DashboardScreen(),
    TransactionsScreen(),
    BudgetScreen(),
    AIAdvisorScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final app = Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) =>
            setState(() => _selectedIndex = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.swap_vert_circle_outlined),
            selectedIcon: Icon(Icons.swap_vert_circle),
            label: 'Transactions',
          ),
          NavigationDestination(
            icon: Icon(Icons.pie_chart_outline_rounded),
            selectedIcon: Icon(Icons.pie_chart_rounded),
            label: 'Budget',
          ),
          NavigationDestination(
            icon: Icon(Icons.auto_awesome_outlined),
            selectedIcon: Icon(Icons.auto_awesome),
            label: 'AI',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= 520) {
          return app;
        }

        final frameHeight = math.min(
          920.0,
          math.max(0.0, constraints.maxHeight - 24),
        );

        return DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFEAF3F6), Color(0xFFF8FAFC)],
            ),
          ),
          child: Center(
            child: Container(
              width: 430,
              height: frameHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.ink.withValues(alpha: 0.18),
                    blurRadius: 42,
                    offset: const Offset(0, 24),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: app,
              ),
            ),
          ),
        );
      },
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScrollPage(
      children: [
        const HeaderBar(
          overline: 'Smart Money. Smarter Future.',
          title: 'Good Morning Ahmed',
          subtitle: 'Your finances are on track today.',
        ),
        const SizedBox(height: 18),
        const BalanceCard(),
        const SizedBox(height: 20),
        const QuickInsightStrip(),
        const SizedBox(height: 24),
        const SectionTitle(title: 'Recent Transactions', action: 'View all'),
        const SizedBox(height: 12),
        ...sampleTransactions.map(TransactionRow.new),
        const SizedBox(height: 24),
        const ExpenseBreakdownCard(),
        const SizedBox(height: 18),
        const MonthlySpendingCard(),
      ],
    );
  }
}

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  TransactionType _type = TransactionType.expense;
  String _category = 'Food';
  String _method = 'Card';

  @override
  Widget build(BuildContext context) {
    return AppScrollPage(
      children: [
        const HeaderBar(
          overline: 'Transactions',
          title: 'Add Transaction',
          subtitle: 'Log income, expenses, transfers, and receipts.',
        ),
        const SizedBox(height: 18),
        const ReceiptScannerPanel(),
        const SizedBox(height: 18),
        CardShell(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Transaction Details',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              SegmentedButton<TransactionType>(
                showSelectedIcon: false,
                segments: const [
                  ButtonSegment(
                    value: TransactionType.income,
                    label: Text('Income'),
                    icon: Icon(Icons.trending_up),
                  ),
                  ButtonSegment(
                    value: TransactionType.expense,
                    label: Text('Expense'),
                    icon: Icon(Icons.trending_down),
                  ),
                  ButtonSegment(
                    value: TransactionType.transfer,
                    label: Text('Transfer'),
                    icon: Icon(Icons.compare_arrows),
                  ),
                ],
                selected: {_type},
                onSelectionChanged: (selection) {
                  setState(() => _type = selection.first);
                },
              ),
              const SizedBox(height: 16),
              const TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Amount',
                  prefixText: '\$ ',
                ),
              ),
              const SizedBox(height: 14),
              Text('Category', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: transactionCategories
                    .map(
                      (category) => ChoiceChip(
                        label: Text(category),
                        selected: _category == category,
                        onSelected: (_) => setState(() => _category = category),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 16),
              const TextField(
                minLines: 2,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Description',
                  hintText: 'Example: McDonald receipt, coffee with client',
                ),
              ),
              const SizedBox(height: 14),
              LayoutBuilder(
                builder: (context, constraints) {
                  final useColumns = constraints.maxWidth > 620;
                  final children = [
                    ChoiceField(
                      icon: Icons.calendar_month_outlined,
                      label: 'Date',
                      value: 'Today',
                      onTap: () {},
                    ),
                    ChoiceField(
                      icon: Icons.account_balance_wallet_outlined,
                      label: 'Wallet',
                      value: 'Bank Account',
                      onTap: () {},
                    ),
                  ];
                  if (!useColumns) {
                    return Column(
                      children: [
                        children[0],
                        const SizedBox(height: 12),
                        children[1],
                      ],
                    );
                  }
                  return Row(
                    children: [
                      Expanded(child: children[0]),
                      const SizedBox(width: 12),
                      Expanded(child: children[1]),
                    ],
                  );
                },
              ),
              const SizedBox(height: 14),
              Text(
                'Payment Method',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: paymentMethods
                    .map(
                      (method) => ChoiceChip(
                        avatar: Icon(paymentMethodIcon(method), size: 18),
                        label: Text(method),
                        selected: _method == method,
                        onSelected: (_) => setState(() => _method = method),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.close),
                      label: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Transaction saved locally.'),
                          ),
                        );
                      },
                      icon: const Icon(Icons.check_circle_outline),
                      label: const Text('Save'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScrollPage(
      children: [
        const HeaderBar(
          overline: 'Budget',
          title: 'Plan Every Dollar',
          subtitle: 'Track limits, goals, bills, and subscriptions.',
        ),
        const SizedBox(height: 18),
        const SectionTitle(title: 'Category Budgets', action: 'Add budget'),
        const SizedBox(height: 12),
        ...sampleBudgets.map(BudgetTile.new),
        const SizedBox(height: 24),
        const SectionTitle(title: 'Savings Goals', action: 'Create goal'),
        const SizedBox(height: 12),
        const SavingsGoalsGrid(),
        const SizedBox(height: 24),
        const SectionTitle(title: 'Bills and Subscriptions', action: 'Manage'),
        const SizedBox(height: 12),
        const ReminderPanel(),
      ],
    );
  }
}

class AIAdvisorScreen extends StatelessWidget {
  const AIAdvisorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 18, 20, 8),
            child: HeaderBar(
              overline: 'AI Finance Advisor',
              title: 'Financial Coach',
              subtitle: 'Ask what to save, cut, buy, or plan next.',
            ),
          ),
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 920),
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 16),
                  children: const [
                    WeeklyReportCard(),
                    SizedBox(height: 16),
                    ChatBubble(
                      text: 'I spent too much this month.',
                      isUser: true,
                    ),
                    ChatBubble(
                      text:
                          'You spent 42% more on restaurants. Reduce eating out to twice weekly to save about \$140 this month.',
                      isUser: false,
                    ),
                    ChatBubble(
                      text: 'Can I buy an iPhone this month?',
                      isUser: true,
                    ),
                    ChatBubble(
                      text:
                          'Recommendation: wait one month. Your bills are \$1,600 and your savings ratio is below target.',
                      isUser: false,
                    ),
                    SizedBox(height: 14),
                    PromptChips(),
                  ],
                ),
              ),
            ),
          ),
          const AdvisorInputBar(),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScrollPage(
      children: [
        const ProfileHeader(),
        const SizedBox(height: 20),
        const SectionTitle(title: 'Wallets', action: 'Add wallet'),
        const SizedBox(height: 12),
        ...sampleWallets.map(WalletTile.new),
        const SizedBox(height: 24),
        const PremiumCard(),
        const SizedBox(height: 18),
        const SecurityAndSettingsPanel(),
      ],
    );
  }
}

class AppScrollPage extends StatelessWidget {
  const AppScrollPage({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 920),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
            children: children,
          ),
        ),
      ),
    );
  }
}

class HeaderBar extends StatelessWidget {
  const HeaderBar({
    super.key,
    required this.overline,
    required this.title,
    required this.subtitle,
  });

  final String overline;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                overline.toUpperCase(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.teal,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0,
                ),
              ),
              const SizedBox(height: 6),
              Text(title, style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 4),
              Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
        const SizedBox(width: 12),
        IconButton.filledTonal(
          onPressed: () {},
          tooltip: 'Notifications',
          icon: const Icon(Icons.notifications_none_rounded),
        ),
      ],
    );
  }
}

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF10212B), Color(0xFF0E7C86)],
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.teal.withValues(alpha: 0.16),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Total Balance',
                  style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                tooltip: 'Balance options',
                icon: const Icon(Icons.more_horiz, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            '\$12,450',
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.w900,
              height: 1,
            ),
          ),
          const SizedBox(height: 18),
          LayoutBuilder(
            builder: (context, constraints) {
              final compact = constraints.maxWidth < 540;
              final tiles = const [
                BalanceMetric(
                  icon: Icons.arrow_upward,
                  label: 'Income',
                  value: '\$5,200',
                  color: AppTheme.mint,
                ),
                BalanceMetric(
                  icon: Icons.arrow_downward,
                  label: 'Expense',
                  value: '\$2,900',
                  color: AppTheme.coral,
                ),
                BalanceMetric(
                  icon: Icons.savings_outlined,
                  label: 'Savings',
                  value: '\$8,100',
                  color: AppTheme.amber,
                ),
              ];

              if (compact) {
                return Column(
                  children: [
                    for (var index = 0; index < tiles.length; index++) ...[
                      tiles[index],
                      if (index != tiles.length - 1) const SizedBox(height: 10),
                    ],
                  ],
                );
              }

              return Row(
                children: [
                  for (var index = 0; index < tiles.length; index++) ...[
                    Expanded(child: tiles[index]),
                    if (index != tiles.length - 1) const SizedBox(width: 12),
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class BalanceMetric extends StatelessWidget {
  const BalanceMetric({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class QuickInsightStrip extends StatelessWidget {
  const QuickInsightStrip({super.key});

  @override
  Widget build(BuildContext context) {
    final insights = [
      const InsightItem(
        icon: Icons.bolt_outlined,
        title: 'Weekly savings',
        value: '+\$65',
        color: AppTheme.mint,
      ),
      const InsightItem(
        icon: Icons.warning_amber_rounded,
        title: 'Budget alert',
        value: 'Food 76%',
        color: AppTheme.amber,
      ),
      const InsightItem(
        icon: Icons.event_available_outlined,
        title: 'Next bill',
        value: 'Electricity',
        color: AppTheme.blue,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 620;
        if (compact) {
          return Column(
            children: [
              for (var index = 0; index < insights.length; index++) ...[
                insights[index],
                if (index != insights.length - 1) const SizedBox(height: 10),
              ],
            ],
          );
        }
        return Row(
          children: [
            for (var index = 0; index < insights.length; index++) ...[
              Expanded(child: insights[index]),
              if (index != insights.length - 1) const SizedBox(width: 12),
            ],
          ],
        );
      },
    );
  }
}

class InsightItem extends StatelessWidget {
  const InsightItem({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CardShell(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          IconBadge(icon: icon, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 3),
                Text(
                  value,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.title, this.action});

  final String title;
  final String? action;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(title, style: Theme.of(context).textTheme.titleLarge),
        ),
        if (action != null) TextButton(onPressed: () {}, child: Text(action!)),
      ],
    );
  }
}

class TransactionRow extends StatelessWidget {
  const TransactionRow(this.transaction, {super.key});

  final TransactionRecord transaction;

  @override
  Widget build(BuildContext context) {
    final amountColor = transaction.isIncome ? AppTheme.mint : AppTheme.coral;
    final sign = transaction.isIncome ? '+' : '-';

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: CardShell(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            IconBadge(icon: transaction.icon, color: transaction.color),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    transaction.subtitle,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            Text(
              '$sign\$${transaction.amount.toStringAsFixed(0)}',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: amountColor,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExpenseBreakdownCard extends StatelessWidget {
  const ExpenseBreakdownCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'Expense Pie Chart'),
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (context, constraints) {
              final wide = constraints.maxWidth > 620;
              final chart = SizedBox(
                width: wide ? 220 : 190,
                height: wide ? 220 : 190,
                child: CustomPaint(painter: PieChartPainter(expenseSegments)),
              );
              final legend = Wrap(
                spacing: 10,
                runSpacing: 10,
                children: expenseSegments.map((segment) {
                  return LegendPill(segment: segment);
                }).toList(),
              );

              if (wide) {
                return Row(
                  children: [
                    chart,
                    const SizedBox(width: 24),
                    Expanded(child: legend),
                  ],
                );
              }

              return Column(
                children: [
                  Center(child: chart),
                  const SizedBox(height: 18),
                  legend,
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class MonthlySpendingCard extends StatelessWidget {
  const MonthlySpendingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'Monthly Spending Chart'),
          const SizedBox(height: 12),
          SizedBox(
            height: 220,
            child: CustomPaint(
              painter: MonthlyBarChartPainter(monthlySpending),
              child: const SizedBox.expand(),
            ),
          ),
        ],
      ),
    );
  }
}

class ReceiptScannerPanel extends StatelessWidget {
  const ReceiptScannerPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return CardShell(
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: AppTheme.blue.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.document_scanner_outlined,
              color: AppTheme.blue,
              size: 30,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Receipt Scanner',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  'Scan a receipt to auto-fill store, date, tax, items, and amount.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          IconButton.filled(
            onPressed: () {},
            tooltip: 'Scan receipt',
            icon: const Icon(Icons.camera_alt_outlined),
          ),
        ],
      ),
    );
  }
}

class ChoiceField extends StatelessWidget {
  const ChoiceField({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black.withValues(alpha: 0.08)),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppTheme.teal),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 2),
                  Text(value, style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
            ),
            const Icon(Icons.keyboard_arrow_down_rounded),
          ],
        ),
      ),
    );
  }
}

class BudgetTile extends StatelessWidget {
  const BudgetTile(this.budget, {super.key});

  final BudgetCategory budget;

  @override
  Widget build(BuildContext context) {
    final remaining = budget.limit - budget.spent;
    final progress = budget.spent / budget.limit;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: CardShell(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconBadge(icon: budget.icon, color: budget.color),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        budget.name,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        '\$${budget.spent.toStringAsFixed(0)} spent of \$${budget.limit.toStringAsFixed(0)}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                Text(
                  '\$${remaining.toStringAsFixed(0)} left',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: remaining < 80 ? AppTheme.coral : AppTheme.teal,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                value: progress.clamp(0, 1),
                minHeight: 9,
                backgroundColor: budget.color.withValues(alpha: 0.12),
                valueColor: AlwaysStoppedAnimation<Color>(budget.color),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${(progress * 100).round()}% used',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class SavingsGoalsGrid extends StatelessWidget {
  const SavingsGoalsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth > 660
            ? (constraints.maxWidth - 12) / 2
            : constraints.maxWidth;

        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: sampleGoals.map((goal) {
            final progress = goal.saved / goal.target;
            return SizedBox(
              width: width,
              child: CardShell(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconBadge(icon: goal.icon, color: goal.color),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            goal.name,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        Text(
                          '${(progress * 100).round()}%',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: goal.color,
                                fontWeight: FontWeight.w900,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(
                      '\$${goal.saved.toStringAsFixed(0)} saved of \$${goal.target.toStringAsFixed(0)}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: LinearProgressIndicator(
                        value: progress.clamp(0, 1),
                        minHeight: 8,
                        backgroundColor: goal.color.withValues(alpha: 0.12),
                        valueColor: AlwaysStoppedAnimation<Color>(goal.color),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class ReminderPanel extends StatelessWidget {
  const ReminderPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return CardShell(
      child: Column(
        children: [
          const ReminderRow(
            icon: Icons.flash_on_outlined,
            title: 'Electricity Bill',
            subtitle: 'Due tomorrow',
            amount: '\$86',
            color: AppTheme.amber,
          ),
          Divider(color: Colors.black.withValues(alpha: 0.06), height: 24),
          const ReminderRow(
            icon: Icons.movie_creation_outlined,
            title: 'Netflix',
            subtitle: 'Monthly on the 15th',
            amount: '\$15',
            color: AppTheme.coral,
          ),
          Divider(color: Colors.black.withValues(alpha: 0.06), height: 24),
          const ReminderRow(
            icon: Icons.music_note_outlined,
            title: 'Spotify',
            subtitle: 'Renews in 5 days',
            amount: '\$10',
            color: AppTheme.mint,
          ),
        ],
      ),
    );
  }
}

class ReminderRow extends StatelessWidget {
  const ReminderRow({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String amount;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconBadge(icon: icon, color: color),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 3),
              Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
        Text(amount, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}

class WeeklyReportCard extends StatelessWidget {
  const WeeklyReportCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const IconBadge(
                icon: Icons.auto_graph_outlined,
                color: AppTheme.violet,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AI Weekly Report',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Sunday summary and recommendations',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: const [
              ReportMetric(
                label: 'Spent',
                value: '\$450',
                color: AppTheme.coral,
              ),
              ReportMetric(label: 'Food', value: '35%', color: AppTheme.amber),
              ReportMetric(
                label: 'Shopping',
                value: '20%',
                color: AppTheme.blue,
              ),
              ReportMetric(
                label: 'Save',
                value: '\$65/wk',
                color: AppTheme.mint,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Recommendation: reduce restaurant spending and pause one unused subscription.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}

class ReportMetric extends StatelessWidget {
  const ReportMetric({
    super.key,
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 124,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 6),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.text, required this.isUser});

  final String text;
  final bool isUser;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 620),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: isUser ? AppTheme.teal : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: isUser
              ? null
              : Border.all(color: Colors.black.withValues(alpha: 0.06)),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: isUser ? Colors.white : AppTheme.ink,
          ),
        ),
      ),
    );
  }
}

class PromptChips extends StatelessWidget {
  const PromptChips({super.key});

  @override
  Widget build(BuildContext context) {
    const prompts = [
      'Where am I wasting money?',
      'Build a \$10,000 savings plan',
      'Can I afford this purchase?',
      'Show subscription risks',
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: prompts
          .map(
            (prompt) => ActionChip(
              avatar: const Icon(Icons.auto_awesome, size: 18),
              label: Text(prompt),
              onPressed: () {},
            ),
          )
          .toList(),
    );
  }
}

class AdvisorInputBar extends StatelessWidget {
  const AdvisorInputBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.black.withValues(alpha: 0.06)),
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 920),
          child: Row(
            children: [
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Ask FinPilot AI...',
                    prefixIcon: Icon(Icons.auto_awesome_outlined),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              IconButton.filled(
                onPressed: () {},
                tooltip: 'Send',
                icon: const Icon(Icons.send_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return CardShell(
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppTheme.teal,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text(
                'A',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ahmed Khan',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  'Premium trial - Diamond saver level',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            tooltip: 'Edit profile',
            icon: const Icon(Icons.edit_outlined),
          ),
        ],
      ),
    );
  }
}

class WalletTile extends StatelessWidget {
  const WalletTile(this.wallet, {super.key});

  final WalletInfo wallet;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: CardShell(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            IconBadge(icon: wallet.icon, color: wallet.color),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    wallet.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    wallet.currency,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            Text(
              '\$${wallet.balance.toStringAsFixed(0)}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class PremiumCard extends StatelessWidget {
  const PremiumCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppTheme.ink,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppTheme.amber.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.workspace_premium,
                  color: AppTheme.amber,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'FinPilot Premium',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const Text(
                '\$4.99/mo',
                style: TextStyle(
                  color: AppTheme.amber,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              PremiumFeature('Unlimited wallets'),
              PremiumFeature('AI advisor'),
              PremiumFeature('Receipt OCR'),
              PremiumFeature('Cloud backup'),
              PremiumFeature('Advanced analytics'),
              PremiumFeature('Family accounts'),
            ],
          ),
        ],
      ),
    );
  }
}

class PremiumFeature extends StatelessWidget {
  const PremiumFeature(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class SecurityAndSettingsPanel extends StatelessWidget {
  const SecurityAndSettingsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    const items = [
      SettingsItem(
        icon: Icons.fingerprint,
        title: 'App Lock',
        subtitle: 'PIN, fingerprint, and face unlock',
        color: AppTheme.teal,
      ),
      SettingsItem(
        icon: Icons.cloud_sync_outlined,
        title: 'Cloud Sync',
        subtitle: 'Encrypted backup across devices',
        color: AppTheme.blue,
      ),
      SettingsItem(
        icon: Icons.notifications_active_outlined,
        title: 'Smart Notifications',
        subtitle: 'Bills, budget alerts, and salary received',
        color: AppTheme.amber,
      ),
      SettingsItem(
        icon: Icons.download_outlined,
        title: 'Export Data',
        subtitle: 'PDF, Excel, and CSV reports',
        color: AppTheme.mint,
      ),
    ];

    return CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Security and Settings',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 14),
          for (var index = 0; index < items.length; index++) ...[
            items[index],
            if (index != items.length - 1)
              Divider(color: Colors.black.withValues(alpha: 0.06), height: 24),
          ],
        ],
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  const SettingsItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconBadge(icon: icon, color: color),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 3),
              Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
        const Icon(Icons.chevron_right_rounded),
      ],
    );
  }
}

class CardShell extends StatelessWidget {
  const CardShell({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(padding: padding, child: child),
    );
  }
}

class IconBadge extends StatelessWidget {
  const IconBadge({super.key, required this.icon, required this.color});

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: color, size: 23),
    );
  }
}

class LegendPill extends StatelessWidget {
  const LegendPill({super.key, required this.segment});

  final ChartSegment segment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: segment.color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 9,
            height: 9,
            decoration: BoxDecoration(
              color: segment.color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '${segment.label} ${segment.value.toStringAsFixed(0)}%',
            style: const TextStyle(
              color: AppTheme.ink,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class PieChartPainter extends CustomPainter {
  PieChartPainter(this.segments);

  final List<ChartSegment> segments;

  @override
  void paint(Canvas canvas, Size size) {
    final total = segments.fold<double>(0, (sum, item) => sum + item.value);
    final rect = Offset.zero & size;
    final paint = Paint()..style = PaintingStyle.fill;
    var start = -math.pi / 2;

    for (final segment in segments) {
      final sweep = (segment.value / total) * math.pi * 2;
      paint.color = segment.color;
      canvas.drawArc(rect.deflate(8), start, sweep, true, paint);
      start += sweep;
    }

    paint.color = Colors.white;
    canvas.drawCircle(
      size.center(Offset.zero),
      size.shortestSide * 0.27,
      paint,
    );

    final textPainter = TextPainter(
      text: const TextSpan(
        text: '100%\nTracked',
        style: TextStyle(
          color: AppTheme.ink,
          fontWeight: FontWeight.w900,
          fontSize: 18,
          height: 1.15,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width * 0.45);

    textPainter.paint(
      canvas,
      Offset(
        (size.width - textPainter.width) / 2,
        (size.height - textPainter.height) / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant PieChartPainter oldDelegate) {
    return oldDelegate.segments != segments;
  }
}

class MonthlyBarChartPainter extends CustomPainter {
  MonthlyBarChartPainter(this.items);

  final List<MonthlySpend> items;

  @override
  void paint(Canvas canvas, Size size) {
    final maxValue = items.map((item) => item.amount).reduce(math.max);
    final chartHeight = size.height - 46;
    final barWidth = math.min(48.0, (size.width / items.length) * 0.46);
    final paint = Paint()..style = PaintingStyle.fill;
    final labelStyle = const TextStyle(
      color: AppTheme.muted,
      fontSize: 12,
      fontWeight: FontWeight.w700,
    );

    final gridPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.06)
      ..strokeWidth = 1;

    for (var i = 0; i < 4; i++) {
      final y = 12 + (chartHeight / 3) * i;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    for (var index = 0; index < items.length; index++) {
      final item = items[index];
      final centerX =
          (size.width / items.length) * index + (size.width / items.length) / 2;
      final height = (item.amount / maxValue) * (chartHeight - 18);
      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(
          centerX - barWidth / 2,
          chartHeight - height + 10,
          barWidth,
          height,
        ),
        const Radius.circular(8),
      );

      paint.color = index == items.length - 1 ? AppTheme.teal : AppTheme.blue;
      canvas.drawRRect(rect, paint);

      final amountPainter = TextPainter(
        text: TextSpan(
          text: '\$${item.amount.toStringAsFixed(0)}',
          style: labelStyle.copyWith(color: AppTheme.ink),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      )..layout();
      amountPainter.paint(
        canvas,
        Offset(centerX - amountPainter.width / 2, chartHeight - height - 10),
      );

      final labelPainter = TextPainter(
        text: TextSpan(text: item.label, style: labelStyle),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      )..layout();
      labelPainter.paint(
        canvas,
        Offset(centerX - labelPainter.width / 2, size.height - 24),
      );
    }
  }

  @override
  bool shouldRepaint(covariant MonthlyBarChartPainter oldDelegate) {
    return oldDelegate.items != items;
  }
}

enum TransactionType { income, expense, transfer }

class TransactionRecord {
  const TransactionRecord({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.isIncome,
    required this.icon,
    required this.color,
  });

  final String title;
  final String subtitle;
  final double amount;
  final bool isIncome;
  final IconData icon;
  final Color color;
}

class BudgetCategory {
  const BudgetCategory({
    required this.name,
    required this.limit,
    required this.spent,
    required this.icon,
    required this.color,
  });

  final String name;
  final double limit;
  final double spent;
  final IconData icon;
  final Color color;
}

class GoalInfo {
  const GoalInfo({
    required this.name,
    required this.target,
    required this.saved,
    required this.icon,
    required this.color,
  });

  final String name;
  final double target;
  final double saved;
  final IconData icon;
  final Color color;
}

class WalletInfo {
  const WalletInfo({
    required this.name,
    required this.currency,
    required this.balance,
    required this.icon,
    required this.color,
  });

  final String name;
  final String currency;
  final double balance;
  final IconData icon;
  final Color color;
}

class ChartSegment {
  const ChartSegment({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final double value;
  final Color color;
}

class MonthlySpend {
  const MonthlySpend({required this.label, required this.amount});

  final String label;
  final double amount;
}

const sampleTransactions = [
  TransactionRecord(
    title: 'Netflix',
    subtitle: 'Subscription renewal',
    amount: 15,
    isIncome: false,
    icon: Icons.movie_outlined,
    color: AppTheme.coral,
  ),
  TransactionRecord(
    title: 'Salary',
    subtitle: 'Bank account',
    amount: 1200,
    isIncome: true,
    icon: Icons.account_balance_outlined,
    color: AppTheme.mint,
  ),
  TransactionRecord(
    title: 'Starbucks',
    subtitle: 'Coffee',
    amount: 6,
    isIncome: false,
    icon: Icons.local_cafe_outlined,
    color: AppTheme.amber,
  ),
  TransactionRecord(
    title: 'Amazon',
    subtitle: 'Shopping',
    amount: 42,
    isIncome: false,
    icon: Icons.shopping_bag_outlined,
    color: AppTheme.blue,
  ),
];

const expenseSegments = [
  ChartSegment(label: 'Food', value: 35, color: AppTheme.amber),
  ChartSegment(label: 'Transport', value: 15, color: AppTheme.teal),
  ChartSegment(label: 'Shopping', value: 20, color: AppTheme.blue),
  ChartSegment(label: 'Bills', value: 12, color: AppTheme.coral),
  ChartSegment(label: 'Health', value: 10, color: AppTheme.mint),
  ChartSegment(label: 'Others', value: 8, color: AppTheme.violet),
];

const monthlySpending = [
  MonthlySpend(label: 'Jan', amount: 1900),
  MonthlySpend(label: 'Feb', amount: 2400),
  MonthlySpend(label: 'Mar', amount: 2100),
  MonthlySpend(label: 'Apr', amount: 2900),
];

const transactionCategories = [
  'Food',
  'Bills',
  'Shopping',
  'Fuel',
  'Entertainment',
  'Salary',
  'Investment',
  'Medical',
  'Education',
  'Travel',
];

const paymentMethods = ['Cash', 'Card', 'Bank', 'UPI', 'Crypto'];

IconData paymentMethodIcon(String method) {
  return switch (method) {
    'Cash' => Icons.payments_outlined,
    'Card' => Icons.credit_card,
    'Bank' => Icons.account_balance_outlined,
    'UPI' => Icons.qr_code_2_outlined,
    'Crypto' => Icons.currency_exchange,
    _ => Icons.wallet_outlined,
  };
}

const sampleBudgets = [
  BudgetCategory(
    name: 'Food Budget',
    limit: 500,
    spent: 380,
    icon: Icons.restaurant_outlined,
    color: AppTheme.amber,
  ),
  BudgetCategory(
    name: 'Shopping',
    limit: 350,
    spent: 210,
    icon: Icons.shopping_bag_outlined,
    color: AppTheme.blue,
  ),
  BudgetCategory(
    name: 'Fuel and Travel',
    limit: 260,
    spent: 170,
    icon: Icons.local_gas_station_outlined,
    color: AppTheme.teal,
  ),
  BudgetCategory(
    name: 'Bills',
    limit: 600,
    spent: 515,
    icon: Icons.receipt_long_outlined,
    color: AppTheme.coral,
  ),
];

const sampleGoals = [
  GoalInfo(
    name: 'Buy Car',
    target: 20000,
    saved: 8200,
    icon: Icons.directions_car_outlined,
    color: AppTheme.blue,
  ),
  GoalInfo(
    name: 'Vacation',
    target: 3500,
    saved: 1400,
    icon: Icons.flight_takeoff_outlined,
    color: AppTheme.mint,
  ),
  GoalInfo(
    name: 'Laptop',
    target: 1800,
    saved: 960,
    icon: Icons.laptop_mac_outlined,
    color: AppTheme.violet,
  ),
  GoalInfo(
    name: 'Emergency Fund',
    target: 10000,
    saved: 6200,
    icon: Icons.health_and_safety_outlined,
    color: AppTheme.coral,
  ),
];

const sampleWallets = [
  WalletInfo(
    name: 'Cash',
    currency: 'USD',
    balance: 420,
    icon: Icons.payments_outlined,
    color: AppTheme.mint,
  ),
  WalletInfo(
    name: 'Bank Account',
    currency: 'USD',
    balance: 8450,
    icon: Icons.account_balance_outlined,
    color: AppTheme.teal,
  ),
  WalletInfo(
    name: 'Credit Card',
    currency: 'USD',
    balance: -890,
    icon: Icons.credit_card,
    color: AppTheme.coral,
  ),
  WalletInfo(
    name: 'Savings',
    currency: 'USD',
    balance: 8100,
    icon: Icons.savings_outlined,
    color: AppTheme.amber,
  ),
];
