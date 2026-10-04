# Demo video

**File:** `demo.mp4` in this folder, or the hosted link once uploaded  
**Length:** 4 minutes and 50 seconds
**Recorded on:** desktop browser using the Flutter web version of TableTap

## What it shows

- 0:00 Introduction to TableTap and what the app is for
- 0:35 Customer Role Selection and QR Scanner
- 0:40 Scanning a table QR code and opening the Menu
- 1:00 Browsing the Menu and adding items to the Cart
- 1:15 Adding order notes and placing the order
- 1:43 Order Confirmation and Order Status
- 2:25 Staff Login and Staff Dashboard
- 3:00 Opening the same order and updating its status
- 3:32 Returning to the Customer side and refreshing the order
- 3:40 Slight pause for QR-scanning 
- 4:10 Completed Order History
- 4:20 Closing and current project limitations

The video covers the main TableTap customer flow from scanning a table QR code
up to placing and tracking an order.

It also shows the Staff side, where incoming orders can be viewed and their
status can be updated from Received to Preparing, Ready, and Completed.

The QR scanner is demonstrated using a sample TableTap QR code such as
`TABLE-03`.

One of the main parts shown in the demo is how the Customer and Staff sides use
the same locally stored order data through `shared_preferences`.

## Video file size

The final recording is approximately 28 MB, which is already small enough to be
included in the repository without additional compression.

If a future recording becomes too large, it can be compressed using FFmpeg:

```bash
ffmpeg -i input.mp4 -vcodec libx264 -crf 28 -preset slow \
       -vf scale=-2:720 -acodec aac -b:a 96k demo.mp4