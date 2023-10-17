## INFO
   Executable for DalvikVM (Android), which allows you to obtain the current user ID (Integer), as well as general information about all system and user apps, such as their status (ENABLED/DISABLED/UNINSTALLED), their membership (SYSTEM/USER ), its ID, its package, its path and its common name (Label). It also allows the extraction of app icons to an external path within the device (as PNGs).

## Usage
   For individual execution (outside of an app) the use of `app_process` is recommended. You can define the executable in the global shell variable `CLASSPATH`. Then call app_process to start the execution of the `Main` class.
   ```bash
   export CLASSPATH=/sdcard/app_manager
   app_process / Main
   ```
   ```bash
   adb shell "export CLASSPATH=/sdcard/app_manager; app_process / Main"
   ```
    
   The first line that is printed by default is the user. In case of error the ID will be `null`.
   ```
   USER:<ID>
   ```
   
   Then, all the available apps are printed, following this format:
   ```
   <ENABLED/DISABLED/UNINSTALLED>:<SYSTEM/USER>:<ID>:<PACKAGE>:<PATH>:<LABEL>
   ```
   
   If you want to extract app icons, you must use the `-icon` parameter followed by the destination path.
   ```bash
   export CLASSPATH=/sdcard/app_manager
   app_process / Main -icon /sdcard/icons
   ```
   ```bash
   adb shell "export CLASSPATH=/sdcard/app_manager; app_process / Main -icon /sdcard/icons"
   ```

   By default, icon extraction does not overwrite files, this prevents the extraction of already existing icons in the destination. If you want to ensure that the destination folder is removed first, you must specify the `-rm` parameter.
   ```bash
   export CLASSPATH=/sdcard/app_manager
   app_process / Main -rm -icon /sdcard/icons
   ```
   ```bash
   adb shell "export CLASSPATH=/sdcard/app_manager; app_process / Main -rm -icon /sdcard/icons"
   ```
   
   Impressions change when using icon extraction.
   ```
   icon:<DEST>/<PACKAGE>.png
   ```
   
   If there are apps that do not provide an icon, the following will be printed. In case there is an error during compression to `PNG`, a printout of the exception produced will also be included.
   ```
   null:<PACKAGE>
   ```

## REMARKS   
   > Individual execution is intended for `adb shell` where you have certain configurations and special permissions. If you want to run in a low-privileged shell, you probably won't be able to get information like the current user ID. Also, it is necessary to ensure a suitable environment, it is not recommended to call `/system/bin/app_process` directly if not available by default, it is better to define the path `/system/bin` inside the `PATH` variable.
   
## Credits
* Me (BlassGO)

## License
> The use and distribution of the software is permitted as long as it is not used for commercial purposes and the respective credits are attached. If anyone wants to use it for profit, they should consult me.
