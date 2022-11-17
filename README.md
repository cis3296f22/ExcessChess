# Excess Chess
Two people can use Excess Chess to play a standard game of chess over the internet, but Excess Chess can do much more. As a chess sandbox, many aspects of the game are configurable. Have you ever wondered what it would be like to have twice as many pawns? Have you ever wondered how chess would be if the board was twice as long? Have you ever thought "I bet I could beat my friend if I had a couple extra knights?" Now you can find out! The board dimensions (length and width) and the piece layout are fully customizable, and can be saved for later matches so you can revisit your favorite setups. With Excess Chess, you can experience fun, novel, and absurd varieties of chess with friends and family.

Adding an screenshot or a mockup of your application in action would be nice.  

![This is a screenshot.](images.png)
# How to run   
1. Download the latest binary for your operating system from the [Release](https://github.com/cis3296f22/ExcessChess/releases) section on GitHub, or see "How to build" below.
2. Find the executable using your file explorer or terminal.
3. Double-click the executable (or enter its path name in a terminal) to start the game.
4. Use the mouse to interact with the in-game window.
### How to build
You will need more than 630 MB of free disk space, excluding this project itself.
1. Run the Godot Engine v3.5.1.
    - Download the archive for your operating system from [GodotEngine.org](https://godotengine.org/download) or [GitHub Releases](https://github.com/godotengine/godot/releases/tag/3.5.1-stable). Download size and total size are each less than 100 MB.
    - Extract the archive.
    - Run the godot executable, for example double-clicking the "Godot_v3.5.1-stable_win64.exe" file.
2. Import the project into godot.
    - Download the [main branch](https://github.com/cis3296f22/ExcessChess/archive/refs/heads/main.zip) of this repository.
    - In the right-hand menu, select "Import." A dialog will appear.
    - Select "Browse" in the dialog.
    - Navigate to and select the ZIP file downloaded from this repository.
    - Select the new "Browse" option that appears.
    - Navigate to and select an empty folder to install the project.
    - Click "Import & Edit."
3. Download and install the standard export templates.
    - In the top-level menu, select "Editor."
    - Click "Manage Export Templates..."
    - Click "Download and Install." Total size is 549.4 MB.
    - After the installation finishes, click "Close."
4. Export the project to an executable binary.
    - In the top-level menu, select "Project."
    - Select "Export..."
    - Across from Presets, select "Add."
    - Choose your operating system.
        - Additional setup may be required for [macOS](https://docs.godotengine.org/en/3.5/tutorials/export/exporting_for_macos.html), [iOS](https://docs.godotengine.org/en/3.5/tutorials/export/exporting_for_ios.html), or [Android](https://docs.godotengine.org/en/3.5/tutorials/export/exporting_for_android.html).
    - Select "Export Project..."
    - Navigate to select the location and name for the new executable.
    - Click "Save."
5. Close godot.
    - Click "Close."
    - In the top-level menu, select "Scene."
    - Press "Quit."

Now you have a game that you can run!

# How to contribute
Follow [[this project board](https://github.com/orgs/cis3296f22/projects/104)] to know the latest status of the project! 