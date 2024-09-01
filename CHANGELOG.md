# Changelog

## [v0.2.7] - 2024-08-03
### Changed
- Commented `snackbar.dart` and `order_form.dart`.
- Clicking or long pressing on about links copies to clipboard.
- Centered the `DataTable` headers in `order_list` page
- Renamed `db_server.dart` to `database_connection.dart`.
- Renamed `edit_item.dart` to `edit_oder.dart` alongside the functions and locale entries.
- `home_page.dart` has prices on the right and detail pages show up on top.
-  `edit_item.dart` shows empty string when orders are zero.
- Update order function changed to accept `order? ` solve error on `edit_order.dart`.

### Added
- New format rule for phone numbers with 12 digits.
- Clear button for search field to unfocus even when the field is empty.

### Removed
- Unnecessary icons and images.
- `theme.dart` whose content is simplified and moved to main.

### Fixed
- Pixel overflow on hero views.
- Keyboard overflow on `edit_item.dart` dialog
---
<br>

## [v0.2.6] - 2024-07-19
### Changed
- Formatted `CHANGELOG.md` by adding `[]` to tags and spaces between versions.
- Home page column into 2 columns
- `custom_theme.dart` to `themes.dart` while simplifying by using color seeds.
- Extracted widgets of home page to `home_page_widgets.dart`.

### Added
- Search field to home page which shows searched products
- Sending notifications when clicking on notification settings.
- System notification permission pop up if notifications aren't enabled.
- New icon for notification area.
- `notifs_helper.dart`.
- `home_page_widgets.dart`.
---
<br>

## [v0.2.5] - 2024-07-18
### Changed
- Parameterized SQL queries in `database.dart`.
- Changed `features.txt` to `CHANGELOG.md` and `TODOs.md`.
- Transitioned file architecture to MVC.
- Optimized and extracted `showSnackbar` function.
- Renamed `order_class` file to `order`.
- Directly created an instance of `dbs` in `database_service`.
- Disabled swipe functionality on the `order_list` page.
- Changed the navigation bar color for the light theme.
- Updated the homepage title to "Yildiz".
- General code cleanup.

### Added
- File architecture change into MVC.
- `CHANGELOG.md`.
- `TODOs.md`.

### Removed
- Unnecessary `package:yildiz_app` from imports.
- `features.txt`.
- Function and file `create_orders`.

### Fixed
- Orders order change after editing by adding order by to select.
---
<br>

## [v0.2.4] - 2024-06-20
### Added
- Small changes and code cleanup.
- SSL mode switch to database connection.
- Port number in database connection settings.

### Fixed
- Issues with editing items; undo functionality now works.
---
<br>

## [v0.2.3] - 2024-06-19
### Added
- Page swipe functionality.
- Merged translations into a single JSON file and made necessary adjustments.

### Changed
- Disabled context warning in `analysis_options`.
- Made `edit order` functional with validation.
- Created an edit dialog with changes made to `order_form`.
---
<br>

## [v0.2.2] - 2024-06-18
### Added
- Functionality to the select all button.

### Fixed
- An issue with the changed variable name `ip_address`.
---
<br>

## [v0.2.1] - 2024-06-17
### Added
- `select all` button (functionality pending).
- `variables.env` for environment variables.
- Changed window settings from `window_size` to `window_manager`.
---
<br>

## [v0.2.0] - 2024-06-17
### Added
- Cloud server connection (thanks to aiven.io).
- System defaults for theme and language settings.
- New blue color theme with renamed colors.
- New logo, now centered.

### Changed
- User account menus updated.
---
<br>

## [v0.1.9] - 2024-06-13
### Added
- Icons on theme settings.
- Selected rows in `order_list` show up in delete selected button.
- Custom setting page class in `settings.dart`.

### Changed
- Optimized `main` by moving parts to `localization.dart`.
- Optimized imports.
- Final localization.
---
<br>

## [v0.1.8] - 2024-06-13
### Added
- Localization support, some parts in settings missing due to context.
- Extracted functions from order list, long press selection, bold headers.

### Changed
- Reduced gaps between columns in `order_list`.
- Removed checkboxes from `order_list`.
---
<br>

## [v0.1.7] - 2024-06-12
### Added
- About page.
- Dynamic settings title for each navigation destination.
- Database connection settings.
- Merged widgets to `form_functions`.
- Formatted phone number on `order_list`.

### Changed
- Centered scaffold titles.
- Made the vertical divider in nav rail more transparent.
- Darkened dialog barrier color.
---
<br>

## [v0.1.6] - 2024-06-11
### Added
- Automatic table creation with required constraints.

### Changed
- Small file structure change, settings, homepage, and navbar under navigation.
- Error and bug fixes for release.
---
<br>

## [v0.1.5] - 2024-06-10
### Added
- Final, hopefully, form validation in a separate file.
- Handled database client errors in `order_list` and `order_form` files.
- Maximum input length check and other specific form validations.
- Language icons show up.

### Changed
- Fixed undo send order error which was caused because of index being 0.
- Removed dialog windows shadow.
- Updated database name which fixes connection crash.
- Commented the components.
---
<br>

## [v0.1.4] - 2024-06-09
### Changed
- DB IP address input from settings.
- Finally removed every single trace of that default purplish accent.
- Default theme set as system theme while maintaining theme switch functionality.
---
<br>

## [v0.1.3] - 2024-06-07
### Added
- Filled homepage with products including hero views.
- Volume slider to notifications settings.

### Changed
- Dark light mode switch works.
- Got rid of default purplish accent by overriding accent colors.
---
<br>

## [v0.1.2] - 2024-06-07
### Added
- Delete selected order, IDs will refresh on delete.

### Changed
- Fixed icon name under `src/main/AndroidManifest.xml`.
- Row selection now fully works.
- Removed delete last order button from order form and the functions of it.
---
<br>

## [v0.1.1] - 2024-06-06
### Added
- Placeholder text for other settings pages.
- Placeholder toggles on notification settings.
- App theme and language settings in general (working on functionality).
- Home and settings pages.
- Check the type of phone, milk, and egg inputs.
- Check if one of the fields milk, egg, or other is filled.
- Selectable rows, working on functionality.
---
<br>

## [v0.0.2] - 2024-06-05
### Added
- Set custom color scheme.
- Show snackbar when none of the fields milk, egg, and other are filled.
---
<br>

## [v0.0.1] - 2024-05-25
### Added
- Created the project from Flutter template.
- Writing and reading orders from db works.