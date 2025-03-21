
# Dynamic Island App

## Overview
Dynamic Island is a SwiftUI-based app that leverages **ActivityKit** to display dynamic activities in a custom, animated UI. The app simulates a signal generation feature, where users can view token details like price and percentage changes in a visually appealing way.

https://github.com/user-attachments/assets/f7b5dff0-7443-466b-ba65-a7f3d535ce5d

The app provides two main functionalities:
1. **Generate Signal** - Displays a signal with token information like price and percentage change.
2. **End Signal** - Ends the current activity with an animation, showing that the signal has been concluded.

## Features
- Animated **Dynamic Island** effect.
- Random token signals (Solana, Ethereum, Bitcoin, Ripple) with price and percentage fluctuations.
- Interactive buttons to generate and end signals.
- Real-time activity update and animation when activities are created or ended.

## Technologies Used
- **SwiftUI** for the user interface.
- **ActivityKit** for managing dynamic island activities.
- **Combine** for state management.

## Project Structure
### `Home.swift`
- The main view of the app, displaying token details and action buttons.
- Manages the animation and transition effects when showing or hiding token details.
  
### `HomeViewModel.swift`
- Handles the business logic of generating and ending activities.
- Generates random signals for token price, percentage change, and whether the signal is positive or negative.

### `WidgetAttributes.swift` (Assumed)
- The `WidgetAttributes` struct is used to define the properties of each token signal, like name, price, and percentage change.

## Installation

### Prerequisites
- Xcode 14 or later
- iOS 16 or later (since ActivityKit is used)

### Steps to Install
1. Clone this repository to your local machine:
   ```bash
   git clone https://github.com/yourusername/Dynamic-Island.git
   ```
   
2. Open the project in Xcode:
   ```bash
   open Dynamic-Island.xcodeproj
   ```

3. Run the app on a physical iPhone or the iOS simulator.

### Run on Physical Device
To use the **Dynamic Island** functionality, you must run the app on a physical device, as it requires ActivityKit, which isn't available in the simulator.

## How to Use

1. **Generate Signal**:
   - Press the **"Generate Signal"** button to create a new random token signal. The token's price, percentage, and trend (up/down) will be displayed dynamically in the island.

2. **End Signal**:
   - Press the **"End Signal"** button to end the current signal activity. The signal display will animate and show that it has ended.

## UI Overview
- The **Dynamic Island** displays token information in an animated, interactive card that includes:
  - Token name (e.g., Solana, Bitcoin, etc.).
  - Current price and the percentage change.
  - A visual representation of the token's status.

## Contributions

Feel free to fork this repository and create a pull request if you have any suggestions or improvements.

## License

This project is licensed under the MIT License.
