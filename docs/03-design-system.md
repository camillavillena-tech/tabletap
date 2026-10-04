# Design system

This document contains the final design system used for TableTap.

The design system was first created from our Figma prototype and then translated
into Flutter through `lib/theme.dart` and reusable widgets.

**Visual reference:** [Design system PDF](assets/03-revised-design-system.pdf)

## Palette

TableTap uses a warm light theme with orange as the main brand color.

### Main colors

| Role | Hex | Used for |
| --- | --- | --- |
| Primary | `#AE3C00` | Main buttons, important actions, active states |
| onPrimary | `#FFFFFF` | Text and icons placed on Primary |
| Secondary | `#E47526` | Highlights, icons, secondary emphasis |
| onSecondary | `#290E07` | Text and icons placed on Secondary |
| Surface | `#FDF8EF` | Main app background |
| Surface Container | `#FFFFFF` | Cards, dialogs, and input areas |
| Primary Text | `#000000` | Main menu text, headings, and important information |
| Secondary Text | `#666666` | Search text, descriptions, and supporting information |
| onSurface | `#290E07` | Main body text |
| Navigation Text | `#726C6C` | Inactive bottom navigation icons and labels |
| Error | `#D32F2F` | Validation errors and destructive/error states |
| onError | `#FFFFFF` | Text and icons placed on Error |

### Order status colors

| Status | Hex | Purpose |
| --- | --- | --- |
| Received / New | `#FB5154` | Newly received orders |
| Preparing | `#ECB716` | Orders currently being prepared |
| Ready | `#29A500` | Orders ready for pickup |
| Completed | `#62920A` | Completed or picked-up orders |
| Inactive | `#BDBDBD` | Future or inactive progress steps |

These colors are centralized in `lib/theme.dart` so screens do not need to
repeat the same color values.

### Contrast

The revised design system checked the main color combinations used in the app:

- `#290E07` on `#FDF8EF` — 17.11:1, Pass AAA
- `#FFFFFF` on `#AE3C00` — 6.09:1, Pass AA
- `#290E07` on `#E47526` — 5.92:1, Pass AA
- `#666666` on `#FDF8EF` — 5.43:1, Pass AA
- `#726C6C` on `#FDF8EF` — 4.87:1, Pass AA

### Dark mode

TableTap uses a light-only theme for the current prototype.

The interface was designed around a warm `#FDF8EF` background, white cards, and
strong status colors. Adding a complete dark theme would increase the amount of
implementation and testing without supporting a core feature of the prototype.

## Type scale

### Font family

The final Flutter project uses **Asta Sans**.

Our original Figma design and revised design-system PDF still referred to the
font as **42dot Sans**, but while implementing the app we checked the current
font repository and found that the family had been renamed to Asta Sans.

The visual style remains based on the same design system, while the Flutter
project uses the current font family name.

| Style | Flutter slot | Size | Weight | Used for |
| --- | --- | --- | --- | --- |
| Display | `displaySmall` | 48sp | Bold / w700 | Main queue number |
| Display Medium | `headlineMedium` | 36sp | Bold / w700 | Dashboard count numbers |
| Heading | `headlineSmall` | 24sp | Bold / w700 | Welcome headings and major page headings |
| Title | `titleMedium` | 18sp | SemiBold / w600 | Screen titles and section headings |
| Body Large | `bodyLarge` | 16sp | SemiBold / w600 | Ordered Items, Customer Notes, and important body text |
| Body Medium | `bodyMedium` | 14sp | Regular / w400 | Supporting text, descriptions, and secondary order information |
| Caption | `labelSmall` | 12sp | Regular / w400 | Hints, smaller details, and supporting labels |

The text styles are stored in the shared Flutter theme so screens can use named
theme slots instead of repeating individual `TextStyle` values.

## Spacing

TableTap uses a spacing scale based on a 4px unit.

| Token | Value | Typical use |
| --- | ---: | --- |
| `xs` | 4px | Very small internal gaps |
| `sm` | 8px | Icons and closely related elements |
| `md` | 16px | Card padding and list-item gaps |
| `lg` | 24px | Screen edge padding and section gaps |
| `xl` | 32px | Large layout separation |

These values are stored in `AppSpacing` inside `lib/theme.dart`.

Example:

```dart
class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
}
```

Using shared spacing values keeps padding and gaps consistent between screens.

## Components

The final implementation uses reusable widgets for repeated interface elements.

| Component | File | Main parameters | Used on |
| --- | --- | --- | --- |
| Bottom Navigation | `lib/widgets/app_bottom_nav.dart` | current index and tap callback | Customer Menu, Cart, Status navigation |
| Menu Category Bar | `lib/widgets/menu_category_bar.dart` | categories, selected category, selection callback | Customer Menu |
| Menu Item Card | `lib/widgets/menu_item_card.dart` | menu item data, quantity, add/remove callbacks | Customer Menu |
| Queue Number Card | `lib/widgets/queue_number_card.dart` | queue number, table number | Order Confirmation, Order Status |
| Order Summary Row | `lib/widgets/order_summary_row.dart` | item name, quantity, subtotal | Order Confirmation |
| Order Total Card | `lib/widgets/order_total_card.dart` | total amount | Order Confirmation |
| Order Card | `lib/widgets/order_card.dart` | order data and tap behavior | Staff Dashboard and order lists |

The app also uses screen-specific helper widgets and methods where a visual
element is only used in one place.

### Component rules

Reusable widgets follow two main rules:

- They receive the data and callbacks they need instead of owning the parent
  screen's state.
- `const` constructors are used where possible.

This makes repeated interface pieces easier to maintain and keeps screen files
focused on navigation and state.

## Theme file

The final Flutter theme is assembled in:

```text
lib/theme.dart
```

It contains the main color scheme, text theme, spacing constants, status colors,
and shared theme settings used across TableTap.

The design values in this file were taken from our Figma prototype and revised
design system, then adjusted where needed during implementation.

## Changes since the last version

### Palette

The prelim design mainly treated colors as individual brand colors.

In the revised version, colors were assigned named Flutter roles such as
Primary, Secondary, Surface, and onSurface. Separate semantic colors were also
added for Received, Preparing, Ready, Completed, and inactive states.

This made the design easier to reuse through the Flutter theme instead of
styling every screen separately.

### Background and surfaces

The earlier design mostly used a plain white background.

The final design uses the warm `#FDF8EF` surface with white cards and content
containers. This gives clearer separation between the page background and the
content placed on top of it.

### Typography

The original design listed heading, body, and caption sizes mainly as visual
rules.

The revised system mapped the type scale to Flutter `TextTheme` slots so the
same styles could be reused throughout the application.

During implementation, the font family name was also updated from **42dot Sans**
to **Asta Sans** after we verified the current font repository.

### Spacing

The prelim design used general spacing values such as 8px, 16px, and 24px.

The final system uses reusable spacing constants based on a 4px unit:

```text
4, 8, 16, 24, 32
```

### Components

The revised design system originally planned several reusable components.

During implementation, the final reusable widget set changed to match the
actual screens that needed shared UI. Menu categories, menu item cards, bottom
navigation, queue information, order summary rows, totals, and order cards were
separated into reusable widget files.

### Order progress

The design system originally planned a shared `OrderProgress` component for
both Customer and Staff screens.

In the final implementation, the same Received → Preparing → Ready → Completed
lifecycle is still used across both sides, but parts of the status UI are built
inside their respective screens instead of relying on one shared
`order_progress.dart` widget.

### Dark mode

Dark mode was not explicitly decided in the earliest design.

The final prototype remains light-only because the Figma mockup and TableTap
branding were designed around warm light surfaces, and a second theme was not
necessary for demonstrating the core Customer and Staff flow.
