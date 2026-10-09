# Mockup and wireframes

The visual plan for TableTap. The wireframes established the screen structure and
navigation, while the mockup shows the intended colors, typography, layout, and
overall appearance of the application.

## Mockup

The final mockup contains the Customer and Staff flows of TableTap.

**Mockup PDF:** [View the full TableTap mockup](assets/02-mockup.pdf)

The mockup includes the following major screens:

### Role Selection

The Role Selection screen is the starting point of the application. It lets the
user choose between Customer Mode and Staff Mode.

- **Customer** opens the QR Scanner.
- **Staff** opens the Staff Login screen.

### QR Scanner

The QR Scanner is used before the Customer enters the Menu.

The customer scans the QR code assigned to the table. A valid TableTap QR value
contains a table number, such as:

```text
TABLE-07
```

After a successful scan, TableTap opens the Menu and carries the detected table
number into the ordering flow.

### Customer Menu

The Menu displays the available food items and lets the customer:

- browse menu items
- search for an item
- filter items by category
- add items to the Cart
- increase or decrease quantities
- open the Cart
- open the Status section

The final implementation also displays the scanned table number so the customer
can confirm which table the order is connected to.

### Cart

The Cart displays:

- selected items
- item quantities
- individual prices
- total amount
- optional customer notes

The customer can still change quantities before selecting **Place Order**.

### Order Confirmation

After placing an order, the Order Confirmation screen displays:

- queue number
- table number
- order summary
- total amount
- customer notes, when provided

From this screen, the customer can either return to the Menu or select
**Track Order**.

### Order Status

The Order Status screen shows the progress of the order through:

1. Received
2. Preparing
3. Ready
4. Completed

The customer can refresh the screen to load the latest locally saved status.

The mockup also included a Ready notification-style pop-up. In the final
prototype, the Ready status remains part of the order flow, while sound and
vibration notifications remain outside the core implementation.

### Customer Orders and Order History

The final implementation includes a Customer Orders screen so customers can view
more than one active order.

Completed orders are removed from the active list and remain available through
Order History.

### Staff Login

The Staff Login provides simulated access to the Staff side of TableTap.

The login is intended only for the prototype and is not a production
authentication system.

### Staff Dashboard

The Staff Dashboard displays incoming orders and their current status.

Staff can open an order to view its details and continue processing it.

### Staff Order Details

The Order Details screen displays:

- queue number
- table number
- ordered items
- customer notes
- total amount
- current order status

Staff can move an order through the order lifecycle:

```text
Received
→ Preparing
→ Ready
→ Completed
```

## Wireframes

The full screen flow and mockup are included in the PDF linked above.

The Customer flow is:

```text
Role Selection
→ QR Scanner
→ Menu
→ Cart
→ Order Confirmation
→ Order Status
```

The Menu also provides access to the customer's active orders and completed
Order History.

The customer can exit Customer Mode from the Menu and return to Role Selection.

The Staff flow is:

```text
Role Selection
→ Staff Login
→ Staff Dashboard
→ Order Details
→ Update Order Status
```

The Customer and Staff sides are connected through locally stored order data.
An order created in Customer Mode can be opened and updated in Staff Mode when
both are running from the same browser or device storage.

## Screens

### 1. Role Selection

**What is on it:**  
Customer and Staff options.

**What the user does:**  
Chooses which side of TableTap to enter.

**Where actions go:**  
Customer → QR Scanner  
Staff → Staff Login

### 2. QR Scanner

**What is on it:**  
Camera scanning area, scan controls, and a demo/sample-table fallback.

**What the user does:**  
Scans a TableTap QR code assigned to a table.

**Where actions go:**  
Valid QR → Customer Menu  
Back → Role Selection

### 3. Customer Menu

**What is on it:**  
Search bar, category filters, menu item cards, quantity controls, scanned table
number, Cart access, Status access, and Customer Mode exit.

**What the user does:**  
Browses the menu and adds items to the Cart.

**Where actions go:**  
Cart → Cart screen  
Status → Customer Orders  
Exit → Role Selection

### 4. Cart

**What is on it:**  
Selected items, quantities, prices, customer notes, and total amount.

**What the user does:**  
Reviews the order, edits quantities, adds notes, and places the order.

**Where actions go:**  
Place Order → Order Confirmation  
Back → Customer Menu

### 5. Order Confirmation

**What is on it:**  
Queue number, table number, order summary, total amount, and notes.

**What the user does:**  
Confirms the placed order and chooses whether to track it.

**Where actions go:**  
Track Order → Order Status  
Back to Menu → Customer Menu

### 6. Customer Orders

**What is on it:**  
A list of active Customer orders.

**What the user does:**  
Selects which active order to track.

**Where actions go:**  
Selected Order → Order Status  
Order History → Completed Order History

### 7. Order Status

**What is on it:**  
Queue and table information, progress indicators, status message, and refresh
control.

**What the user does:**  
Checks the latest saved order status.

**Where actions go:**  
Back → previous Customer screen  
Back to Menu → Customer Menu

### 8. Order History

**What is on it:**  
Completed Customer orders.

**What the user does:**  
Reviews orders that have already been completed.

**Where actions go:**  
Selected completed order → read-only Order Status/details view

### 9. Staff Login

**What is on it:**  
Staff ID field, password field, and login button.

**What the user does:**  
Enters the prototype Staff credentials.

**Where actions go:**  
Successful login → Staff Dashboard  
Back → Role Selection

### 10. Staff Dashboard

**What is on it:**  
Incoming orders and their current statuses.

**What the user does:**  
Chooses an order to manage.

**Where actions go:**  
Selected order → Staff Order Details

### 11. Staff Order Details

**What is on it:**  
Queue number, table number, ordered items, customer notes, total amount, and
order progress.

**What the user does:**  
Updates the order from Received to Preparing, Ready, and Completed.

**Where actions go:**  
Status update → updated Order Details / Staff Dashboard  
Back → Staff Dashboard

## Final implementation notes

The mockup was used as the visual reference for the final TableTap interface,
but a few interactions were adjusted during development.

The biggest changes were:

- Customer and Staff data use `shared_preferences` instead of a live backend.
- Customers can now view multiple active orders instead of only the latest one.
- Completed Customer orders remain available through Order History.
- QR scanning was fully connected to the table number used by the Menu, Cart,
  and saved Order.
- Customer navigation was cleaned up so returning to the Menu and exiting
  Customer Mode are separate actions.
- Sound and vibration Ready notifications remain a stretch goal rather than part
  of the final core prototype.
