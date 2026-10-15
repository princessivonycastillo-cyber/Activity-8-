# BrewHaven: Cafe Staff Operations

## Summary
Small cafes often manage orders, inventory, and the menu board through separate notebooks, spreadsheets, and group chats, which causes stock errors, outdated menus, and miscommunication between staff. BrewHaven is a web-based system that gives cafe staff one secure login to handle orders, inventory, and the menu board during a shift, with separate access levels for staff and admin.

First features:
- Secure staff login with show/hide password and temporary lockout after 5 failed attempts
- Staff registration with role selection (Staff or Admin)
- Home dashboard for orders, inventory, and menu board (planned)
- Reusable UI components (buttons and text fields)

## Current stack
Flutter Web / Dart; planned REST API and PostgreSQL.

## Run locally
flutter pub get
flutter run -d chrome

## First checkpoint
Date: October 15, 2026  |  Commit: d2f971e 