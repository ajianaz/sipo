# Sipo — Architecture Document

> **Sipo** — Simple POS v0.1.0
> **Date:** 2026-07-31
> **Status:** Draft — awaiting approval

---

## 1. High-Level Architecture

```
┌─────────────────────────────────────┐
│           Presentation              │
│  ┌─────────┐ ┌──────────┐          │
│  │ Pages   │ │ Widgets  │          │
│  └────┬────┘ └────┬─────┘          │
│       └──────┬────┘                │
│              ▼                      │
│  ┌───────────────────┐             │
│  │    Riverpod        │  ← State    │
│  │    Providers       │    Layer    │
│  └────────┬──────────┘             │
├───────────┼────────────────────────┤
│           ▼                      │
│  ┌───────────────────┐             │
│  │   Repositories    │  ← Data     │
│  │   (DAOs + Logic)  │    Layer    │
│  └────────┬──────────┘             │
│           ▼                      │
│  ┌───────────────────┐             │
│  │   Drift (SQLite)  │  ← Storage  │
│  │   Local Database   │    Layer    │
│  └───────────────────┘             │
└─────────────────────────────────────┘
         Offline-Only, Device-Bound
```

**No backend. No API. 100% local.**

---

## 2. Tech Stack

| Layer | Tech | Version | Why |
|-------|------|---------|-----|
| **Framework** | Flutter | 3.x | Cross-platform, proven in Usago |
| **Language** | Dart | 3.x | Native Flutter |
| **State Management** | Riverpod | 2.x | Simple, testable, no boilerplate |
| **Local Database** | Drift | 2.x | Type-safe SQLite, code-gen, proven in Usago |
| **Code Generation** | build_runner | — | Drift + Riverpod code-gen |
| **Navigation** | GoRouter | 14.x | Declarative routing, type-safe |
| **Testing** | flutter_test + drift_test | — | Unit + integration |
| **Linting** | flutter_lints + very_good_analysis | — | Strict lint rules |

**Package Manager:** Bun (sesuai preference Sibung).

---

## 3. Project Structure

```
sipo/
├── app/                          ← Flutter app root
│   ├── lib/
│   │   ├── main.dart             ← Entry point
│   │   ├── app.dart              ← MaterialApp + GoRouter setup
│   │   ├── data/
│   │   │   ├── database/
│   │   │   │   ├── app_database.dart        ← Drift DB definition
│   │   │   │   ├── app_database.g.dart      ← Generated
│   │   │   │   ├── tables/
│   │   │   │   │   ├── satuan_table.dart
│   │   │   │   │   ├── barang_table.dart
│   │   │   │   │   ├── customer_table.dart
│   │   │   │   │   ├── transaksi_table.dart
│   │   │   │   │   └── transaksi_detail_table.dart
│   │   │   │   └── daos/
│   │   │   │       ├── satuan_dao.dart
│   │   │   │       ├── barang_dao.dart
│   │   │   │       ├── customer_dao.dart
│   │   │   │       ├── transaksi_dao.dart
│   │   │   │       └── analitik_dao.dart
│   │   │   └── repositories/
│   │   │       ├── satuan_repository.dart
│   │   │       ├── barang_repository.dart
│   │   │       ├── customer_repository.dart
│   │   │       ├── transaksi_repository.dart
│   │   │       └── analitik_repository.dart
│   │   ├── domain/
│   │   │   └── models/
│   │   │       ├── satuan.dart
│   │   │       ├── barang.dart
│   │   │       ├── customer.dart
│   │   │       ├── transaksi.dart
│   │   │       ├── transaksi_item.dart    ← Cart item (temp)
│   │   │       └── analitik_summary.dart
│   │   ├── features/
│   │   │   ├── beranda/
│   │   │   │   └── beranda_page.dart
│   │   │   ├── satuan/
│   │   │   │   ├── satuan_page.dart        ← List
│   │   │   │   ├── satuan_form_sheet.dart  ← Add/Edit
│   │   │   │   └── providers/
│   │   │   │       └── satuan_provider.dart
│   │   │   ├── barang/
│   │   │   │   ├── barang_page.dart
│   │   │   │   ├── barang_form_sheet.dart
│   │   │   │   └── providers/
│   │   │   │       └── barang_provider.dart
│   │   │   ├── customer/
│   │   │   │   ├── customer_page.dart
│   │   │   │   ├── customer_form_sheet.dart
│   │   │   │   └── providers/
│   │   │   │       └── customer_provider.dart
│   │   │   ├── pembelian/
│   │   │   │   ├── pembelian_page.dart     ← Form transaksi
│   │   │   │   └── providers/
│   │   │   │       └── pembelian_provider.dart
│   │   │   ├── penjualan/
│   │   │   │   ├── penjualan_page.dart
│   │   │   │   └── providers/
│   │   │   │       └── penjualan_provider.dart
│   │   │   ├── analitik/
│   │   │   │   ├── analitik_page.dart
│   │   │   │   └── providers/
│   │   │   │       └── analitik_provider.dart
│   │   │   └── transaksi/
│   │   │       ├── transaksi_detail_page.dart  ← Detail/riwayat
│   │   │       └── providers/
│   │   │           └── transaksi_provider.dart
│   │   ├── shared/
│   │   │   ├── widgets/
│   │   │   │   ├── sipo_bottom_nav.dart
│   │   │   │   ├── sipo_app_bar.dart
│   │   │   │   ├── sipo_empty_state.dart
│   │   │   │   ├── sipo_search_bar.dart
│   │   │   │   ├── quantity_stepper.dart
│   │   │   │   ├── item_card.dart
│   │   │   │   └── confirm_sheet.dart
│   │   │   ├── theme/
│   │   │   │   ├── sipo_theme.dart
│   │   │   │   ├── sipo_colors.dart
│   │   │   │   └── sipo_typography.dart
│   │   │   └── utils/
│   │   │       ├── currency_formatter.dart
│   │   │       ├── date_formatter.dart
│   │   │       └── decimal_validator.dart
│   │   └── routing/
│   │       └── app_router.dart      ← GoRouter config
│   ├── test/
│   │   ├── data/
│   │   │   └── database/
│   │   │       └── app_database_test.dart
│   │   ├── features/
│   │   │   └── ...per feature
│   │   └── utils/
│   ├── analysis_options.yaml
│   └── pubspec.yaml
├── docs/
│   └── plans/                        ← Planning docs (this dir)
├── .github/
│   └── workflows/
│       └── ci.yml                    ← CI pipeline
├── .gitignore
├── README.md
└── CHANGELOG.md
```

**Key decisions:**
- **Single app directory** (no monorepo/Melos) — sesuai scope sederhana.
- **Feature-first structure** — setiap feature punya page, form, provider sendiri.
- **No separate domain layer complexity** — domain/models minimal, repository langsung wraps DAO.
- **Shared widgets & utils** — komponen reusable di `shared/`.

---

## 4. Key Architecture Decisions

### 4.1 Riverpod over BLoC

| Factor | Riverpod | BLoC |
|--------|----------|------|
| Boilerplate | Minimal | Heavy (event, state, handler per feature) |
| Testability | ✅ Override providers | ✅ Mock Bloc |
| Learning curve | Low | Medium |
| Fit for scope | ✅ Simple CRUD + lists | Overkill |

**Decision:** Riverpod 2.x. Scope = CRUD + simple list views. BLoC overkill.

### 4.2 Drift over sqflite

| Factor | Drift | sqflite |
|--------|-------|---------|
| Type safety | ✅ Generated Dart classes | ❌ Manual maps |
| Migrations | ✅ Built-in | ❌ Manual |
| Code-gen | ✅ DAOs, tables, queries | ❌ Raw SQL strings |
| Proven in | ✅ Usago Mobile | — |

**Decision:** Drift. Already proven in Usago, type-safe, code-gen saves time.

### 4.3 GoRouter over Navigator 2

| Factor | GoRouter | Navigator 2 |
|--------|---------|-------------|
| Declarative | ✅ | ❌ Imperative |
| Deep linking | ✅ | Manual |
| Type-safe | ✅ | ❌ |
| Setup effort | Low | High |

**Decision:** GoRouter. Simple declarative routing, type-safe paths.

### 4.4 No Backend (v0.1)

**Decision:** 100% offline SQLite. No API, no auth, no sync. Add sync layer in v0.3+ if needed.

**Rationale:**
- Target user: UMKM kecil, single device, intermittent connectivity.
- Reduces complexity by 50%+ (no auth flow, no conflict resolution, no API errors).
- Can add sync later with minimal refactor — data layer is already abstracted behind repositories.

---

## 5. Data Flow

### 5.1 Transaction Flow

```
User Input (Page)
    ↓
Provider (Riverpod) — manages cart state
    ↓
Repository — validates business rules
    ↓
DAO (Drift) — executes SQL transaction
    ↓
SQLite — atomic write
    ↓
UI updates via Riverpod invalidate/refresh
```

### 5.2 Analytics Flow

```
User selects filter (date range, barang)
    ↓
AnalitikProvider — holds filter state
    ↓
AnalitikRepository — builds query params
    ↓
AnalitikDAO — executes aggregation SQL (SUM, GROUP BY)
    ↓
Returns List<AnalitikSummary>
    ↓
UI renders cards/tables
```

---

## 6. Theme System

Minimal, no over-engineering. One theme file, one color file.

```dart
// sipo_colors.dart
class SipoColors {
  static const primary = Color(0xFF2563EB);    // Blue — trust, reliability
  static const onPrimary = Color(0xFFFFFFFF);
  static const success = Color(0xFF16A34A);     // Green — penjualan
  static const warning = Color(0xFFD97706);     // Amber — pembelian
  static const surface = Color(0xFFF8FAFC);      // Light gray background
  static const onSurface = Color(0xFF1E293B);   // Dark text
  static const muted = Color(0xFF94A3B8);       // Inactive elements
  static const danger = Color(0xFFDC2626);       // Delete/hapus
}
```

**Rationale:**
- Blue = reliability (POS = trust with money).
- Green/Amber = visual distinction penjualan vs pembelian.
- Minimal palette — easy to maintain, consistent.

---

## 7. Error Handling Strategy

| Error Type | Handler | User Sees |
|------------|---------|-----------|
| DB write failure | try-catch in repository | SnackBar "Gagal menyimpan" |
| Validation error | Form validation layer | Field error message |
| Empty search | DAO returns empty list | Empty state widget |
| Decimal overflow | DecimalValidator | Field error "Maks 2 digit" |

No global error boundary needed for v0.1 scope.

---

## 8. Testing Strategy

| Type | Coverage | Tool |
|------|----------|------|
| **Unit** | Repositories, formatters, validators | flutter_test |
| **DAO** | Database queries (in-memory SQLite) | drift_test + NativeDatabase.memory() |
| **Widget** | Key pages (form validation, list rendering) | flutter_test |
| **Integration** | Full transaction flow (add barang → create transaksi → verify analitik) | flutter_test integration |

**Minimum:** DAO tests (proven pattern from Usago) + formatter tests.

---

## 9. CI/CD Pipeline

### GitHub Actions — `ci.yml`

```yaml
triggers: push to develop, pull_request to develop

jobs:
  lint:
    - flutter analyze
    - dart format --set-exit-if-changed

  test:
    - flutter test --coverage
    - Upload coverage artifact

  build:
    needs: [lint, test]
    - flutter build apk --release
    - Upload APK artifact
```

**Release pipeline** (v0.2+): Tag-based → build → Play Store deploy.

---

## 10. Dependencies (pubspec.yaml)

```yaml
dependencies:
  flutter:
    sdk: flutter
  riverpod: ^2.x
  flutter_riverpod: ^2.x
  drift: ^2.x
  sqlite3_flutter_libs: ^0.5.x    # SQLite native
  path_provider: ^2.x              # DB path
  go_router: ^14.x
  intl: ^0.19.x                   # Number/date formatting
  uuid: ^4.x                       # ID generation (if needed)

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.x
  build_runner: ^2.x
  drift_dev: ^2.x
```

Minimal dependencies. No state management framework bloat. No unnecessary utility packages.
