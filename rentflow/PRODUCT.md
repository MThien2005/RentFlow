# Product

<!-- impeccable:product-schema 1 -->

## Platform

adaptive

## Users

- **Owner:** owns rental properties, assigns managers, and oversees operations and finances.
- **Manager:** carries out permitted work only for properties assigned by an owner.
- **Tenant:** views and acts on information tied to their own verified rental relationship.

The product's primary users are owners and property managers. Tenants are a supported user group with a narrower, self-service role.

## Product Purpose

RentFlow helps owners and property managers run rental housing operations in one system. It is intended to cover the workflow from managing properties and rooms, through tenants and contracts, to utility readings, monthly invoices, recorded payments, maintenance, and owner reporting.

Success means owners can understand property occupancy, collections, outstanding debt, and manager activity, while managers and tenants can complete their permitted tasks without seeing unrelated properties or records.

## Positioning

RentFlow's product focus is end-to-end rental operations with explicit ownership and delegated access. Owners retain oversight across their properties; managers work within assigned properties and permissions; tenants get access to their own rental information. This describes the intended product emphasis, not a claim of market exclusivity.

## Operating Context

- RentFlow is a two-person academic project that is intended to continue as one product and codebase across coursework and a later thesis phase.
- The business brief gives a proposed coursework period of 12 October–19 December 2026, followed by a planned MVP phase and a possible thesis and store-release phase in 2027. These dates are planning assumptions, not confirmed school deadlines.
- The application targets Android and iOS and is expected to adapt its presentation to each operating system.
- Owners and managers use the system for day-to-day property operations. Tenants use it to check their room, contract, invoices, payment history, notifications, and maintenance requests.

## Capabilities and Constraints

The planned initial scope includes account and authorization management; multiple properties and rooms; manager assignment; tenant records and contracts; utility readings and property-specific services/rates; monthly invoicing; manual payment records and debt tracking; maintenance requests; notifications; activity history; and basic role-specific dashboards and reports.

Core access and data rules:

- Each property has one identified owner. A manager does not become an owner through assignment.
- Owners can assign and revoke managers for properties they own. A manager can be assigned to multiple properties, and a property may have multiple managers when permitted.
- Access is limited by role, property assignment, and the user's verified rental relationship. A trusted backend or storage security rules must enforce access; hiding UI controls is not a security boundary.
- Revoking access or ending a contract must preserve historical invoices, payments, and activity records. Issued invoices retain the rates and quantities used to calculate them; corrections require a traceable adjustment process.
- Initial payments may be recorded manually. Online payment processing, live meter integrations, AI-assisted queries, consumption anomaly detection, cameras, and advanced analytics are deferred ideas, not initial-scope commitments.
- The existing codebase uses Flutter. The intended architecture is Feature-based Clean Architecture with BLoC/Cubit, Repository Pattern, and Dependency Injection. Firebase is under consideration as a backend, not a confirmed selection.
- The business brief sets team workflow expectations: generated code should be explainable and reviewed; business decisions should follow confirmed specifications; use sample data instead of real tenant data or secrets; keep changes traceable.

Open decisions retained from the business brief include the final permission matrix and approval rules; tenant invitation, account linking, and phone verification; contract parties and renewal behavior; invoice cadence and automation; handling of refunds, overpayments, and post-issue adjustments; and whether rooms can be rented by bed. The brief's examples, suggested rates, and items marked as proposals are not defaults unless the team confirms them.

## Brand Commitments

The product name is **RentFlow**. No approved logo, brand voice, or other identity assets are established in the supplied material.

## Evidence on Hand

- `Nghiệp vụ (full).docx` is the supplied working business brief. It contains role definitions, workflows, proposed scope, business rules, data entities, and open questions.
- `lib/ARCHITECTURE.md` records the feature-based architecture and the initial feature-to-table mapping.
- The repository contains a Flutter login UI scaffold. No production backend, live customer data, usage metrics, customer research, or external validation is established by the supplied material.
- Examples and sample amounts in the business brief are illustrative; do not present them as actual tariffs, customer data, or measured results.

## Product Principles

1. Enforce authorization against trusted ownership, assignment, and tenancy records.
2. Preserve the history behind financial and operational records so owners and tenants can understand what happened and why.
3. Calculate invoices from the rates and quantities effective for the billing period, and retain those inputs with issued invoices.
4. Keep domain rules independent of Flutter UI and the eventual backend provider.
5. Deliver the core rental workflow before investing in deferred integrations and advanced analysis.
