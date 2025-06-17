# INFO
Executable for DalvikVM (Android) that retrieves the current user ID (Integer) and detailed information about all system and user apps, including their status (ENABLED/DISABLED/UNINSTALLED), membership (SYSTEM/USER), ID, package, path, and common name (Label). It also supports extracting app icons to an external path as PNGs and optionally zipping them.

## Usage
For standalone execution (outside an app), use `app_process`. Set the executable in the global shell variable `CLASSPATH`, then call `app_process` to run the `Main` class:
```bash
adb shell "export CLASSPATH=/sdcard/app_manager; app_process / Main"
```

### Retrieve User and App Information
Running without arguments prints the current user ID first. If an error occurs, the ID will be `null`:
```
USER:<ID>
```
Followed by details of all available apps in this format:
```
<ENABLED/DISABLED/UNINSTALLED>:<SYSTEM/USER>:<ID>:<PACKAGE>:<PATH>:<LABEL>
```

### Extract App Icons
To extract app icons, use the `-icon` parameter followed by the destination path:
```bash
adb shell "export CLASSPATH=/sdcard/app_manager; app_process / Main -icon /sdcard/icons"
```
Icon extraction skips existing files to avoid overwrites. To ensure the destination folder is cleared first, add the `-rm` parameter:
```bash
adb shell "export CLASSPATH=/sdcard/app_manager; app_process / Main -rm -icon /sdcard/icons"
```
Output changes to show extracted icons:
```
icon:<DEST>/<PACKAGE>.png
```
If an app lacks an icon or PNG compression fails, the output includes the error:
```
null:<PACKAGE>
```

### Extract and Zip App Icons
To extract icons and create a zip file, combine `-icon` with `-zip` followed by the zip file path:
```bash
adb shell "export CLASSPATH=/sdcard/app_manager; app_process / Main -icon /sdcard/icons -zip /sdcard/icons.zip"
```
This extracts icons to the specified path (as above) and creates a zip file containing all extracted PNGs. Use `-rm` with `-icon` to clear the destination folder before extraction, if needed.

## REMARKS
> Standalone execution is designed for `adb shell` with specific configurations and permissions. In a low-privileged shell, information like the current user ID may be unavailable. Ensure a suitable environment; avoid calling `/system/bin/app_process` directly unless available by default. Instead, include `/system/bin` in the `PATH` variable.

## Credits
* Me ([BlassGO](https://github.com/BlassGO))

## License
> The software may be used and distributed for non-commercial purposes with proper credits. For commercial use, please contact me.