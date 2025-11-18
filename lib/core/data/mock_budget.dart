import '../models/budget_entry.dart';

final mockBudgetEntries = [
  BudgetEntry(
    id: 'b1',
    title: 'Brightening serum restock',
    amount: 38,
    category: 'Serum',
    date: DateTime.now().subtract(const Duration(days: 2)),
    isPlanned: false,
    isPaid: true,
    note: 'Picked during weekend sale',
  ),
  BudgetEntry(
    id: 'b2',
    title: 'Mineral SPF',
    amount: 26,
    category: 'Sunscreen',
    date: DateTime.now().subtract(const Duration(days: 1)),
    isPlanned: false,
    isPaid: true,
    note: 'Travel size for carry-on',
  ),
  BudgetEntry(
    id: 'b3',
    title: 'Calming cleanser',
    amount: 18,
    category: 'Cleanser',
    date: DateTime.now().add(const Duration(days: 5)),
    isPlanned: true,
    isPaid: false,
    note: 'Plan to grab during mid-month promo',
  ),
  BudgetEntry(
    id: 'b4',
    title: 'Weekly sheet masks',
    amount: 14,
    category: 'Mask',
    date: DateTime.now().add(const Duration(days: 9)),
    isPlanned: true,
    isPaid: false,
    note: 'Bundle of 4 hydrating masks',
  ),
];
