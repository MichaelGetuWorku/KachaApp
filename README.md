# kacha

## A new Flutter project for Kacha interview process

## Requirements 
Product Design Document: Bill payment
### 1. Introduction:
   Objective:
   • Bill payment mobile application is used by customers to simplify bill payment process for customers. The customers can see pending bills, make payment and see bill payment history.
### 2. Key Features:
   Device and User Authentication:
   • Device authentication using firebase.
   • Token based user authentication and authorization using JWT tokens from the backend.
   Displaying Pending Bills:
   • Displaying pending bills for a specific customer by using a specific customer code.
   Bill Payment:
   • Pay bills by inserting appropriate information’s needed or by selecting pending bills from the list.
   Payment History:
   • Maintain a comprehensive history of payments made for each bill.
   Reminders/Notifications:
   • Automated reminders for upcoming due dates and overdue bills.
   Reporting and Analytics:
   • Generate reports and analytics to analyze spending patterns and outstanding payments.
### 3. User Roles:
   Customer:
   • Views and pays bills, receives reminders, and accesses payment history.
### 4. System Architecture:
   Frontend (Mobile Application):
   • Flutter for building the UI.
   Authentication:
   • JWT (JSON Web Token) for secure user authentication.
   • Firebase for device authentication.
### 5. User Interface:
   Login/Registration:
   • Welcome Screen
   • Login Screen
   • Registration/Sign-Up Screen
   • Forgot Password Screen
   Home Page:
   • Overview of Bill Summary
   • Overview of upcoming Payments
   • Overview of payment History
   Bill Detail Page:
   • Comprehensive view of each bill's details for paid and pending bills.
   Payment Process:
   • Select Bill for Payment
   • Enter Payment Amount
   • Confirm Payment
   • Payment Success/Failure Screen
   Profile:
   • User Profile Settings
   • Change Password
   • Account Information
   Settings:
   • App Settings (Language, Theme, etc.)
   Transaction History:
   • View All Transactions
   • Search and Filter Transactions
   • Download Transaction Statements
   Logout:
   • Logout Confirmation

# TODO:
### 1: Loading state preferably shimmer loading style
### 2: Profile picture upload
### 3: Delete record
