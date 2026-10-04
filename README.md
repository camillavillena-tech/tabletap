# TableTap

> A QR-based dine-in ordering app that allows customers to order from their table and lets staff manage incoming orders and order statuses.

**Live demo:** https://thebeancheese.github.io/tabletap/  
**Demo video:** [View the demo video documentation](docs/05-demo-video.md)  
**Course:** Applications Development and Emerging Technologies (6ADET), Holy Angel University  
**Authors:** [@thebeancheese](https://github.com/thebeancheese) and [@camillavillena-tech](https://github.com/camillavillena-tech)

This repository lives in the authors' own GitHub account and is public on
purpose. There is no `student.json` here and there should not be one: see
`docs/06-security-and-privacy.md` for what a public repo means for secrets and
personal data.

---

## Screenshots

| QR Scanner | Customer Menu | Order Status |
| --- | --- | --- |
| ![QR Scanner](docs/assets/screen-qr-scanner.png) | ![Customer Menu](docs/assets/screen-menu.png) | ![Order Status](docs/assets/screen-order-status.png) |

| Cart | Order Confirmation | Staff Dashboard |
| --- | --- | --- |
| ![Cart](docs/assets/screen-cart.png) | ![Order Confirmation](docs/assets/screen-confirmation.png) | ![Staff Dashboard](docs/assets/screen-staff-dashboard.png) |

## What it does

- Allows customers to scan a QR code assigned to a table before entering the menu.
- Lets customers browse menu items, search and filter by category, add items to a cart, add order notes, and place an order.
- Gives customers a queue number and allows them to track active orders and view completed orders through Order History.
- Allows staff to view incoming orders and update their status from Received to Preparing, Ready, and Completed.
- Stores orders locally so the Customer and Staff sides of the prototype can access the same order information on the same browser or device.

## Built with

| | |
| --- | --- |
| Framework | Flutter (Dart) |
| State | `setState` |
| Storage | `shared_preferences` |
| QR scanner | `mobile_scanner` |
| Preview | `device_preview` |
| Typography | Asta Sans |
| Other packages | See `pubspec.yaml` for the complete package list |

## Running it yourself

```bash
flutter pub get
flutter run -d web-server --web-port 8080
```

Then open:

```text
http://localhost:8080
```

Requires Flutter. This project was developed using Flutter 3.44.2.

When testing the QR scanner in a browser, allow camera access when prompted.

A valid TableTap QR code should contain a value in this format:

```text
TABLE-07
```

The digits after `TABLE-` represent the customer's table number.

### Environment variables

This project currently does not require environment variables, API keys, or
backend credentials.

TableTap uses local storage through `shared_preferences`, so no `.env`
configuration is currently needed.

## Privacy and secrets

- TableTap does not collect or send personal customer information to an external server.
- Order data is stored locally on the current device or browser using `shared_preferences`, so nothing from the ordering flow leaves the device in the current prototype.
- The project currently does not use backend credentials or API keys.
- All sample data, screenshots, and the demo video should contain **no real personal information**.

## Project documentation

| Document | |
| --- | --- |
| [Proposal](docs/01-proposal.md) | the problem, the users, the scope |
| [Mockup and wireframes](docs/02-mockup.md) | what it looks like, and the screen flow |
| [Design system](docs/03-design-system.md) | colors, type, spacing, components |
| [Weekly reports](docs/04-weekly-reports.md) | what happened each week |
| [Demo video](docs/05-demo-video.md) | the recording and what it shows |
| [Security and privacy](docs/06-security-and-privacy.md) | the checklist, filled in |
| [AI usage](AI-USAGE.md) | how AI was used, corrected, and understood during development |

## Status and what is next

The main TableTap prototype is functional.

The Customer side currently supports:

- QR-based table assignment
- Menu browsing, search, and category filtering
- Cart management
- Order notes
- Order confirmation
- Active order tracking
- Completed order history
- Customer exit back to Role Selection

The Staff side currently supports:

- Demo Staff Login
- Incoming Orders dashboard
- Order details
- Order status updates from Received to Preparing, Ready, and Completed
- Viewing saved local orders created from the Customer side

### Known limitations

TableTap currently uses `shared_preferences` instead of a cloud backend. Because
of this, Customer and Staff modes share order information only when they are
using the same browser or device storage.

The Staff Login is for demonstration purposes and is not a production
authentication system.

Order status changes are refreshed manually on the Customer side instead of
updating automatically in real time.

### Possible future improvements

- Add Firebase or Supabase for real-time synchronization between Customer and Staff devices.
- Add proper Staff authentication and account management.
- Add automatic order status updates and customer notifications.
- Improve queue number generation for a production environment.
- Add menu management and item availability controls for staff or administrators.

## Credits

- Packages: see `pubspec.yaml`
- Flutter Material Icons are used throughout the interface.
- Asta Sans is used for the project typography.
- The colors, typography, spacing, and reusable UI styling in `lib/theme.dart` are based on our TableTap Figma prototype.
- QR scanning is implemented using the `mobile_scanner` package.
- Local persistence is implemented using the `shared_preferences` package.
- Device previews use the `device_preview` package.

## AI use

AI tools, including ChatGPT and Claude, were used during development for
brainstorming, code assistance, debugging, refactoring, and documentation.

AI-generated suggestions were reviewed and modified before being used in the
project. A detailed record of how AI was used, what was changed, and examples of
where AI gave incorrect or incomplete suggestions can be found in
[AI-USAGE.md](AI-USAGE.md).

## Licence

MIT, see [LICENSE](LICENSE).
