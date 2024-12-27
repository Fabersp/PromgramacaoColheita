# Harvest Scheduling App

## Overview
The Harvest Scheduling App was developed in **2014** to optimize and manage crop harvesting schedules for various types of crops, including **soybeans, corn, and sorghum**. It allows farmers and agronomists to plan, track, and analyze their harvest cycles efficiently.

## Technologies Used

### 1. **Objective-C**
- The application was primarily developed using **Objective-C**, a powerful and widely used programming language for iOS application development.

### 2. **UIKit Framework**
- Utilized for building the graphical user interface (GUI), managing event handling, and rendering content on the screen.
- Components such as `UITableViewController`, `UIBarButtonItem`, and `UIDatePicker` were used extensively.

### 3. **Core Data**
- The app uses **Core Data** for local data persistence, enabling storage, retrieval, and manipulation of crop data, schedules, and user inputs.

### 4. **AdMob (Google Ads SDK)**
- Integrated **Google AdMob** for displaying banner and interstitial advertisements.
- Ad units were configured with test device identifiers.

### 5. **GADBannerView and GADInterstitial**
- Used to display advertising banners and full-screen ads.
- Interstitial ads are displayed at specific points in the user flow.

### 6. **NSDate and NSDateFormatter**
- Used for date manipulation and formatting in crop scheduling features.

### 7. **NSManagedObjectContext**
- Manages interactions with the Core Data store, handling CRUD operations efficiently.

### 8. **RMDateSelectionViewController**
- A third-party library used for date selection and user-friendly calendar pop-ups.

### 9. **MessageUI Framework**
- Enabled email sharing capabilities for exporting harvest reports in PDF format.

### 10. **QuartzCore**
- Utilized for rendering custom graphics and animations.

### 11. **Custom TableView Cells**
- Implemented custom cells (`CalagemCell`) for displaying detailed crop data, including owner, property, planting date, and crop variety.

### 12. **PDF Generation**
- The app can generate PDF reports using QuartzCore and `UIGraphicsPDFContext`.
- Reports include detailed crop summaries, soil data, and analysis results.

## Key Features

- **Harvest Scheduling:** Plan and predict harvest dates based on planting cycles and delays.
- **Data Management:** Store and retrieve crop-related data using Core Data.
- **Calendar Integration:** Easily select planting and predicted harvest dates using RMDateSelectionViewController.
- **Email Integration:** Share crop reports via email with PDF attachments.
- **Ad Integration:** Monetize the app with AdMob ads.
- **User-Friendly Interface:** Clear navigation and data presentation through UITableViewController.

## Conclusion
The Harvest Scheduling App combines powerful iOS technologies with intuitive user interfaces to deliver a robust solution for crop management. It remains a valuable tool for agricultural professionals seeking efficiency and data-driven decision-making.

