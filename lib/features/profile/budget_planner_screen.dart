import 'package:flutter/material.dart';
import '../../core/localization/app_localizations.dart';
import '../../main.dart';
import '../../core/models/budget_entry.dart';

class BudgetPlannerScreen extends StatefulWidget {
  const BudgetPlannerScreen({super.key});

  @override
  State<BudgetPlannerScreen> createState() => _BudgetPlannerScreenState();
}

class _BudgetPlannerScreenState extends State<BudgetPlannerScreen> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _categoryController = TextEditingController();
  final _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  bool _isPlanned = true;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _categoryController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(loc.t('budget_planner'))),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openAddEntry(context, scope, loc),
        icon: const Icon(Icons.add),
        label: Text(loc.t('add_entry')),
      ),
      body: ValueListenableBuilder<List<BudgetEntry>>(
        valueListenable: scope.engagementController.budgetEntries,
        builder: (_, entries, __) {
          return ValueListenableBuilder<double>(
            valueListenable: scope.engagementController.monthlyBudget,
            builder: (_, budget, __) {
              return ValueListenableBuilder<double>(
                valueListenable: scope.engagementController.savingsTarget,
                builder: (_, target, __) {
                  final spent = entries
                      .where((e) => e.isPaid)
                      .fold<double>(0, (sum, e) => sum + e.amount);
                  final planned = entries
                      .where((e) => !e.isPaid)
                      .fold<double>(0, (sum, e) => sum + e.amount);
                  final remaining =
                      (budget - spent).clamp(0, budget).toDouble();
                  return ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      _BudgetHeader(
                        budget: budget,
                        spent: spent,
                        planned: planned,
                        remaining: remaining,
                        target: target,
                        onEdit: () => _editBudget(context, scope, loc, budget, target),
                      ),
                      const SizedBox(height: 12),
                      ...entries
                          .map((e) => _BudgetTile(
                                entry: e,
                                onToggle: () => scope.engagementController
                                    .toggleBudgetEntryPaid(e.id),
                                onRemove: () => scope.engagementController
                                    .removeBudgetEntry(e.id),
                                loc: loc,
                              ))
                          .toList(),
                      if (entries.isEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 32),
                          child: Center(child: Text(loc.t('no_budget_entries'))),
                        )
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _openAddEntry(
    BuildContext context,
    AppScope scope,
    AppLocalizations loc,
  ) async {
    _titleController.clear();
    _amountController.clear();
    _categoryController.clear();
    _noteController.clear();
    _isPlanned = true;
    _selectedDate = DateTime.now();
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(loc.t('add_entry'), style: Theme.of(ctx).textTheme.titleMedium),
                  IconButton(
                    onPressed: () => Navigator.pop(ctx),
                    icon: const Icon(Icons.close),
                  )
                ],
              ),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: loc.t('label')),
              ),
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: loc.t('amount')),
              ),
              TextField(
                controller: _categoryController,
                decoration: InputDecoration(labelText: loc.t('category')),
              ),
              TextField(
                controller: _noteController,
                decoration: InputDecoration(labelText: loc.t('note_optional')),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(child: Text(loc.t('planned_purchase'))),
                  Switch(
                    value: _isPlanned,
                    onChanged: (v) => setState(() => _isPlanned = v),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(loc.t('choose_date')),
                  TextButton(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: ctx,
                        firstDate: DateTime.now().subtract(const Duration(days: 180)),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                        initialDate: _selectedDate,
                      );
                      if (picked != null) {
                        setState(() => _selectedDate = picked);
                      }
                    },
                    child: Text('${_selectedDate.month}/${_selectedDate.day}'),
                  )
                ],
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  final title = _titleController.text.trim();
                  final amount = double.tryParse(_amountController.text.trim());
                  if (title.isEmpty || amount == null) return;
                  final entry = BudgetEntry(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    title: title,
                    amount: amount,
                    category: _categoryController.text.trim().isEmpty
                        ? loc.t('uncategorized')
                        : _categoryController.text.trim(),
                    date: _selectedDate,
                    isPlanned: _isPlanned,
                    isPaid: !_isPlanned,
                    note: _noteController.text.trim(),
                  );
                  scope.engagementController.addBudgetEntry(entry);
                  Navigator.pop(ctx);
                },
                child: Text(loc.t('save')),
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> _editBudget(
    BuildContext context,
    AppScope scope,
    AppLocalizations loc,
    double currentBudget,
    double currentTarget,
  ) async {
    final budgetController = TextEditingController(text: currentBudget.toStringAsFixed(0));
    final targetController = TextEditingController(text: currentTarget.toStringAsFixed(0));
    await showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(loc.t('adjust_budget')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: budgetController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: loc.t('monthly_budget')),
              ),
              TextField(
                controller: targetController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: loc.t('savings_target')),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(loc.t('cancel')),
            ),
            ElevatedButton(
              onPressed: () {
                final limit = double.tryParse(budgetController.text.trim());
                final target = double.tryParse(targetController.text.trim());
                scope.engagementController
                    .updateBudgetLimits(limit: limit, target: target);
                Navigator.pop(ctx);
              },
              child: Text(loc.t('save')),
            )
          ],
        );
      },
    );
  }
}

class _BudgetHeader extends StatelessWidget {
  final double budget;
  final double spent;
  final double planned;
  final double remaining;
  final double target;
  final VoidCallback onEdit;

  const _BudgetHeader({
    required this.budget,
    required this.spent,
    required this.planned,
    required this.remaining,
    required this.target,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final progress = budget == 0 ? 0 : (spent / budget).clamp(0, 1);
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(loc.t('spending_overview'),
                    style: Theme.of(context).textTheme.titleMedium),
                IconButton(onPressed: onEdit, icon: const Icon(Icons.edit_outlined))
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _InfoPill(label: loc.t('spent'), value: spent),
                const SizedBox(width: 8),
                _InfoPill(label: loc.t('planned'), value: planned),
                const SizedBox(width: 8),
                _InfoPill(label: loc.t('remaining'), value: remaining),
              ],
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(value: progress),
            const SizedBox(height: 4),
            Text(loc.t('savings_target_label', params: {'value': target.toStringAsFixed(0)})),
          ],
        ),
      ),
    );
  }
}

class _BudgetTile extends StatelessWidget {
  final BudgetEntry entry;
  final VoidCallback onToggle;
  final VoidCallback onRemove;
  final AppLocalizations loc;

  const _BudgetTile({
    required this.entry,
    required this.onToggle,
    required this.onRemove,
    required this.loc,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Checkbox(value: entry.isPaid, onChanged: (_) => onToggle()),
        title: Text(entry.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${entry.category} • ${entry.date.month}/${entry.date.day}'),
            if (entry.note.isNotEmpty) Text(entry.note),
            Text(entry.isPaid ? loc.t('purchased') : loc.t('planned_purchase')),
          ],
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('${loc.t('currency')} ${entry.amount.toStringAsFixed(0)}',
                style: Theme.of(context).textTheme.titleMedium),
            IconButton(onPressed: onRemove, icon: const Icon(Icons.delete_outline))
          ],
        ),
      ),
    );
  }
}

class _InfoPill extends StatelessWidget {
  final String label;
  final double value;

  const _InfoPill({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.06),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: 4),
            Text('${loc.t('currency')} ${value.toStringAsFixed(0)}',
                style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}
