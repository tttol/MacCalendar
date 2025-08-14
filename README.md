# MacCalendar
<img width="503" height="446" alt="image" src="https://github.com/user-attachments/assets/876003ef-fbcb-4c23-b860-1b913e419819" />
<br>
MacCalendar is a simple calendar application that adds a calendar of current month to your macOS menu bar.

# Features
* Displays the current month's calendar directly in the menu bar.
* Lightweight and easy to use.

# Installation
1. Download binary file from this URL: https://github.com/tttol/MacCalendar/releases/download/1.0.0/MacCalendar.zip
2. Unzip `MacCalendar.zip` and move `MacCalendar.app` to `/Applications`

# Build
### Requirements
* Xcode 16.4 or later
* macOS Sequoia 15.5 or later

### Steps
1.  **Clone the repository:**
    ```sh
    git clone [https://github.com/tttol/MacCalendar.git](https://github.com/tttol/MacCalendar.git)
    cd MacCalendar
    ```
2.  **Open the project in Xcode:**
    ```sh
    xed .
    ```
    Alternatively, you can open the `MacCalendar.xcodeproj` file directly.

3.  **Clean the build folder (Optional but recommended):**
    * From the menu bar, select `Product` > `Clean Build Folder`.(⇧⌘K)
4.  **Build the application:**
    * From the menu bar, select `Product` > `Build`.(⌘B)

5.  **Locate and install the app:**
    After a successful build, `MacCalendar.app` will be located in a path similar to this:
    `/Users/[YourUsername]/Library/Developer/Xcode/DerivedData/MacCalendar-[some-hash]/Build/Products/Debug/`
    Copy `MacCalendar.app` to your `/Applications` folder to install it.

6.  **Run the app:**
    You can now launch MacCalendar from your Applications folder!

# App Icon
<img width="256" height="256" alt="MacCalendar App Icon" src="https://github.com/tttol/MacCalendar/blob/main/MacCalendar/Assets.xcassets/AppIcon.appiconset/icon_256x256.png?raw=true" /><br>
