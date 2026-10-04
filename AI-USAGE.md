# AI usage

This project was built with AI assistance. This file is the record of it. It is
graded as the finals badge, and it is worth 100 points.

Start it in week 1 and keep it up as you go. The commit history of this file is
part of the evidence: a file written all at once the night before the deadline
looks exactly like what it is.

## 1. How We Used AI

### 2026-09-15 - Customer menu implementation

- **Tool:** ChatGPT and Claude
- **What we asked for:** We asked for help building the Customer Menu based on our TableTap mockup and planned customer flow.
- **What it gave back:** It helped generate the Flutter structure for the menu, including the search bar, category filters, item cards, quantity controls, cart total, and bottom navigation.
- **What we kept, what we changed, and why:** We kept the general layout and interaction logic, but adjusted the menu items, prices, visual styling, and navigation so they matched our TableTap design and project requirements.
- **Commit:** https://github.com/thebeancheese/tabletap/commit/8fb2c43

### 2026-09-15 - Staff login and dashboard flow

- **Tool:** ChatGPT and Claude
- **What we asked for:** We asked for help adding the Staff side of the app, starting with a login screen and a basic dashboard.
- **What it gave back:** It generated a Staff Login screen with demo credentials and a placeholder Incoming Orders screen.
- **What we kept, what we changed, and why:** We kept the demo login flow because we did not need real authentication for the prototype. We also kept the dashboard as a placeholder at first because the shared order data had not been implemented yet.
- **Commit:** https://github.com/thebeancheese/tabletap/commit/7e52ab1

### 2026-09-24 - Cart screen and reusable menu components

- **Tool:** ChatGPT and Claude
- **What we asked for:** We asked for help continuing the Customer flow by adding a Cart screen and reducing the size of the Menu screen.
- **What it gave back:** It provided a Cart implementation with quantity controls, totals, customer notes, and reusable widgets for the Menu.
- **What we kept, what we changed, and why:** We kept the Cart behavior and reusable widget approach. We changed parts of the structure because some files were becoming too large, and we wanted the screen logic and reusable UI to be easier to manage.
- **Commit:** https://github.com/thebeancheese/tabletap/commit/4902a32

### 2026-09-24 - Order confirmation flow

- **Tool:** ChatGPT and Claude
- **What we asked for:** We asked how to continue the Customer ordering flow after the Cart.
- **What it gave back:** It generated an Order Confirmation screen showing the queue number, table number, order summary, total, notes, and a Track Order button.
- **What we kept, what we changed, and why:** We kept the confirmation layout and connected it to the Cart. At this stage, the queue number and table number were still temporary because the real shared order model had not been added yet.
- **Commit:** https://github.com/thebeancheese/tabletap/commit/55c5529

### 2026-09-27 - Theme, font, and Order Status

- **Tool:** ChatGPT and Claude
- **What we asked for:** We asked for help integrating our revised design system and reducing repeated colors, spacing, and typography values across the app.
- **What it gave back:** It helped create `theme.dart`, configure the Asta Sans font, connect the shared theme in `main.dart`, and build the first Order Status screen.
- **What we kept, what we changed, and why:** We kept the centralized theme approach because it made the design more consistent. We also changed the original 42dot Sans plan to Asta Sans after checking the official font repository and finding that the font family had been renamed.
- **Commit:** https://github.com/thebeancheese/tabletap/commit/412156e

### 2026-10-01 - Local order storage and shared Customer/Staff data

- **Tool:** ChatGPT and Claude
- **What we asked for:** We asked how to make Customer orders available to the Staff side without adding a full backend.
- **What it gave back:** It suggested using `shared_preferences` with `Order` and `OrderItem` models, JSON conversion, an order storage service, and an order creation service.
- **What we kept, what we changed, and why:** We kept the local persistence approach because it matched the scope of our prototype and allowed the Customer and Staff modes inside the same app to use the same saved order data. We intentionally did not add a cloud backend because simultaneous multi-device communication was outside the current prototype scope.
- **Commit:** https://github.com/thebeancheese/tabletap/commit/af0360e

### 2026-10-01 - Staff order management and Customer status tracking

- **Tool:** ChatGPT and Claude
- **What we asked for:** We asked for help connecting the saved Customer orders to the Staff Dashboard and allowing Staff to update the order status.
- **What it gave back:** It helped build the Incoming Orders list, Staff Order Details screen, status controls, Customer active-orders screen, and refresh logic for the Customer Order Status screen.
- **What we kept, what we changed, and why:** We kept the local status update system, but changed the Customer Status design so it could display multiple active orders instead of only opening the newest one.
- **Commit:** https://github.com/thebeancheese/tabletap/commit/096d8db

  ### 2026-10-03 - Mobile scanner
Tool: ChatGPT and Claude
What we asked for: We asked for help adding a mobile scanner to TableTap so customers can scan the table QR code.
What it gave back: It suggested using the mobile_scanner package and created a scanner screen that opens the camera and reads the scanned code.
What we kept, what we changed, and why: We kept the scanner approach because it was suitable for our prototype. We changed the screen design to match our TableTap theme, connected the scanned value to the table number, and added handling for invalid scans.
Commit: https://github.com/camillavillena-tech/tabletap/commit/a4c8f44430b82db6f167fcd2b93f1449d6dca80b

### 2026-10-04 - Order Confirmation interface
Tool: ChatGPT and Claude
What we asked for: We asked for help improving the Order Confirmation screen so it would match our Figma design.
What it gave back: We used some of the suggested code and structure, but I personally worked on the interface and changed the design to match our Figma. I also coded and adjusted the layout, spacing, colors, and text styles to match the values in theme.dart, so the screen would look consistent with the rest of TableTap.
Commit:https://github.com/camillavillena-tech/tabletap/commit/ea3f3fa43d1aafc9819f7547e697f0a29d40b786

## 2. Where the AI got it wrong

### Case 1 - Outdated font name and incorrect font setup

- **What it gave us:** The AI originally continued using `42dot Sans` because that was the font name used in our Figma design and earlier project notes. It also gave us a `pubspec.yaml` font configuration that needed to be corrected.
- **What was wrong with it:** When we checked the official font repository ourselves, we found that the font family had been renamed to `Asta Sans` about a year earlier. This meant our Flutter project was using an outdated font name even though the Figma file still showed `42dot Sans`. The first font configuration also needed fixing because Flutter requires the font family and font asset weights to be structured correctly in `pubspec.yaml`.
- **What we did instead:** We verified the font through the official repository, downloaded the current Asta Sans font files, updated the font family name in the Flutter project, added the correct font weights in `pubspec.yaml`, and updated the theme so the app consistently used `AstaSans`. We kept the visual design from Figma but changed the implementation to use the current font family.
- **Commit:** https://github.com/thebeancheese/tabletap/commit/412156e

### Case 2 - Only the newest Customer order was accessible

- **What it gave us:** The AI originally suggested making the Status button load the newest saved order directly.
- **What was wrong with it:** If a customer placed more than one active order, only the newest one could be opened from the Status tab. Older active orders were still saved, but the customer had no way to track them.
- **What we did instead:** We questioned what would happen to the first order and changed the design to use a `CustomerOrdersScreen`. The Status tab now opens a list of active orders, and the customer can choose which one to track.
- **Commit:** https://github.com/thebeancheese/tabletap/commit/096d8db

### Case 3 - The AI tried to commit an incomplete refactor

- **What it gave us:** The AI told us to stage and commit the theme and Order Confirmation refactor after new widget files had been created.
- **What was wrong with it:** The new widget files were still empty and the main files had not yet been updated to actually use them. Committing at that point would have recorded an incomplete refactor.
- **What we did instead:** We checked `git status`, noticed that the new files existed without the actual implementation, and stopped the commit. We completed `queue_number_card.dart`, `order_summary_row.dart`, `order_total_card.dart`, and updated the related screens before committing.
- **Commit:** https://github.com/thebeancheese/tabletap/commit/412156e

## 3. Who wrote what

### thebeancheese

#### Written by me

- **Files:** `lib/services/order_storage.dart`, `lib/theme.dart`, and the related `shared_preferences` setup
- **Commits:** `af0360e`, `412156e`
- **What it does and why it is built this way:**  
  I worked on the local order storage using `shared_preferences` so that orders would not disappear whenever the user changed screens or switched between the Customer and Staff sides of the app. The orders are converted into JSON before being saved locally, then loaded again whenever the app needs to display or update them. I used this approach because TableTap only needed local persistence for the prototype and did not require a full online backend.

  I also worked on `theme.dart`, where the colors, spacing, typography, and status colors used throughout TableTap are stored in one place. These values were based on the design system we already created in our Figma prototype, so `theme.dart` was mainly used to translate that visual design into reusable Flutter styles. I built it this way so that the app would stay consistent with our prototype and so that we would not have to repeatedly type the same color values and styles across different screens. It also made later interface changes easier because most of the design values could be updated from one file.

#### The AI-written part I understand best

- **Files:** `lib/screens/cart_screen.dart`, `lib/screens/order_confirmation_screen.dart`, `lib/screens/order_status_screen.dart`, and the Staff order screens
- **Commit:** `096d8db`
- **What it does and why we kept it:**  
  The AI-assisted part I understand best is the order flow between the Customer and Staff sides. When a customer places an order, it is saved locally and can then be viewed by the Staff dashboard. Staff can update the order from Received to Preparing, Ready, and Completed, while the Customer side reloads the same saved order to display its current status. We kept this structure because both sides use the same order data instead of maintaining separate copies of an order.

#### camillavillena-tech

### Written by me

- **File:** `lib/screens/order_confirmation_screen.dart`
- **Commit:** `ea3f3fa43d1aafc9819f7547e697f0a29d40b786`
- **What it does and why it is built this way:** I worked on the Order Confirmation screen and made it match our Figma design. I used some of the suggested structure, then changed the layout, spacing, colors, and text styles myself. The screen shows the queue number, table number, order summary, total, customer notes, and the Track Order and Back to Menu buttons. I connected it to theme.dart so it uses the same colors, spacing, and text styles as the rest of the app.
- 
### The AI-written part I understand best

- **File:** `lib/screens/mobile_scanner.dart`, `tabletap/ios/` `tabletap/android/` , `lib/screens/menu_screen.dart`

- **Commit:** `a4c8f44430b82db6f167fcd2b93f1449d6dca80b` , `8fb2c43daf129160f0692b26dc223ac2bcd749c9`
- **What it does and why we kept it:** The mobile scanner lets customers scan the QR code on their table instead of typing the table number. It uses the mobile_scanner package to open the camera and detect the code. The scanned table number is passed to MenuScreen and then to the Cart so it can be saved with the order. I changed the screen design to match our TableTap theme.  We kept this approach because the package already handles camera access and QR scanning.
