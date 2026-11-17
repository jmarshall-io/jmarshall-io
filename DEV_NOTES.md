# Development Notes & Checkpoint

**Last Updated:** 2026-02-01
**Version:** v1.5.0-localization-fixed (plus pending changes)

## Current Status
We have successfully:
1.  **Unified Dependencies**: Removed `flutter_chat_bubble` and implemented a custom chat bubble widget to fix build errors.
2.  **HUD Layout**: Used `SafeArea` in `HudHeader` to prevent overlap with the status bar.
3.  **Localization**: Added `flutter_localizations` and basic `.arb` files (en, es, fr, de, etc.) and a `LanguageSelector`.
4.  **Projects Page Refactor**: Switched from `CarouselSlider` to a responsive **ListView (Mobile)** and **GridView (Desktop)** to fix overflow issues.
5.  **Environment**: Added `update_and_source_bashrc.sh` to help Flutter find the Chrome executable on this system (found in a `.removed` flatpak directory).

## Uncommitted/Recent Changes
- **Projects Page**: `lib/projects.dart` has been updated to use `LayoutBuilder`. It uses a vertical list on mobile.
- **Chrome Helper**: `update_and_source_bashrc.sh` was added and run.

## Next Steps
- [ ] **Verify Projects Page**: Check the new layout on a real mobile device or emulator. Ensuring cards are fully visible and scrollable.
- [ ] **Chat Functionality**: Verify the custom chat bubble implementation works smoothly.
- [ ] **Firebase/CI/CD**: These were part of the initial plan but postponed to fix critical UI/Build issues.

## How to Resume
1.  `git pull` to get the latest code.
2.  Run `./update_and_source_bashrc.sh` if `flutter run -d chrome` fails.
3.  Run `flutter run` to start the app.
