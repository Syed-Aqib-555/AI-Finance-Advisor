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
      title: 'FinPilot Finance',
      theme: AppTheme.light(),
      home: const AppRoot(),
    );
  }
}

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  UserProfile? _user;
  final List<FinanceEntry> _entries = [];

  void _completeAccount(UserProfile profile) {
    setState(() {
      _user = profile;
      _entries.clear();
    });
  }

  void _addEntry(FinanceEntry entry) {
    setState(() {
      _entries.insert(0, entry);
    });
  }

  void _logout() {
    setState(() {
      _user = null;
      _entries.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = _user;
    if (user == null) {
      return AccountGate(onComplete: _completeAccount);
    }

    return AppShell(
      user: user,
      entries: _entries,
      onAddEntry: _addEntry,
      onLogout: _logout,
    );
  }
}

class AppTheme {
  static const ink = Color(0xFF101820);
  static const muted = Color(0xFF687782);
  static const cloud = Color(0xFFF3F6F8);
  static const card = Color(0xFFFFFFFF);
  static const emerald = Color(0xFF13A66B);
  static const teal = Color(0xFF087E8B);
  static const coral = Color(0xFFEA5455);
  static const amber = Color(0xFFF6A623);
  static const blue = Color(0xFF3B73F6);
  static const violet = Color(0xFF7768D8);

  static ThemeData light() {
    final scheme = ColorScheme.fromSeed(
      seedColor: teal,
      brightness: Brightness.light,
      primary: teal,
      secondary: emerald,
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
          fontWeight: FontWeight.w900,
          height: 1.05,
        ),
        headlineMedium: TextStyle(
          color: ink,
          fontSize: 26,
          fontWeight: FontWeight.w900,
        ),
        titleLarge: TextStyle(
          color: ink,
          fontSize: 20,
          fontWeight: FontWeight.w900,
        ),
        titleMedium: TextStyle(
          color: ink,
          fontSize: 16,
          fontWeight: FontWeight.w800,
        ),
        bodyLarge: TextStyle(
          color: ink,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
        bodyMedium: TextStyle(
          color: muted,
          fontSize: 13,
          fontWeight: FontWeight.w600,
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
      cardTheme: CardThemeData(
        color: card,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Colors.black.withValues(alpha: 0.05)),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: teal,
          foregroundColor: Colors.white,
          elevation: 0,
          minimumSize: const Size.fromHeight(50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: ink,
          minimumSize: const Size.fromHeight(50),
          side: BorderSide(color: ink.withValues(alpha: 0.12)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 72,
        elevation: 0,
        backgroundColor: Colors.white,
        indicatorColor: emerald.withValues(alpha: 0.16),
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => TextStyle(
            fontSize: 12,
            fontWeight: states.contains(WidgetState.selected)
                ? FontWeight.w900
                : FontWeight.w700,
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
      chipTheme: ChipThemeData(
        backgroundColor: Colors.white,
        selectedColor: emerald.withValues(alpha: 0.14),
        checkmarkColor: teal,
        side: BorderSide(color: ink.withValues(alpha: 0.08)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        labelStyle: const TextStyle(fontWeight: FontWeight.w800),
      ),
    );
  }
}

class AccountGate extends StatefulWidget {
  const AccountGate({super.key, required this.onComplete});

  final ValueChanged<UserProfile> onComplete;

  @override
  State<AccountGate> createState() => _AccountGateState();
}

class _AccountGateState extends State<AccountGate> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: 'Ahmed Khan');
  final _emailController = TextEditingController(text: 'ahmed@example.com');
  final _passwordController = TextEditingController();
  final _startingBalanceController = TextEditingController(text: '25000');
  final _monthlyIncomeController = TextEditingController(text: '120000');
  final _savingGoalController = TextEditingController(text: '20000');
  final _incomeSourceController = TextEditingController(text: 'Salary');
  final _walletController = TextEditingController(text: 'Bank Account');
  String _currency = 'PKR';
  bool _isRegister = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _startingBalanceController.dispose();
    _monthlyIncomeController.dispose();
    _savingGoalController.dispose();
    _incomeSourceController.dispose();
    _walletController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final emailName = _emailController.text.trim().split('@').first;
    final profile = UserProfile(
      fullName: _isRegister
          ? _nameController.text.trim()
          : titleCase(emailName),
      email: _emailController.text.trim(),
      currency: _currency,
      primaryWallet: _walletController.text.trim(),
      mainIncomeSource: _incomeSourceController.text.trim(),
      startingBalance: parseMoney(_startingBalanceController.text),
      monthlyIncomeTarget: parseMoney(_monthlyIncomeController.text),
      monthlySavingGoal: parseMoney(_savingGoalController.text),
    );

    widget.onComplete(profile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 980),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
              children: [
                const BrandHeader(),
                const SizedBox(height: 20),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final wide = constraints.maxWidth > 760;
                    final form = AccountFormCard(
                      formKey: _formKey,
                      isRegister: _isRegister,
                      nameController: _nameController,
                      emailController: _emailController,
                      passwordController: _passwordController,
                      startingBalanceController: _startingBalanceController,
                      monthlyIncomeController: _monthlyIncomeController,
                      savingGoalController: _savingGoalController,
                      incomeSourceController: _incomeSourceController,
                      walletController: _walletController,
                      currency: _currency,
                      onCurrencyChanged: (value) {
                        setState(() => _currency = value ?? _currency);
                      },
                      onSubmit: _submit,
                      onToggleMode: () {
                        setState(() => _isRegister = !_isRegister);
                      },
                    );
                    if (!wide) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const AccountPreviewCard(),
                          const SizedBox(height: 16),
                          form,
                        ],
                      );
                    }

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(child: AccountPreviewCard()),
                        const SizedBox(width: 16),
                        Expanded(child: form),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BrandHeader extends StatelessWidget {
  const BrandHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            color: AppTheme.ink,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.account_balance_wallet_outlined,
            color: Colors.white,
            size: 28,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'FinPilot Finance',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 3),
              Text(
                'Personal cash flow tracking from your own records.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AccountPreviewCard extends StatelessWidget {
  const AccountPreviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CardShell(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppTheme.emerald.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.person_add_alt, color: AppTheme.emerald),
          ),
          const SizedBox(height: 18),
          Text(
            'Start with your account',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Create a local profile, add your opening balance, income target, wallet, and saving goal. The app then tracks every income and expense you enter.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),
          const FeatureLine(
            icon: Icons.arrow_downward_rounded,
            title: 'Incoming cash',
            subtitle: 'Salary, business, freelance, gifts, investment returns.',
            color: AppTheme.emerald,
          ),
          const SizedBox(height: 14),
          const FeatureLine(
            icon: Icons.arrow_upward_rounded,
            title: 'Outgoing cash',
            subtitle: 'Food, bills, shopping, transport, medical, education.',
            color: AppTheme.coral,
          ),
          const SizedBox(height: 14),
          const FeatureLine(
            icon: Icons.travel_explore_rounded,
            title: 'Where money went',
            subtitle: 'Category totals show what you spent on and why.',
            color: AppTheme.blue,
          ),
        ],
      ),
    );
  }
}

class AccountFormCard extends StatelessWidget {
  const AccountFormCard({
    super.key,
    required this.formKey,
    required this.isRegister,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.startingBalanceController,
    required this.monthlyIncomeController,
    required this.savingGoalController,
    required this.incomeSourceController,
    required this.walletController,
    required this.currency,
    required this.onCurrencyChanged,
    required this.onSubmit,
    required this.onToggleMode,
  });

  final GlobalKey<FormState> formKey;
  final bool isRegister;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController startingBalanceController;
  final TextEditingController monthlyIncomeController;
  final TextEditingController savingGoalController;
  final TextEditingController incomeSourceController;
  final TextEditingController walletController;
  final String currency;
  final ValueChanged<String?> onCurrencyChanged;
  final VoidCallback onSubmit;
  final VoidCallback onToggleMode;

  @override
  Widget build(BuildContext context) {
    return CardShell(
      padding: const EdgeInsets.all(18),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              isRegister ? 'Create your account' : 'Login to your tracker',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 6),
            Text(
              'All numbers come from the user. No bank connection or external service is required.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 18),
            if (isRegister) ...[
              TextFormField(
                key: const Key('nameField'),
                controller: nameController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Full name',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: requiredValidator,
              ),
              const SizedBox(height: 12),
            ],
            TextFormField(
              key: const Key('emailField'),
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email_outlined),
              ),
              validator: (value) {
                final text = value?.trim() ?? '';
                if (text.isEmpty) return 'Email is required';
                if (!text.contains('@')) return 'Enter a valid email';
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              key: const Key('passwordField'),
              controller: passwordController,
              obscureText: true,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock_outline),
              ),
              validator: (value) {
                if ((value ?? '').length < 4) {
                  return 'Use at least 4 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (context, constraints) {
                final twoColumns = constraints.maxWidth > 520;
                final fields = [
                  MoneyField(
                    key: const Key('startingBalanceField'),
                    controller: startingBalanceController,
                    label: 'Opening balance',
                    icon: Icons.account_balance_wallet_outlined,
                  ),
                  MoneyField(
                    key: const Key('monthlyIncomeField'),
                    controller: monthlyIncomeController,
                    label: 'Monthly income target',
                    icon: Icons.trending_up,
                  ),
                  MoneyField(
                    key: const Key('savingGoalField'),
                    controller: savingGoalController,
                    label: 'Monthly saving goal',
                    icon: Icons.savings_outlined,
                  ),
                  DropdownButtonFormField<String>(
                    initialValue: currency,
                    decoration: const InputDecoration(
                      labelText: 'Currency',
                      prefixIcon: Icon(Icons.payments_outlined),
                    ),
                    items: supportedCurrencies
                        .map(
                          (item) =>
                              DropdownMenuItem(value: item, child: Text(item)),
                        )
                        .toList(),
                    onChanged: onCurrencyChanged,
                  ),
                ];

                if (!twoColumns) {
                  return Column(
                    children: [
                      for (var index = 0; index < fields.length; index++) ...[
                        fields[index],
                        if (index != fields.length - 1)
                          const SizedBox(height: 12),
                      ],
                    ],
                  );
                }

                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: fields[0]),
                        const SizedBox(width: 12),
                        Expanded(child: fields[1]),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(child: fields[2]),
                        const SizedBox(width: 12),
                        Expanded(child: fields[3]),
                      ],
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: incomeSourceController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Main income source',
                prefixIcon: Icon(Icons.work_outline),
              ),
              validator: requiredValidator,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: walletController,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                labelText: 'Primary wallet or account',
                prefixIcon: Icon(Icons.account_balance_outlined),
              ),
              validator: requiredValidator,
              onFieldSubmitted: (_) => onSubmit(),
            ),
            const SizedBox(height: 18),
            ElevatedButton.icon(
              key: const Key('createAccountButton'),
              onPressed: onSubmit,
              icon: Icon(isRegister ? Icons.check_circle_outline : Icons.login),
              label: Text(isRegister ? 'Create account' : 'Login'),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: onToggleMode,
              child: Text(
                isRegister
                    ? 'Already have an account? Login'
                    : 'Need a new account? Create one',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MoneyField extends StatelessWidget {
  const MoneyField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
  });

  final TextEditingController controller;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: label, prefixIcon: Icon(icon)),
      validator: moneyValidator,
    );
  }
}

class AppShell extends StatefulWidget {
  const AppShell({
    super.key,
    required this.user,
    required this.entries,
    required this.onAddEntry,
    required this.onLogout,
  });

  final UserProfile user;
  final List<FinanceEntry> entries;
  final ValueChanged<FinanceEntry> onAddEntry;
  final VoidCallback onLogout;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;

  void _goToTransactions() {
    setState(() => _selectedIndex = 1);
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      DashboardScreen(
        user: widget.user,
        entries: widget.entries,
        onAddEntryPressed: _goToTransactions,
      ),
      TransactionsScreen(
        user: widget.user,
        entries: widget.entries,
        onAddEntry: widget.onAddEntry,
      ),
      CashFlowScreen(user: widget.user, entries: widget.entries),
      BudgetScreen(user: widget.user, entries: widget.entries),
      ProfileScreen(
        user: widget.user,
        entries: widget.entries,
        onLogout: widget.onLogout,
      ),
    ];

    final app = Scaffold(
      body: IndexedStack(index: _selectedIndex, children: pages),
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
            icon: Icon(Icons.add_card_outlined),
            selectedIcon: Icon(Icons.add_card),
            label: 'Transactions',
          ),
          NavigationDestination(
            icon: Icon(Icons.waterfall_chart_outlined),
            selectedIcon: Icon(Icons.waterfall_chart),
            label: 'Cash Flow',
          ),
          NavigationDestination(
            icon: Icon(Icons.pie_chart_outline_rounded),
            selectedIcon: Icon(Icons.pie_chart_rounded),
            label: 'Budget',
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
  const DashboardScreen({
    super.key,
    required this.user,
    required this.entries,
    required this.onAddEntryPressed,
  });

  final UserProfile user;
  final List<FinanceEntry> entries;
  final VoidCallback onAddEntryPressed;

  @override
  Widget build(BuildContext context) {
    final summary = FinanceSummary(user: user, entries: entries);

    return AppScrollPage(
      children: [
        HeaderBar(
          overline: 'Personal finance tracker',
          title: 'Good Morning ${user.firstName}',
          subtitle: 'Track every rupee that comes in and goes out.',
        ),
        const SizedBox(height: 18),
        BalanceCard(summary: summary),
        const SizedBox(height: 18),
        QuickStats(summary: summary),
        const SizedBox(height: 24),
        SectionTitle(
          title: 'Recent Transactions',
          action: 'Add',
          onAction: onAddEntryPressed,
        ),
        const SizedBox(height: 12),
        if (entries.isEmpty)
          EmptyStateCard(
            icon: Icons.receipt_long_outlined,
            title: 'No money records yet',
            subtitle:
                'Add income and expenses to see where money comes from and where it goes.',
            actionLabel: 'Add first transaction',
            onAction: onAddEntryPressed,
          )
        else
          ...entries.take(5).map((entry) => EntryRow(user: user, entry: entry)),
        const SizedBox(height: 24),
        CategoryBreakdownCard(summary: summary),
        const SizedBox(height: 18),
        IncomeSourceCard(summary: summary),
      ],
    );
  }
}

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({
    super.key,
    required this.user,
    required this.entries,
    required this.onAddEntry,
  });

  final UserProfile user;
  final List<FinanceEntry> entries;
  final ValueChanged<FinanceEntry> onAddEntry;

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _titleController = TextEditingController();
  final _noteController = TextEditingController();
  MoneyDirection _direction = MoneyDirection.expense;
  String _category = expenseCategories.first;
  String _wallet = 'Bank Account';
  String _method = paymentMethods.first;

  @override
  void initState() {
    super.initState();
    _wallet = widget.user.primaryWallet;
  }

  @override
  void dispose() {
    _amountController.dispose();
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  List<String> get _activeCategories => _direction == MoneyDirection.income
      ? incomeCategories
      : expenseCategories;

  void _saveEntry() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    widget.onAddEntry(
      FinanceEntry(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        title: _titleController.text.trim(),
        category: _category,
        direction: _direction,
        amount: parseMoney(_amountController.text),
        date: DateTime.now(),
        wallet: _wallet,
        method: _method,
        note: _noteController.text.trim(),
      ),
    );

    _amountController.clear();
    _titleController.clear();
    _noteController.clear();
    setState(() {
      _direction = MoneyDirection.expense;
      _category = expenseCategories.first;
      _method = paymentMethods.first;
      _wallet = widget.user.primaryWallet;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Transaction saved to your cash flow.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScrollPage(
      children: [
        const HeaderBar(
          overline: 'Transactions',
          title: 'Record Money Movement',
          subtitle: 'Add every income and expense from your real life.',
        ),
        const SizedBox(height: 18),
        CardShell(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'New transaction',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 14),
                SegmentedButton<MoneyDirection>(
                  showSelectedIcon: false,
                  segments: const [
                    ButtonSegment(
                      value: MoneyDirection.income,
                      label: Text('Income'),
                      icon: Icon(Icons.arrow_downward_rounded),
                    ),
                    ButtonSegment(
                      value: MoneyDirection.expense,
                      label: Text('Expense'),
                      icon: Icon(Icons.arrow_upward_rounded),
                    ),
                  ],
                  selected: {_direction},
                  onSelectionChanged: (selection) {
                    setState(() {
                      _direction = selection.first;
                      _category = _activeCategories.first;
                    });
                  },
                ),
                const SizedBox(height: 14),
                TextFormField(
                  key: const Key('transactionTitleField'),
                  controller: _titleController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'What was this?',
                    hintText: 'Example: Salary, rent, groceries',
                    prefixIcon: Icon(Icons.edit_note_outlined),
                  ),
                  validator: requiredValidator,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  key: const Key('transactionAmountField'),
                  controller: _amountController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    prefixText: '${currencySymbol(widget.user.currency)} ',
                  ),
                  validator: moneyValidator,
                ),
                const SizedBox(height: 14),
                Text(
                  'Category',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _activeCategories
                      .map(
                        (category) => ChoiceChip(
                          label: Text(category),
                          selected: _category == category,
                          onSelected: (_) =>
                              setState(() => _category = category),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 14),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final twoColumns = constraints.maxWidth > 520;
                    final walletField = TextFormField(
                      initialValue: _wallet,
                      decoration: const InputDecoration(
                        labelText: 'Wallet or account',
                        prefixIcon: Icon(Icons.account_balance_wallet_outlined),
                      ),
                      onChanged: (value) => _wallet = value,
                      validator: requiredValidator,
                    );
                    final methodField = DropdownButtonFormField<String>(
                      initialValue: _method,
                      decoration: const InputDecoration(
                        labelText: 'Payment method',
                        prefixIcon: Icon(Icons.payments_outlined),
                      ),
                      items: paymentMethods
                          .map(
                            (method) => DropdownMenuItem(
                              value: method,
                              child: Text(method),
                            ),
                          )
                          .toList(),
                      onChanged: (value) =>
                          setState(() => _method = value ?? _method),
                    );

                    if (!twoColumns) {
                      return Column(
                        children: [
                          walletField,
                          const SizedBox(height: 12),
                          methodField,
                        ],
                      );
                    }

                    return Row(
                      children: [
                        Expanded(child: walletField),
                        const SizedBox(width: 12),
                        Expanded(child: methodField),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  key: const Key('transactionNoteField'),
                  controller: _noteController,
                  minLines: 2,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Note',
                    hintText: 'Why did this money move?',
                    prefixIcon: Icon(Icons.notes_outlined),
                  ),
                ),
                const SizedBox(height: 18),
                ElevatedButton.icon(
                  key: const Key('saveTransactionButton'),
                  onPressed: _saveEntry,
                  icon: const Icon(Icons.check_circle_outline),
                  label: const Text('Save transaction'),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        const SectionTitle(title: 'All Records'),
        const SizedBox(height: 12),
        if (widget.entries.isEmpty)
          const EmptyListMessage(
            title: 'Your transaction list is empty',
            subtitle:
                'Save an income or expense above to start tracking cash flow.',
          )
        else
          ...widget.entries.map(
            (entry) => EntryRow(user: widget.user, entry: entry),
          ),
      ],
    );
  }
}

class CashFlowScreen extends StatelessWidget {
  const CashFlowScreen({super.key, required this.user, required this.entries});

  final UserProfile user;
  final List<FinanceEntry> entries;

  @override
  Widget build(BuildContext context) {
    final summary = FinanceSummary(user: user, entries: entries);

    return AppScrollPage(
      children: [
        const HeaderBar(
          overline: 'Cash Flow',
          title: 'Where Money Moves',
          subtitle: 'Compare incoming cash, outgoing cash, and net movement.',
        ),
        const SizedBox(height: 18),
        CashFlowCard(summary: summary),
        const SizedBox(height: 18),
        CategoryBreakdownCard(summary: summary),
        const SizedBox(height: 18),
        IncomeSourceCard(summary: summary),
        const SizedBox(height: 18),
        SpendingAnswerCard(summary: summary),
      ],
    );
  }
}

class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key, required this.user, required this.entries});

  final UserProfile user;
  final List<FinanceEntry> entries;

  @override
  Widget build(BuildContext context) {
    final summary = FinanceSummary(user: user, entries: entries);
    final spendLimit = math.max(
      0.0,
      user.monthlyIncomeTarget - user.monthlySavingGoal,
    );
    final spentRatio = spendLimit <= 0
        ? 0.0
        : summary.expenseTotal / spendLimit;
    final savingProgress = user.monthlySavingGoal <= 0
        ? 0.0
        : math.max(0.0, summary.netCashFlow) / user.monthlySavingGoal;

    return AppScrollPage(
      children: [
        const HeaderBar(
          overline: 'Budget',
          title: 'Control The Month',
          subtitle:
              'Use your income target and saving goal to avoid overspending.',
        ),
        const SizedBox(height: 18),
        MetricProgressCard(
          icon: Icons.speed_rounded,
          color: AppTheme.coral,
          title: 'Monthly spending limit',
          value: formatMoney(user.currency, spendLimit),
          subtitle: 'Spent ${formatMoney(user.currency, summary.expenseTotal)}',
          progress: spentRatio,
        ),
        const SizedBox(height: 12),
        MetricProgressCard(
          icon: Icons.savings_outlined,
          color: AppTheme.emerald,
          title: 'Saving goal progress',
          value: formatMoney(user.currency, user.monthlySavingGoal),
          subtitle:
              'Net cash flow ${formatMoney(user.currency, summary.netCashFlow)}',
          progress: savingProgress,
        ),
        const SizedBox(height: 24),
        const SectionTitle(title: 'Category Control'),
        const SizedBox(height: 12),
        if (summary.expenseByCategory.isEmpty)
          const EmptyListMessage(
            title: 'No spending yet',
            subtitle:
                'Expense categories will appear here after you add records.',
          )
        else
          ...summary.expenseByCategory.entries.map(
            (item) => CategoryBudgetTile(
              currency: user.currency,
              name: item.key,
              amount: item.value,
              totalExpense: summary.expenseTotal,
            ),
          ),
      ],
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    required this.user,
    required this.entries,
    required this.onLogout,
  });

  final UserProfile user;
  final List<FinanceEntry> entries;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    final summary = FinanceSummary(user: user, entries: entries);

    return AppScrollPage(
      children: [
        ProfileHeader(user: user),
        const SizedBox(height: 18),
        CardShell(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Account details',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 14),
              SettingsItem(
                icon: Icons.email_outlined,
                title: 'Email',
                subtitle: user.email,
                color: AppTheme.blue,
              ),
              const Divider(height: 24),
              SettingsItem(
                icon: Icons.payments_outlined,
                title: 'Currency',
                subtitle: user.currency,
                color: AppTheme.emerald,
              ),
              const Divider(height: 24),
              SettingsItem(
                icon: Icons.work_outline,
                title: 'Main income source',
                subtitle: user.mainIncomeSource,
                color: AppTheme.amber,
              ),
              const Divider(height: 24),
              SettingsItem(
                icon: Icons.account_balance_wallet_outlined,
                title: 'Primary wallet',
                subtitle: user.primaryWallet,
                color: AppTheme.teal,
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        CardShell(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tracker summary',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  ProfileStat(
                    label: 'Records',
                    value: entries.length.toString(),
                    color: AppTheme.violet,
                  ),
                  ProfileStat(
                    label: 'Balance',
                    value: formatMoney(user.currency, summary.currentBalance),
                    color: AppTheme.teal,
                  ),
                  ProfileStat(
                    label: 'Net flow',
                    value: formatMoney(user.currency, summary.netCashFlow),
                    color: summary.netCashFlow >= 0
                        ? AppTheme.emerald
                        : AppTheme.coral,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        OutlinedButton.icon(
          onPressed: onLogout,
          icon: const Icon(Icons.logout),
          label: const Text('Logout'),
        ),
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
  const BalanceCard({super.key, required this.summary});

  final FinanceSummary summary;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF101820), Color(0xFF087E8B)],
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
          const Text(
            'Total Balance',
            style: TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            formatMoney(summary.user.currency, summary.currentBalance),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.w900,
              height: 1,
            ),
          ),
          const SizedBox(height: 18),
          LayoutBuilder(
            builder: (context, constraints) {
              final compact = constraints.maxWidth < 540;
              final tiles = [
                BalanceMetric(
                  icon: Icons.account_balance_wallet_outlined,
                  label: 'Opening',
                  value: formatMoney(
                    summary.user.currency,
                    summary.user.startingBalance,
                  ),
                  color: AppTheme.blue,
                ),
                BalanceMetric(
                  icon: Icons.arrow_downward,
                  label: 'Incoming Cash',
                  value: formatMoney(
                    summary.user.currency,
                    summary.incomeTotal,
                  ),
                  color: AppTheme.emerald,
                ),
                BalanceMetric(
                  icon: Icons.arrow_upward,
                  label: 'Outgoing Cash',
                  value: formatMoney(
                    summary.user.currency,
                    summary.expenseTotal,
                  ),
                  color: AppTheme.coral,
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
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.22),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.white, size: 18),
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
                    fontSize: 14,
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

class QuickStats extends StatelessWidget {
  const QuickStats({super.key, required this.summary});

  final FinanceSummary summary;

  @override
  Widget build(BuildContext context) {
    final stats = [
      InsightItem(
        icon: Icons.swap_vert_rounded,
        title: 'Net cash flow',
        value: formatMoney(summary.user.currency, summary.netCashFlow),
        color: summary.netCashFlow >= 0 ? AppTheme.emerald : AppTheme.coral,
      ),
      InsightItem(
        icon: Icons.shopping_bag_outlined,
        title: 'Top spending',
        value: summary.topExpenseCategory,
        color: AppTheme.amber,
      ),
      InsightItem(
        icon: Icons.work_outline,
        title: 'Top income',
        value: summary.topIncomeSource,
        color: AppTheme.blue,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 620;
        if (compact) {
          return Column(
            children: [
              for (var index = 0; index < stats.length; index++) ...[
                stats[index],
                if (index != stats.length - 1) const SizedBox(height: 10),
              ],
            ],
          );
        }

        return Row(
          children: [
            for (var index = 0; index < stats.length; index++) ...[
              Expanded(child: stats[index]),
              if (index != stats.length - 1) const SizedBox(width: 12),
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
                Text(value, style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CashFlowCard extends StatelessWidget {
  const CashFlowCard({super.key, required this.summary});

  final FinanceSummary summary;

  @override
  Widget build(BuildContext context) {
    final maxValue = math.max(
      1.0,
      math.max(summary.incomeTotal, summary.expenseTotal),
    );

    return CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Cash flow overview',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          CashFlowBar(
            label: 'Incoming cash',
            value: summary.incomeTotal,
            maxValue: maxValue,
            currency: summary.user.currency,
            color: AppTheme.emerald,
          ),
          const SizedBox(height: 14),
          CashFlowBar(
            label: 'Outgoing cash',
            value: summary.expenseTotal,
            maxValue: maxValue,
            currency: summary.user.currency,
            color: AppTheme.coral,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color:
                  (summary.netCashFlow >= 0 ? AppTheme.emerald : AppTheme.coral)
                      .withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  summary.netCashFlow >= 0
                      ? Icons.trending_up_rounded
                      : Icons.trending_down_rounded,
                  color: summary.netCashFlow >= 0
                      ? AppTheme.emerald
                      : AppTheme.coral,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Net flow ${formatMoney(summary.user.currency, summary.netCashFlow)}',
                    style: Theme.of(context).textTheme.titleMedium,
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

class CashFlowBar extends StatelessWidget {
  const CashFlowBar({
    super.key,
    required this.label,
    required this.value,
    required this.maxValue,
    required this.currency,
    required this.color,
  });

  final String label;
  final double value;
  final double maxValue;
  final String currency;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final ratio = (value / maxValue).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Text(
              formatMoney(currency, value),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: ratio,
            minHeight: 12,
            backgroundColor: color.withValues(alpha: 0.12),
            valueColor: AlwaysStoppedAnimation(color),
          ),
        ),
      ],
    );
  }
}

class CategoryBreakdownCard extends StatelessWidget {
  const CategoryBreakdownCard({super.key, required this.summary});

  final FinanceSummary summary;

  @override
  Widget build(BuildContext context) {
    return CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Where money went',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 6),
          Text(
            'Expense categories are calculated from the records you save.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          if (summary.expenseByCategory.isEmpty)
            const EmptyInline(text: 'No expense records yet.')
          else
            ...summary.expenseByCategory.entries.map(
              (item) => BreakdownLine(
                label: item.key,
                amount: item.value,
                total: summary.expenseTotal,
                currency: summary.user.currency,
                color: categoryColor(item.key),
              ),
            ),
        ],
      ),
    );
  }
}

class IncomeSourceCard extends StatelessWidget {
  const IncomeSourceCard({super.key, required this.summary});

  final FinanceSummary summary;

  @override
  Widget build(BuildContext context) {
    return CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How money came in',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 6),
          Text(
            'Income sources show salary, business, freelance, and other cash inflows.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          if (summary.incomeByCategory.isEmpty)
            EmptyInline(
              text:
                  'No income records yet. Expected source: ${summary.user.mainIncomeSource}.',
            )
          else
            ...summary.incomeByCategory.entries.map(
              (item) => BreakdownLine(
                label: item.key,
                amount: item.value,
                total: summary.incomeTotal,
                currency: summary.user.currency,
                color: categoryColor(item.key),
              ),
            ),
        ],
      ),
    );
  }
}

class SpendingAnswerCard extends StatelessWidget {
  const SpendingAnswerCard({super.key, required this.summary});

  final FinanceSummary summary;

  @override
  Widget build(BuildContext context) {
    final hasExpense = summary.expenseTotal > 0;
    final text = hasExpense
        ? 'Most spending is in ${summary.topExpenseCategory}. Total outgoing cash is ${formatMoney(summary.user.currency, summary.expenseTotal)}.'
        : 'Add expense records and this screen will answer where the money is gone.';

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppTheme.ink,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppTheme.amber.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.search_rounded, color: AppTheme.amber),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Money answer',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white70,
                    height: 1.4,
                    fontWeight: FontWeight.w600,
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

class MetricProgressCard extends StatelessWidget {
  const MetricProgressCard({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.progress,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String value;
  final String subtitle;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final safeProgress = progress.clamp(0.0, 1.0);

    return CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconBadge(icon: icon, color: color),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              Text(value, style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: safeProgress,
              minHeight: 10,
              backgroundColor: color.withValues(alpha: 0.12),
              valueColor: AlwaysStoppedAnimation(color),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${(safeProgress * 100).round()}%',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class CategoryBudgetTile extends StatelessWidget {
  const CategoryBudgetTile({
    super.key,
    required this.currency,
    required this.name,
    required this.amount,
    required this.totalExpense,
  });

  final String currency;
  final String name;
  final double amount;
  final double totalExpense;

  @override
  Widget build(BuildContext context) {
    final ratio = totalExpense <= 0 ? 0.0 : amount / totalExpense;
    final color = categoryColor(name);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: CardShell(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconBadge(icon: categoryIcon(name), color: color),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Text(
                  formatMoney(currency, amount),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: ratio.clamp(0.0, 1.0),
                minHeight: 9,
                backgroundColor: color.withValues(alpha: 0.12),
                valueColor: AlwaysStoppedAnimation(color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BreakdownLine extends StatelessWidget {
  const BreakdownLine({
    super.key,
    required this.label,
    required this.amount,
    required this.total,
    required this.currency,
    required this.color,
  });

  final String label;
  final double amount;
  final double total;
  final String currency;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final ratio = total <= 0 ? 0.0 : amount / total;

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Text(
                formatMoney(currency, amount),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: ratio.clamp(0.0, 1.0),
              minHeight: 8,
              backgroundColor: color.withValues(alpha: 0.12),
              valueColor: AlwaysStoppedAnimation(color),
            ),
          ),
        ],
      ),
    );
  }
}

class EntryRow extends StatelessWidget {
  const EntryRow({super.key, required this.user, required this.entry});

  final UserProfile user;
  final FinanceEntry entry;

  @override
  Widget build(BuildContext context) {
    final isIncome = entry.direction == MoneyDirection.income;
    final color = isIncome ? AppTheme.emerald : categoryColor(entry.category);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: CardShell(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            IconBadge(icon: categoryIcon(entry.category), color: color),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '${entry.category} - ${entry.wallet} - ${formatDate(entry.date)}',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            Text(
              '${isIncome ? '+' : '-'}${formatMoney(user.currency, entry.amount)}',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key, required this.user});

  final UserProfile user;

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
            child: Center(
              child: Text(
                user.initials,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
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
                  user.fullName,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  'Local finance account',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
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
      ],
    );
  }
}

class ProfileStat extends StatelessWidget {
  const ProfileStat({
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
      width: 136,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 4),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}

class EmptyStateCard extends StatelessWidget {
  const EmptyStateCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.actionLabel,
    required this.onAction,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String actionLabel;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    return CardShell(
      child: Column(
        children: [
          IconBadge(icon: icon, color: AppTheme.blue),
          const SizedBox(height: 12),
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 4),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 14),
          ElevatedButton.icon(
            onPressed: onAction,
            icon: const Icon(Icons.add),
            label: Text(actionLabel),
          ),
        ],
      ),
    );
  }
}

class EmptyListMessage extends StatelessWidget {
  const EmptyListMessage({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return CardShell(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          const IconBadge(icon: Icons.info_outline, color: AppTheme.blue),
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
        ],
      ),
    );
  }
}

class EmptyInline extends StatelessWidget {
  const EmptyInline({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.cloud,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
    );
  }
}

class FeatureLine extends StatelessWidget {
  const FeatureLine({
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
      crossAxisAlignment: CrossAxisAlignment.start,
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
      ],
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
    this.action,
    this.onAction,
  });

  final String title;
  final String? action;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(title, style: Theme.of(context).textTheme.titleLarge),
        ),
        if (action != null)
          TextButton(onPressed: onAction, child: Text(action!)),
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

enum MoneyDirection { income, expense }

class UserProfile {
  const UserProfile({
    required this.fullName,
    required this.email,
    required this.currency,
    required this.primaryWallet,
    required this.mainIncomeSource,
    required this.startingBalance,
    required this.monthlyIncomeTarget,
    required this.monthlySavingGoal,
  });

  final String fullName;
  final String email;
  final String currency;
  final String primaryWallet;
  final String mainIncomeSource;
  final double startingBalance;
  final double monthlyIncomeTarget;
  final double monthlySavingGoal;

  String get firstName => fullName.trim().split(RegExp(r'\s+')).first;

  String get initials {
    final parts = fullName.trim().split(RegExp(r'\s+'));
    final first = parts.isEmpty || parts.first.isEmpty ? 'U' : parts.first[0];
    final second = parts.length > 1 && parts[1].isNotEmpty ? parts[1][0] : '';
    return '$first$second'.toUpperCase();
  }
}

class FinanceEntry {
  const FinanceEntry({
    required this.id,
    required this.title,
    required this.category,
    required this.direction,
    required this.amount,
    required this.date,
    required this.wallet,
    required this.method,
    required this.note,
  });

  final String id;
  final String title;
  final String category;
  final MoneyDirection direction;
  final double amount;
  final DateTime date;
  final String wallet;
  final String method;
  final String note;
}

class FinanceSummary {
  FinanceSummary({required this.user, required this.entries});

  final UserProfile user;
  final List<FinanceEntry> entries;

  double get incomeTotal => entries
      .where((entry) => entry.direction == MoneyDirection.income)
      .fold(0, (sum, entry) => sum + entry.amount);

  double get expenseTotal => entries
      .where((entry) => entry.direction == MoneyDirection.expense)
      .fold(0, (sum, entry) => sum + entry.amount);

  double get netCashFlow => incomeTotal - expenseTotal;

  double get currentBalance => user.startingBalance + netCashFlow;

  Map<String, double> get expenseByCategory =>
      groupedTotal(MoneyDirection.expense);

  Map<String, double> get incomeByCategory =>
      groupedTotal(MoneyDirection.income);

  String get topExpenseCategory =>
      topLabel(expenseByCategory, fallback: 'No spending');

  String get topIncomeSource =>
      topLabel(incomeByCategory, fallback: user.mainIncomeSource);

  Map<String, double> groupedTotal(MoneyDirection direction) {
    final totals = <String, double>{};
    for (final entry in entries.where(
      (entry) => entry.direction == direction,
    )) {
      totals.update(
        entry.category,
        (value) => value + entry.amount,
        ifAbsent: () => entry.amount,
      );
    }

    final sorted = totals.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return Map.fromEntries(sorted);
  }
}

const supportedCurrencies = ['PKR', 'USD', 'EUR', 'GBP', 'AED', 'SAR'];

const expenseCategories = [
  'Food',
  'Bills',
  'Shopping',
  'Fuel',
  'Transport',
  'Medical',
  'Education',
  'Travel',
  'Rent',
  'Entertainment',
];

const incomeCategories = [
  'Salary',
  'Business',
  'Freelance',
  'Investment',
  'Gift',
  'Rent Income',
  'Refund',
  'Other Income',
];

const paymentMethods = ['Cash', 'Card', 'Bank', 'UPI', 'Wallet'];

String? requiredValidator(String? value) {
  if ((value ?? '').trim().isEmpty) {
    return 'This field is required';
  }
  return null;
}

String? moneyValidator(String? value) {
  final amount = parseMoney(value ?? '');
  if (amount <= 0) {
    return 'Enter an amount greater than 0';
  }
  return null;
}

double parseMoney(String value) {
  final clean = value.replaceAll(',', '').trim();
  return double.tryParse(clean) ?? 0;
}

String currencySymbol(String currency) {
  return switch (currency) {
    'PKR' => 'Rs',
    'USD' => r'$',
    'EUR' => 'EUR',
    'GBP' => 'GBP',
    'AED' => 'AED',
    'SAR' => 'SAR',
    _ => currency,
  };
}

String formatMoney(String currency, double value) {
  final negative = value < 0;
  final amount = value.abs();
  final symbol = currencySymbol(currency);
  final whole = amount.round().toString();
  final grouped = whole.replaceAllMapped(
    RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
    (match) => '${match[1]},',
  );
  return '${negative ? '-' : ''}$symbol $grouped';
}

String formatDate(DateTime value) {
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  return '${months[value.month - 1]} ${value.day}';
}

String titleCase(String value) {
  if (value.trim().isEmpty) {
    return 'User';
  }
  return value
      .split(RegExp(r'[\s._-]+'))
      .where((part) => part.isNotEmpty)
      .map(
        (part) => '${part[0].toUpperCase()}${part.substring(1).toLowerCase()}',
      )
      .join(' ');
}

String topLabel(Map<String, double> values, {required String fallback}) {
  if (values.isEmpty) {
    return fallback;
  }
  return values.entries.first.key;
}

IconData categoryIcon(String category) {
  return switch (category) {
    'Food' => Icons.restaurant_outlined,
    'Bills' => Icons.receipt_long_outlined,
    'Shopping' => Icons.shopping_bag_outlined,
    'Fuel' => Icons.local_gas_station_outlined,
    'Transport' => Icons.directions_bus_outlined,
    'Medical' => Icons.local_hospital_outlined,
    'Education' => Icons.school_outlined,
    'Travel' => Icons.flight_takeoff_outlined,
    'Rent' => Icons.home_work_outlined,
    'Entertainment' => Icons.movie_outlined,
    'Salary' => Icons.account_balance_outlined,
    'Business' => Icons.storefront_outlined,
    'Freelance' => Icons.laptop_mac_outlined,
    'Investment' => Icons.trending_up_rounded,
    'Gift' => Icons.card_giftcard_outlined,
    'Rent Income' => Icons.apartment_outlined,
    'Refund' => Icons.assignment_return_outlined,
    _ => Icons.payments_outlined,
  };
}

Color categoryColor(String category) {
  return switch (category) {
    'Food' => AppTheme.amber,
    'Bills' => AppTheme.coral,
    'Shopping' => AppTheme.blue,
    'Fuel' => AppTheme.teal,
    'Transport' => AppTheme.violet,
    'Medical' => AppTheme.coral,
    'Education' => AppTheme.blue,
    'Travel' => AppTheme.emerald,
    'Rent' => AppTheme.ink,
    'Entertainment' => AppTheme.violet,
    'Salary' => AppTheme.emerald,
    'Business' => AppTheme.teal,
    'Freelance' => AppTheme.blue,
    'Investment' => AppTheme.emerald,
    'Gift' => AppTheme.amber,
    'Rent Income' => AppTheme.violet,
    'Refund' => AppTheme.teal,
    _ => AppTheme.muted,
  };
}
