# Proposal

## The problem, in one sentence

Customers at busy fast-food restaurants often spend unnecessary time waiting in
long lines just to place an order, even after they have already found a table.

## Who it is for

TableTap is designed for dine-in customers at busy fast-food restaurants and
restaurant staff responsible for receiving and managing incoming orders.

Customers use the app to scan the QR code assigned to their table, browse the
menu, place an order, and track its progress. Staff use the Staff side of the
same prototype to view incoming orders and update their status.

## Core features

The final TableTap prototype includes:

- **Role-Based Entry**  
  A Role Selection screen allows the user to enter either Customer Mode or
  Staff Mode.

- **QR-Coded Tables**  
  Customers scan a QR code containing a table value such as `TABLE-07`.
  TableTap extracts the table number and carries it through the Menu, Cart,
  Order Confirmation, and saved Order data. A demo/sample-table option is also
  available if camera scanning cannot be used.

- **Menu Browsing and Ordering**  
  Customers can browse menu items, search the menu, filter items by category,
  change item quantities, add items to a cart, add optional customer notes,
  and place an order.

- **Order Confirmation**  
  After placing an order, the customer sees the queue number, table number,
  ordered items, notes, and total amount.

- **Order Status Tracking**  
  Customers can view an order's progress through Received, Preparing, Ready,
  and Completed. The latest saved status can be loaded using the refresh
  control.

- **Active Orders and Order History**  
  Customers can view multiple active orders instead of being limited to only
  the newest one. Completed orders are moved out of the active list and remain
  available in Order History.

- **Staff Login and Staff Order Management**  
  The Staff side uses a simulated login for the prototype. Staff can view
  incoming orders, open Order Details, and update an order from Received to
  Preparing, Ready, and Completed.

- **Local Persistence**  
  Orders are stored locally using `shared_preferences`, allowing the Customer
  and Staff sides running in the same browser or device to access the same
  order data.

The revised proposal identified Role Selection, QR-coded tables, Menu Browsing
and Ordering, Order Status Tracking, and Staff Order Management as the main MVP
features. QR scanning was kept as a core feature because identifying the
customer's table is central to the TableTap flow.

## Out of scope, and why

The following features were left outside the final core prototype:

- **Real-time synchronization between separate devices**  
  The original idea involved Customer and Staff devices sharing live order data.
  We reduced the scope and instead simulated both roles inside the same Flutter
  application using shared local order data. A full backend would have added
  more development and debugging work than the remaining project time allowed.

- **Cloud backend such as Firebase or Supabase**  
  The current prototype only needs a small amount of local data, so a hosted
  backend was not required for demonstrating the complete order lifecycle.

- **Sound and vibration Ready notifications**  
  The Ready state itself remains part of the app, but platform notification,
  sound, and vibration support stayed as a stretch goal.

- **Estimated waiting time**  
  This remained a stretch goal because producing a meaningful estimate would
  require extra queue and timing logic that is not necessary for demonstrating
  the ordering workflow.

- **Quick Re-order**  
  Completed Order History was implemented, but automatically rebuilding a new
  cart from a previous order was not included in the final prototype.

- **Production Staff authentication**  
  The Staff Login is intentionally simulated for demonstration. It is not a
  production authentication or account-management system.

## Data the app remembers, and where it is saved

TableTap uses `shared_preferences` for local persistence.

The revised proposal selected `shared_preferences` because the prototype only
needed to store a small amount of simulated data, and both Customer and Staff
views run inside the same application. The tradeoff is that the saved data does
not synchronize between separate devices.

| Data | Fields | Where it is saved |
| --- | --- | --- |
| Order | order ID, queue number, table number, ordered items, total amount, status, customer notes, date/time | JSON-encoded order data in `shared_preferences` |
| Order Items | item name, quantity, price | embedded inside each saved Order |
| Menu Items | name, category, description, price, image and related menu data | predefined sample data in the application |

The proposal originally planned to test persistence by saving an order,
restarting the app, and checking whether the order and its status loaded
correctly. That persistence flow is now implemented in the final project.

## Risks

### Customer and Staff data consistency

The main local-data risk is making sure an order created in Customer Mode
appears correctly in Staff Mode, and that Staff status changes are reflected
when the Customer checks the order again.

This was one of the revised proposal's main risks after the live multi-device
backend was removed from scope.

In the final prototype, both modes use the same locally stored orders through
`shared_preferences`. The Staff side can update an order and the Customer side
can reload the saved order to see the latest status.

### QR code scanning

QR scanning depends on camera permission and browser/device compatibility. The
proposal planned to test `mobile_scanner` using a value such as `TABLE-02`, and
to provide a fallback if camera access was unavailable.

In the final prototype, QR scanning is implemented using `mobile_scanner`. A
valid value such as `TABLE-07` is parsed into a table number and passed into the
Customer ordering flow. A demo/sample-table option remains available for cases
where camera scanning cannot be used.

## Changes since the last version

### 2026-09-27

- We finalized `shared_preferences` as the persistence method for the prototype.
- We kept Customer and Staff interaction inside the same application instead of
  adding a full multi-device backend.
- We centralized the app's design values in `theme.dart` based on our Figma
  design system.
- Order Status tracking became part of the working Customer flow.

### 2026-10-01

- We connected Customer orders to the Staff Dashboard using shared local order
  data.
- Staff could now open an order and update it through Received, Preparing,
  Ready, and Completed.
- We changed the Customer Status flow so users could view multiple active
  orders instead of only the newest saved order.

### 2026-10-03

- We completed the QR-based table flow using `mobile_scanner`.
- The scanned table number is now carried through the Menu, Cart, Order
  Confirmation, and saved Order.
- We added completed Order History.
- We cleaned up Customer navigation so Back to Menu returns to the Menu while
  exiting Customer Mode is handled separately from the Menu screen.

### 2026-10-04

- We finalized the project documentation, demo flow, security/privacy review,
  README, and AI usage documentation.
- The final prototype now demonstrates the complete TableTap Customer and Staff
  order lifecycle using local persistence.

The largest change from the earlier proposal was reducing the backend scope.
The revised proposal already documented the move away from live multi-device
synchronization toward shared local orders so the full order lifecycle could
still be demonstrated within the available development time.
