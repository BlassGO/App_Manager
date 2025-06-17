//By @BlassGO
//I must also thank forums with very useful information

import android.app.ActivityManager;
import android.app.ActivityThread;
import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.res.Resources;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.drawable.Drawable;
import android.os.Build;
import android.os.Looper;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintStream;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

public class Main {
    public Main() {
        super();
    }

    public static void DrawableAsPng(Drawable drawable, String outputPath) {
        if (drawable == null) {
            return;
        }
        int width = drawable.getIntrinsicWidth();
        int height = drawable.getIntrinsicHeight();
        Bitmap bitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888);
        Canvas canvas = new Canvas(bitmap);
        bitmap.eraseColor(0);
        drawable.setBounds(0, 0, width, height);
        drawable.draw(canvas);
        File file = new File(outputPath);
        try {
            FileOutputStream fileOutputStream = new FileOutputStream(file);
            BufferedOutputStream bufferedOutputStream = new BufferedOutputStream(fileOutputStream, 0x2000);
            bitmap.compress(Bitmap.CompressFormat.PNG, 100, bufferedOutputStream);
            bufferedOutputStream.flush();
            bufferedOutputStream.close();
            fileOutputStream.close();
            PrintStream printStream = System.out;
            printStream.println("icon:" + outputPath);
        } catch (IOException e) {
            e.printStackTrace();
            System.err.println("Cant export as PNG.");
        } finally {
            bitmap.recycle();
        }
    }

    public static boolean HasArg(String[] arguments, String targetArg) {
        for (String arg : arguments) {
            if (targetArg.equals(arg)) {
                return true;
            }
        }
        return false;
    }

    public static String NextArg(String[] arguments, String targetArg) {
        for (int i = 0; i < arguments.length; i++) {
            if (targetArg.equals(arguments[i]) && i < arguments.length - 1) {
                return arguments[i + 1];
            }
        }
        return null;
    }

    public static void createZip(String sourceDirPath, String zipFilePath) {
        ZipOutputStream zipOutputStream = null;
        try {
            File sourceDir = new File(sourceDirPath);
            File zipFile = new File(zipFilePath);
            zipOutputStream = new ZipOutputStream(new FileOutputStream(zipFile));
            File[] files = sourceDir.listFiles();
            for (File file : files) {
                if (file.isFile()) {
                    ZipEntry zipEntry = new ZipEntry(file.getName());
                    zipOutputStream.putNextEntry(zipEntry);
                    FileInputStream fileInputStream = new FileInputStream(file);
                    byte[] buffer = new byte[0x400];
                    int bytesRead;
                    while ((bytesRead = fileInputStream.read(buffer)) > 0) {
                        zipOutputStream.write(buffer, 0, bytesRead);
                    }
                    fileInputStream.close();
                    zipOutputStream.closeEntry();
                } else {
                    rm(file);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (zipOutputStream != null) {
                try {
                    zipOutputStream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    public static Drawable loadIcon(String packageName, Context context) {
        PackageManager packageManager = context.getPackageManager();
        if (Build.VERSION.SDK_INT >= 15) {
            try {
                PackageInfo packageInfo = packageManager.getPackageInfo(packageName, 0);
                Context packageContext = context.createPackageContext(packageName, 2);
                int[] density = {320, 240, 213};
                for (int d : density) {
                    try {
                        Drawable drawable = packageContext.getResources().getDrawableForDensity(packageInfo.applicationInfo.icon, d);
                        if (drawable != null) {
                            return drawable;
                        }
                    } catch (Resources.NotFoundException e) {
                        // Continue to next density
                    }
                }
            } catch (Exception e) {
                // Skip
            }
        }
        try {
            return packageManager.getApplicationInfo(packageName, 128).loadIcon(packageManager);
        } catch (PackageManager.NameNotFoundException e) {
            return null;
        }
    }

    public static void main(String[] args) {
        String iconPath;
        String userId;
        String appStatus;
        PrintStream printStream = System.out;
        StringBuilder sb = new StringBuilder();
        if (args.length == 0) {
            iconPath = null;
            sb.append("USER:");
            try {
                userId = Integer.toString(ActivityManager.getCurrentUser());
            } catch (RuntimeException | Exception e) {
                userId = "null";
            }
            sb.append(userId);
            printStream.println(sb.toString());
        } else {
            boolean shouldRemove = HasArg(args, "-rm");
            iconPath = NextArg(args, "-icon");
            if (iconPath != null) {
                File dir = new File(iconPath);
                if (shouldRemove) {
                    rm(dir);
                }
                dir.mkdirs();
            }
        }
        Looper.prepareMainLooper();
        Context systemContext = ActivityThread.systemMain().getSystemContext();
        PackageManager packageManager = systemContext.getPackageManager();
        for (ApplicationInfo appInfo : packageManager.getInstalledApplications(8192)) {
            StringBuilder appDetails = new StringBuilder();
            if (iconPath == null) {
                try {
                    packageManager.getPackageInfo(appInfo.packageName, 32);
                    appStatus = appInfo.enabled ? "ENABLED" : "DISABLED";
                } catch (RuntimeException | Exception e) {
                    appStatus = "UNINSTALLED";
                }
                appDetails.append(appStatus).append(":");
                appDetails.append((appInfo.flags & 1) != 0 ? "SYSTEM" : "USER").append(":");
                appDetails.append(appInfo.uid).append(":");
                appDetails.append(appInfo.packageName).append(":");
                appDetails.append(appInfo.publicSourceDir).append(":");
                appDetails.append(packageManager.getApplicationLabel(appInfo));
                printStream.println(appDetails.toString());
            } else {
                String packageName = appInfo.packageName;
                String filePath = new StringBuilder()
                        .append(iconPath).append("/")
                        .append(packageName).append(".png")
                        .toString();
                if (!new File(filePath).exists()) {
                    try {
                        DrawableAsPng(loadIcon(packageName, systemContext), filePath);
                    } catch (RuntimeException | Exception e) {
                        printStream.println("null:" + packageName);
                    }
                }
            }
        }
        if (iconPath != null) {
            String zipPath = NextArg(args, "-zip");
            if (zipPath != null) {
                createZip(iconPath, zipPath);
            }
        }
    }

    public static void rm(File file) {
        if (file.isDirectory()) {
            for (File subFile : file.listFiles()) {
                rm(subFile);
            }
        }
        file.delete();
    }
}