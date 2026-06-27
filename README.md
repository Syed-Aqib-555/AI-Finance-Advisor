# FinPilot AI

Smart Money. Smarter Future.

FinPilot AI is a high-fidelity Flutter prototype for an AI personal finance manager. It is designed as a premium mobile banking-style experience with dashboards, transaction entry, budgets, wallet management, receipt scanning concepts, smart reminders, and an AI finance advisor.

## Current Prototype

- Home dashboard with total balance, income, expense, savings, recent transactions, spending breakdown, and monthly spending chart.
- Transaction module with amount, income/expense/transfer type, category chips, description, date, wallet, payment method, and receipt scanner preview.
- Budget module with category progress, savings goals, bill reminders, and subscription tracking.
- AI Advisor chat mockup with weekly report insights, smart prompts, and affordability guidance examples.
- Profile area with wallets, premium plan, security settings, cloud sync, notifications, and export options.
- Responsive layout that works as a mobile app and also frames nicely on larger desktop/web viewports.

## Planned Production Stack

- Flutter
- Riverpod for state management
- GoRouter for navigation
- Firebase Auth and Firestore
- Firebase Storage and Cloud Messaging
- Hive/SQLite for offline-first local data
- Gemini or OpenAI API for finance coaching
- Google ML Kit OCR for receipt scanning
- fl_chart for production charts
- pdf, printing, and excel for exports
- flutter_secure_storage and local_auth for app security

## App Flow

Splash -> Onboarding -> Login/Register -> Choose Currency -> Create First Wallet -> Dashboard -> Bottom Navigation

Bottom navigation:

- Home
- Transactions
- Budget
- AI
- Profile

## Getting Started

Install dependencies:

```bash
flutter pub get
```

Run the app:

```bash
flutter run
```

Analyze and test:

```bash
flutter analyze
flutter test
```

## Status

This repository currently contains the UI prototype and app structure foundation. Backend services, authentication, cloud sync, real OCR, and live AI API calls are planned next-step integrations.
