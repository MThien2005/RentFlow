# RentFlow application architecture

The app is organized by feature. Each feature follows Clean Architecture and
contains its own presentation, domain, and data layers. Presentation state is
managed with BLoC/Cubit, and domain repositories are implemented in the data
layer.

```text
lib/
├── app/
│   ├── router/
│   └── theme/
│       ├── app_theme.dart
│       └── app_theme_cubit.dart
├── core/
│   ├── constants/
│   ├── errors/
│   ├── network/
│   ├── utils/
│   └── widgets/
├── features/
│   └── <feature>/
│       ├── presentation/
│       │   ├── pages/
│       │   ├── widgets/
│       │   └── bloc/
│       ├── domain/
│       │   ├── entities/
│       │   ├── repositories/
│       │   └── usecases/
│       └── data/
│           ├── models/
│           ├── datasources/
│           └── repositories/
└── main.dart
```

The authentication screen is implemented under
`features/auth/presentation/`. The app-wide light/dark mode is managed by
`app/theme/app_theme_cubit.dart`.

## Features and related data tables

| Feature | Related tables |
| --- | --- |
| `auth` | `Users` |
| `user` | `Users`, `Tenants` |
| `house` | `Properties` |
| `room` | `Rooms` |
| `renter` | `Tenants` |
| `contract` | `Contracts`, `ContractMembers` |
| `service` | `Services`, `AppliedServices` |
| `utility` | `UtilityReadings`, `UtilityRates` |
| `bill` | `Invoices`, `InvoiceDetails` |
| `payment` | `PaymentTransactions` |
| `notification` | `Notifications`, `NotificationRecipients` |
| `assignment` | `AssignmentPermissions` |
| `maintenance` | `MaintenanceRequests` |
| `activity` | `ActivityLogs` |

## Dependency direction

```text
presentation (BLoC/Cubit) -> domain (use cases and repository contracts)
data (data sources and repository implementations) -> domain contracts
```

Keep framework and storage details in `data`. The `domain` layer should not
depend on Flutter or on a specific backend. BLoC/Cubit calls use cases, while
the data repositories implement the interfaces declared in the domain layer.
