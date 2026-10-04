# Weekly reports

> **Note:** These weekly reports were completed using our actual project increment reports, commit history, and development progress as reference. Earlier progress was already documented in our private student repository, while the final week was completed after the project implementation and documentation were finished.

## Week 3 (September 29 to October 4, 2026)

**Done this week**
- Added shared `Order` and `OrderItem` models for consistent order data.
- Added `shared_preferences` persistence so Customer and Staff modes can access the same saved orders.
- Connected actual Customer orders to the Staff Dashboard.
- Added Staff Order Details and status updates for Received, Preparing, Ready, and Completed.
- Updated the Customer Status section so multiple active orders can be viewed instead of only the newest order.
- Added completed Order History.
- Added the QR Scanner using `mobile_scanner`.
- Connected scanned table numbers to the Menu, Cart, Order Confirmation, and saved orders.
- Fixed the QR scanner camera startup and stop behavior.
- Cleaned up Customer navigation between Menu, Cart, Order Confirmation, Order Status, and Role Selection.
- Finished the final README, AI usage documentation, security and privacy checklist, proposal, mockup documentation, design system documentation, and demo video.
- Recorded and uploaded the final TableTap presentation.
- Ran final testing and checked the finished Customer and Staff flow.

**In progress**
- Final repository cleanup, screenshots, and submission checking.

**Blocked or stuck on**
- The QR camera initially did not start because the scanner controller was starting before the camera widget had mounted.
- Customer navigation originally returned all the way to Role Selection from some screens instead of returning to the Menu.
- GitHub did not preview the larger demo video properly, so we compressed the video and also added a backup viewing link.

**Decisions made, and why**
- We kept `shared_preferences` instead of adding Firebase or Supabase because local persistence was enough for the scope of the prototype.
- We kept QR scanning as part of the core flow because identifying the customer's table is one of TableTap's main features.
- We separated returning to the Menu from exiting Customer Mode so the navigation is clearer.
- We kept Staff authentication as a simulated prototype login rather than adding a full authentication system.
- We kept Completed orders in Order History instead of deleting them.

**Hours spent, roughly:** 14–18 hours across about 3 focused days

**Next week I will:**
- Submit the completed TableTap project and make any final fixes if needed.

---

## Week 2 (September 22 to September 28, 2026)

**Done this week**
- Added a working Cart screen to continue the Customer ordering flow.
- Connected the Customer Menu to the Cart screen.
- Added quantity controls from both the Menu and Cart.
- Added cart totals and Customer Notes.
- Refactored the Customer Menu into reusable components.
- Moved menu data into `menu_data.dart`.
- Added reusable menu item, category, and bottom navigation widgets.
- Added the Order Confirmation screen.
- Passed selected items, quantities, totals, and customer notes from the Cart.
- Added temporary queue and table numbers for the prototype.
- Added the Order Status screen.
- Added Received, Preparing, and Ready progress states.
- Added the shared TableTap theme in `theme.dart`.
- Added Asta Sans and configured it in `pubspec.yaml`.
- Refactored Order Confirmation into reusable widgets.
- Ran `flutter analyze` and `flutter test` successfully.

**In progress**
- Shared order data between Customer and Staff.
- Local persistence using `shared_preferences`.
- Staff Order Details and status controls.
- QR Scanner integration.

**Blocked or stuck on**
- `pubspec.lock` changed after Flutter commands even when package changes were not intended.
- Some screen files became too large and needed to be refactored.
- Cart changes needed to stay synchronized with the Menu.
- Order data had to be passed correctly between Cart, Confirmation, and Status.
- Asta Sans needed manual configuration before the shared theme worked correctly.

**Decisions made, and why**
- We split repeated interface elements into reusable widgets to keep the screen files easier to manage.
- We centralized colors, typography, spacing, and status colors in `theme.dart`.
- We kept the QR Scanner for a later increment so we could finish the main Customer ordering flow first.

**Hours spent, roughly:** 14–18 hours, spread across about 3 focused days

**Next week I will:**
- Add shared order models and local persistence.
- Connect Customer orders to the Staff side.
- Add Staff status updates.
- Finish QR scanning and the remaining Customer flow.

---

## Week 1 (September 15 to September 21, 2026)

**Done this week**
- Started implementing the TableTap Flutter project based on our revised proposal, mockup, and design system.
- Added the Role Selection screen so users can choose between Customer and Staff modes.
- Built the initial Customer Menu screen.
- Added menu items with names, prices, and categories.
- Added category filtering so customers can browse specific types of food.
- Added menu search functionality.
- Added quantity controls so customers can begin selecting items for an order.
- Started the Staff flow by adding the Staff Login screen.
- Added the initial Staff Dashboard layout for incoming orders.
- Connected the basic navigation between Role Selection, Customer Menu, Staff Login, and Staff Dashboard.
- Updated the project documentation with the revised proposal, mockup, and design system.
- Added screenshots showing the current progress of the application.

**In progress**
- Completing the Customer ordering flow after the Menu.
- Building the Cart screen.
- Adding Order Confirmation and Order Status screens.
- Improving the Staff Dashboard and connecting it to order data.
- Converting repeated interface elements into reusable widgets.

**Blocked or stuck on**
- The Customer and Staff sides were not yet connected because shared order storage had not been implemented.
- The Staff Dashboard still used prototype or placeholder order information.
- The QR Scanner was not yet integrated, so Customer Mode temporarily went directly to the Menu.
- Some parts of the mockup still needed to be adjusted when translated into actual Flutter layouts.

**Decisions made, and why**
- We kept Customer and Staff modes inside the same Flutter application so the complete ordering process could be demonstrated in one prototype.
- We decided to build the Customer Menu first because it is the main starting point of the ordering experience after scanning a table QR code.
- We kept Staff authentication simple for the prototype instead of implementing a full account system.
- We postponed QR scanning until the main Customer ordering screens were working so we could focus first on the core order flow.
- We continued using the revised mockup and design system as the visual reference for the implementation.

**Hours spent, roughly:** 10–14 hours, spread across about 2 to 3 focused days

**Next week I will:**
- Build the Cart and connect it to the Customer Menu.
- Add quantity editing, totals, and Customer Notes.
- Add the Order Confirmation and Order Status screens.
- Start separating repeated UI elements into reusable widgets.

---