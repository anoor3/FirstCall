# FirstCall

FirstCall is a SwiftUI iOS app that helps people act quickly and calmly during common emergencies. It presents clear steps, a guided mode that walks users through actions one by one, and quick actions like calling emergency services.

## Features

- Browse emergency topics by category with a calm dark UI
- Search by topic name
- Detailed view with symptoms and step by step actions
- Guided Mode that advances through each step with progress and accessibility friendly animations
- Quick Actions for calling emergency services and preparing to share location
- Theming helpers for consistent typography and colors

## Requirements

- Xcode 15 or newer
- iOS 16.0 or newer deployment target
- Swift 5 and SwiftUI

## Quick Start

- Open `FIRST CALL/FirstCall.xcodeproj` in Xcode
- Select an iPhone simulator or a connected device
- Build and Run

Tip: There is also a `FIRST CALL/FIRST CALL.xcodeproj` that corresponds to an alternate copy of the sources. The primary target in this repo is the `FirstCall` project that lives under `FIRST CALL/FirstCall`.

## Project Structure

- `FIRST CALL/FirstCall/FirstCallApp.swift` entry point with a dark appearance by default
- `FIRST CALL/FirstCall/Views` screens like `HomeView`, `EmergencyDetailView`, `GuidedModeView`
- `FIRST CALL/FirstCall/Components` reusable UI components like `GuideProgressHeader`, `PrimaryActionButton`, `StepCard`
- `FIRST CALL/FirstCall/Models` core models `EmergencyTopic`, `EmergencyStep`, `EmergencyCategory`
- `FIRST CALL/FirstCall/Data` in app sample data `EmergencySampleData`
- `FIRST CALL/FirstCall/Theme` shared colors and typography helpers
- `FIRST CALL/FirstCall/Assets.xcassets` app assets and icons
- `FIRST CALL/FIRST CALL/Resources/Illustrations` optional step illustrations used by `StepIllustrationView` with a README for setup
- `FIRST CALL/tools` scripts for logo generation and AppIcon building

## Using the App

- Browse and search emergencies on the Home screen
- Open a topic to review symptoms and what to do
- Start Guided Mode to follow clear actions one step at a time
- Use the Emergency Actions bar to place a call to `911` and to view the location sheet placeholder

## Customization

- Change the emergency call number
  - Open `FIRST CALL/FirstCall/Components/EmergencyActionBar.swift`
  - Update the `callNumber` default from `"911"` to a local emergency number

- Add or edit topics and steps
  - Open `FIRST CALL/FirstCall/Data/EmergencySampleData.swift`
  - Modify existing `EmergencyTopic` entries or add new ones to the `topics` array

- Add step illustrations
  - Place image files in `FIRST CALL/FIRST CALL/Resources/Illustrations`
  - Ensure file names match `illustrationName` values referenced by your views
  - See the README in that folder for exact naming tips and how to add the folder to the Xcode target

## Assets and Icons

- Generate a simple logo PNG set on macOS
  - Run `xcrun swift FIRST\ CALL/tools/generate_logo.swift` from the repo root
  - Images write to `FIRST CALL/Assets.xcassets/AppLogo.imageset`

- Build AppIcon sizes from a 1024 image
  - Ensure `FIRST CALL/Assets.xcassets/AppLogo.imageset/logo-1024.png` exists
  - Run `bash FIRST\ CALL/tools/build_appicon.sh`
  - Outputs to `FIRST CALL/FirstCall/Assets.xcassets/AppIcon.appiconset`

## Accessibility

- Respects the Reduce Motion setting for transitions in Guided Mode
- Uses large, high contrast typography in a calm dark theme
- VoiceOver friendly labels for navigation and action buttons

## Testing

- UI tests and a placeholder unit test target are included under the `FIRST CALL` project folders
- In Xcode select Product then Test to run available tests

## Notes

- The repository contains two similarly named project folders. The `FIRST CALL/FirstCall.xcodeproj` project with sources in `FIRST CALL/FirstCall` is the main path described above.
