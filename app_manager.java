//By @BlassGO

import android.app.ActivityManager;
import android.app.ActivityThread;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.drawable.Drawable;
import android.os.Looper;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintStream;

public class Main {
    public static void main(String[] args) {
        String str;
        String str2;
        String str3;
        PrintStream printStream = System.out;
        StringBuilder sb = new StringBuilder();
        if (args.length == 0 || (str = NextArg(args, "-icon")) == null) {
            str = null;
            StringBuilder append = sb.append((Object) "USER:");
            try {
                str2 = Integer.toString(ActivityManager.getCurrentUser());
            } catch (RuntimeException | Exception unused) {
                str2 = "null";
            }
            printStream.println(append.append((Object) str2).toString());
        } else {
            new File(str).mkdirs();
        }
        Looper.prepareMainLooper();
        PackageManager packageManager = ActivityThread.systemMain().getSystemContext().getPackageManager();
        for (ApplicationInfo ai : packageManager.getInstalledApplications(8192)) {
            PrintStream printStream2 = System.out;
            StringBuilder sb2 = new StringBuilder();
            if (str == null) {
                try {
                    packageManager.getPackageInfo(ai.packageName, 32);
                    str3 = !ai.enabled ? "DISABLED" : "ENABLED";
                } catch (RuntimeException | Exception unused2) {
                    str3 = "UNINSTALLED";
                }
                printStream2.println(sb2.append((Object) str3).append(":").append((Object) ((ai.flags & 1) != 0 ? "SYSTEM" : "USER")).append(":").append(ai.uid).append(":").append(ai.packageName).append(":").append(ai.publicSourceDir).append(":").append((Object) packageManager.getApplicationLabel(ai)).toString());
            } else {
                StringBuilder append2 = sb2.append(str).append("/");
                String str4 = ai.packageName;
                try {
                    new Main().DrawableAsPng(packageManager.getApplicationIcon(str4), append2.append(str4).append(".png").toString());
                } catch (RuntimeException | Exception unused3) {
                    printStream2.println("null:" + ai.packageName);
                }
            }
        }
    }

    public void DrawableAsJpg(Drawable drawable, String str) {
        int intrinsicWidth = drawable.getIntrinsicWidth();
        int intrinsicHeight = drawable.getIntrinsicHeight();
        Bitmap createBitmap = Bitmap.createBitmap(intrinsicWidth, intrinsicHeight, Bitmap.Config.ARGB_8888);
        Canvas canvas = new Canvas(createBitmap);
        drawable.setBounds(0, 0, intrinsicWidth, intrinsicHeight);
        drawable.draw(canvas);
        try {
            FileOutputStream fileOutputStream = new FileOutputStream(new File(str));
            createBitmap.compress(Bitmap.CompressFormat.JPEG, 100, fileOutputStream);
            fileOutputStream.close();
            PrintStream printStream = System.out;
            printStream.println("icon:" + str);
        } catch (IOException e) {
            e.printStackTrace();
            System.err.println("Cant export as JPEG.");
        }
    }

    public void DrawableAsPng(Drawable drawable, String str) {
        int intrinsicWidth = drawable.getIntrinsicWidth();
        int intrinsicHeight = drawable.getIntrinsicHeight();
        Bitmap createBitmap = Bitmap.createBitmap(intrinsicWidth, intrinsicHeight, Bitmap.Config.ARGB_8888);
        Canvas canvas = new Canvas(createBitmap);
        drawable.setBounds(0, 0, intrinsicWidth, intrinsicHeight);
        drawable.draw(canvas);
        try {
            FileOutputStream fileOutputStream = new FileOutputStream(new File(str));
            createBitmap.compress(Bitmap.CompressFormat.PNG, 100, fileOutputStream);
            fileOutputStream.close();
            PrintStream printStream = System.out;
            printStream.println("icon:" + str);
        } catch (IOException e) {
            e.printStackTrace();
            System.err.println("Cant export as PNG.");
        }
    }

    public static String NextArg(String[] strArr, String str) {
        for (int i = 0; i < strArr.length; i++) {
            if (str.equals(strArr[i]) && i < strArr.length - 1) {
                return strArr[i + 1];
            }
        }
        return null;
    }
}
