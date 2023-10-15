//By @BlassGO
//I must also thank forums with very useful information

import android.app.ActivityManager;
import android.app.ActivityThread;
import android.app.ContextImpl;
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
        if (args.length == 0) {
            str = null;
            StringBuilder append = sb.append((Object) "USER:");
            try {
                str2 = Integer.toString(ActivityManager.getCurrentUser());
            } catch (RuntimeException | Exception unused) {
                str2 = "null";
            }
            printStream.println(append.append((Object) str2).toString());
        } else {
            boolean rm = HasArg(args, "-rm");
            if (str = NextArg(args, "-icon")) != null) {
                File file = new File(str);
                if (rm) {
                    rm(file);
                }
                file.mkdirs();
            }
        }
        Looper.prepareMainLooper();
        ContextImpl systemContext = ActivityThread.systemMain().getSystemContext();
        PackageManager packageManager = systemContext.getPackageManager();
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
                String str3 = ai.packageName;
                String sb3 = sb2.append(str).append("/").append(str3).append(".png").toString();
                if (!new File(sb3).exists()) {
                    try {
                        new Main().DrawableAsPng(loadIcon(str3, systemContext), sb3);
                    } catch (RuntimeException | Exception unused2) {
                        printStream2.println("null:" + ai.packageName);
                    }
                }
            }
        }
    }

    public void DrawableAsJpg(Drawable drawable, String str) {
        int intrinsicWidth = drawable.getIntrinsicWidth();
        int intrinsicHeight = drawable.getIntrinsicHeight();
        Bitmap createBitmap = Bitmap.createBitmap(intrinsicWidth, intrinsicHeight, Bitmap.Config.ARGB_8888);
        Canvas canvas = new Canvas(createBitmap);
        createBitmap.eraseColor(0);
        drawable.setBounds(0, 0, intrinsicWidth, intrinsicHeight);
        drawable.draw(canvas);
        try {
            FileOutputStream fileOutputStream = new FileOutputStream(new File(str));
            createBitmap.compress(Bitmap.CompressFormat.JPEG, 100, fileOutputStream);
            fileOutputStream.flush();
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
        createBitmap.eraseColor(0);
        drawable.setBounds(0, 0, intrinsicWidth, intrinsicHeight);
        drawable.draw(canvas);
        try {
            FileOutputStream fileOutputStream = new FileOutputStream(new File(str));
            createBitmap.compress(Bitmap.CompressFormat.PNG, 100, fileOutputStream);
            fileOutputStream.flush();
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

    public static boolean HasArg(String[] strArr, String str) {
        for (String str2 : strArr) {
            if (str.equals(str2)) {
                return true;
            }
        }
        return false;
    }

    public static void rm(File file) {
        if (file.isDirectory()) {
            for (File file2 : file.listFiles()) {
                rm(file2);
            }
        }
        file.delete();
    }

    public static Drawable loadIcon(String str, Context context) {
        Drawable drawableForDensity;
        PackageManager packageManager = context.getPackageManager();
        if (Build.VERSION.SDK_INT >= 15) {
            try {
                PackageInfo packageInfo = packageManager.getPackageInfo(str, 0);
                Context createPackageContext = context.createPackageContext(str, 2);
                int[] iArr = {320, 240, 213};
                for (int i = 0; i < 3; i++) {
                    try {
                        drawableForDensity = createPackageContext.getResources().getDrawableForDensity(packageInfo.applicationInfo.icon, iArr[i]);
                    } catch (Resources.NotFoundException e) {
                    }
                    if (drawableForDensity != null) {
                        return drawableForDensity;
                    }
                }
            } catch (Exception e2) {
                //Nothing
            }
        }
        try {
            return packageManager.getApplicationInfo(str, 128).loadIcon(packageManager);
        } catch (PackageManager.NameNotFoundException e3) {
            return null;
        }
    }
}
