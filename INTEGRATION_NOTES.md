# Activity 9 - Integration Notes (BrewHaven)

Do NOT run `flutter create` or `git init`. Work inside your existing `semester_project`.

## 1. Add the new file
Copy `lib/screens/report_form_screen.dart` into your project's `lib/screens/`.

## 2. lib/app.dart  (add import + route)
```dart
import 'screens/report_form_screen.dart';

// inside the MaterialApp routes map:
'/report': (_) => const ReportFormScreen(),
```

## 3. lib/screens/home_screen.dart  (button to open the form)
```dart
AppButton(
  label: 'Report an Issue',
  onPressed: () => Navigator.pushNamed(context, '/report'),
),
```
This also gives you the 2nd place AppButton is used (Screenshot 2).
If login_screen.dart already uses AppButton, that counts as well.

## 4. Match YOUR widget APIs
The screen assumes these constructors. If yours differ, edit the call sites in report_form_screen.dart instead:

```dart
AppButton(label: String, onPressed: VoidCallback?)        // onPressed null = disabled
AppTextField(controller:, label:, validator:, maxLines:)  // wraps TextFormField
```
If AppTextField has no `maxLines`, add `this.maxLines = 1` and pass it to the inner TextFormField.
If AppButton's onPressed is non-nullable, change it to `VoidCallback?` so it can be disabled.

## 5. Flutter version
`DropdownButtonFormField(initialValue: ...)` needs Flutter 3.33+. On older SDKs use `value:` instead.

## 6. How to trigger each state (for screenshots + demo)
| State   | How |
|---------|-----|
| EMPTY   | Open /report from Home - no reports yet |
| LOADING | Fill valid form -> Submit -> screenshot within 3 seconds |
| SUCCESS | Submit with the failure switch OFF -> wait 3 seconds |
| ERROR   | Turn the failure switch ON -> Submit -> wait 3 seconds. Then click Retry |

## 7. Git (same repo, same branch)
```
git status
git add .
git commit -m "Add report form and Flutter UI states"
git push
```
